import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:story_app/di/injection.dart';
import 'package:story_app/pages/story/domain/entities/story_detail_entity.dart';
import 'package:story_app/pages/story/domain/entities/story_entity.dart';
import 'package:story_app/pages/story/domain/use_cases/story_use_case.dart';
import 'package:story_app/utils/check_connection.dart';

part 'story_state.dart';

class StoryCubit extends Cubit<StoryState> {
  StoryCubit() : super(StoryInitial());
  StoryUseCase storyUseCase = sl<StoryUseCase>();
  List<Placemark>? placemarks;
  File? photo;
  Position? position;
  int page = 0;
  List<ListStoryEntity>? listStory;

  void getStories({int? location = 0, int? size = 15}) async {
    emit(OnLoadingGetStory(isFirstFetch: page == 0 ? true : false));
    try {
      bool connection = await checkConnection();
      print(connection);
      if (connection) {
        var res = await storyUseCase.getStories(
            location: location, page: page, size: size);
        res.fold((l) => emit(OnErrorGetStory(message: l.message)), (r) {
          if ((listStory ?? []).isNotEmpty) {
            listStory?.addAll(r.listStory ?? []);
          } else {
            listStory = r.listStory;
          }
          page++;
          emit(OnSuccessGetStory(data: r));
        });
      } else {
        emit(OnErrorGetStory(message: "Check your connection"));
      }
    } catch (e) {
      emit(OnErrorGetStory());
    }
  }

  void getDetailStories({String? id}) async {
    emit(OnLoadingGetDetailStory());
    try {
      var res = await storyUseCase.getDetailStory(id);
      res.fold((l) => emit(OnErrorGetDetailStory()),
          (r) => emit(OnSuccessGetDetailStory(data: r)));
    } catch (e) {
      emit(OnErrorGetDetailStory());
    }
  }

  void postStory(
      {File? file, String? description, double? lat, double? lon}) async {
    emit(OnLoadingPostStory());
    try {
      var res = await storyUseCase.postStory(
          file: photo,
          description: description,
          lat: position?.latitude ?? 0,
          lon: position?.longitude ?? 0);
      res.fold((l) => emit(OnErrorPostStory(message: l.message)),
          (r) => emit(OnSuccessPostStory(message: r.data['message'])));
    } catch (e) {
      emit(OnErrorPostStory());
    }
  }

  void getImage({required ImageSource source}) async {
    try {
      XFile? file = await ImagePicker().pickImage(
        source: source,
        imageQuality: 30,
      );
      if (file != null) {
        photo = File(file.path);
        emit(OnGetImage(file: File(file.path)));
      }
    } catch (e) {
      rethrow;
    }
  }

  checkPermission() async {
    try {
      LocationPermission? permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        print("permission: $permission");
        await Geolocator.requestPermission();
      } else {
        getPosition();
      }
    } catch (e) {
      rethrow;
    }
  }

  getPosition() async {
    try {
      position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best,
          forceAndroidLocationManager: true);
    } catch (e) {
      rethrow;
    }
  }
}

import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:story_app/di/injection.dart';
import 'package:story_app/pages/story/domain/entities/story_detail_entity.dart';
import 'package:story_app/pages/story/domain/entities/story_entity.dart';
import 'package:story_app/pages/story/domain/use_cases/story_use_case.dart';
import 'package:story_app/utils/check_connection.dart';

part 'story_cubit.freezed.dart';
part 'story_state.dart';

class StoryCubit extends Cubit<StoryState> {
  StoryCubit() : super(const StoryState.initial());
  StoryUseCase storyUseCase = sl<StoryUseCase>();
  List<Placemark>? placemarks;
  File? photo;
  Position? position;
  int page = 0;
  List<ListStoryEntity>? listStory;

  void getStories({int? location = 0, int? size = 15}) async {
    if (page == 0) {
      emit(StoryState.loadingGetStory(isFirstFetch: page == 0 ? true : false));
    }
    try {
      bool connection = await checkConnection();
      if (connection) {
        var res = await storyUseCase.getStories(
            location: location, page: page, size: size);
        res.fold((l) => emit(StoryState.errorGetStory(message: l.message)),
            (r) {
          if ((listStory ?? []).isNotEmpty) {
            listStory?.addAll(r.listStory ?? []);
          } else {
            listStory = r.listStory;
          }
          page++;
          emit(StoryState.successGetStory(data: r));
        });
      } else {
        emit(StoryState.errorGetStory(message: "Check your connection"));
      }
    } catch (e) {
      emit(StoryState.errorGetStory());
    }
  }

  void getDetailStories({String? id}) async {
    emit(StoryState.loadingGetDetailStory());
    try {
      var res = await storyUseCase.getDetailStory(id);
      res.fold((l) => emit(StoryState.errorGetDetailStory()),
          (r) => emit(StoryState.successGetDetailStory(data: r)));
    } catch (e) {
      emit(StoryState.errorGetDetailStory());
    }
  }

  void postStory(
      {File? file, String? description, double? lat, double? lon}) async {
    emit(StoryState.loadingPostStory());
    try {
      var res = await storyUseCase.postStory(
          file: photo, description: description, lat: lat, lon: lon);
      res.fold((l) => emit(StoryState.errorPostStory(message: l.message)),
          (r) => emit(StoryState.successPostStory(message: r.data['message'])));
    } catch (e) {
      emit(StoryState.errorPostStory());
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
        emit(StoryState.getImage(file: File(file.path)));
      }
    } catch (e) {
      rethrow;
    }
  }
}

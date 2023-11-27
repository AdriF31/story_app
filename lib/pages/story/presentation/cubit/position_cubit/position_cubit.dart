import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'position_cubit.freezed.dart';
part 'position_state.dart';

class PositionCubit extends Cubit<PositionState> {
  PositionCubit() : super(const PositionState.initial());
  Position? position;
  LatLng? coordinate;

  void checkPermission() async {
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

  void getPosition() async {
    emit(const PositionState.loading());
    try {
      position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best,
          forceAndroidLocationManager: true);
      coordinate = LatLng(position?.latitude ?? 0, position?.longitude ?? 0);
      emit(PositionState.success(
          position: LatLng(position?.latitude ?? 0, position?.longitude ?? 0)));
    } catch (e) {
      rethrow;
    }
  }

  void changePosition({LatLng? coordinates}) async {
    coordinate = coordinates;
    emit(PositionState.success(position: coordinates));
  }
}

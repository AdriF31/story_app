part of 'position_cubit.dart';

@freezed
class PositionState with _$PositionState {
  const factory PositionState.initial() = _Initial;
  const factory PositionState.loading() = _Loading;
  const factory PositionState.success({LatLng? position}) = _Success;
}

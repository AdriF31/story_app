part of 'story_cubit.dart';

@freezed
class StoryState with _$StoryState {
  const factory StoryState.initial() = _Initial;
  const factory StoryState.loadingGetStory({bool? isFirstFetch}) =
      _LoadingGetStory;
  const factory StoryState.successGetStory(
      {StoryEntity? data, List<Placemark>? placemark}) = _SuccessGetStory;
  const factory StoryState.errorGetStory({String? message}) = _ErrorGetStory;
  const factory StoryState.loadingPostStory() = _LoadingPostStory;
  const factory StoryState.successPostStory({String? message}) =
      _SuccessPostStory;
  const factory StoryState.errorPostStory({String? message}) = _ErrorPostStory;
  const factory StoryState.loadingGetDetailStory() = _LoadingGetDetailStory;
  const factory StoryState.successGetDetailStory(
      {StoryDetailEntity? data, Placemark? placemark}) = _SuccessGetDetailStory;
  const factory StoryState.errorGetDetailStory({String? message}) =
      _ErrorGetDetailStory;
  const factory StoryState.getImage({File? file}) = _GetImage;
}

// class StoryInitial extends StoryState {}
//
// class OnLoadingGetStory extends StoryState {
//   bool? isFirstFetch;
//   OnLoadingGetStory({this.isFirstFetch});
//   @override
//   List<Object?> get props => [isFirstFetch];
// }
//
// class OnSuccessGetStory extends StoryState {
//   StoryEntity? data;
//   Placemark? placemark;
//   OnSuccessGetStory({this.data, this.placemark});
//   @override
//   List<Object?> get props => [data, placemark];
// }
//
// class OnErrorGetStory extends StoryState {
//   String? message;
//   OnErrorGetStory({this.message});
//   @override
//   List<Object?> get props => [message];
// }
//
// class OnLoadingPostStory extends StoryState {}
//
// class OnSuccessPostStory extends StoryState {
//   String? message;
//   OnSuccessPostStory({this.message});
//   @override
//   List<Object?> get props => [message];
// }
//
// class OnErrorPostStory extends StoryState {
//   String? message;
//   OnErrorPostStory({this.message});
//   @override
//   List<Object?> get props => [message];
// }
//
// class OnLoadingGetDetailStory extends StoryState {}
//
// class OnSuccessGetDetailStory extends StoryState {
//   StoryDetailEntity? data;
//   Placemark? placemark;
//   OnSuccessGetDetailStory({this.data, this.placemark});
//   @override
//   List<Object?> get props => [data, placemark];
// }
//
// class OnErrorGetDetailStory extends StoryState {
//   String? message;
//   OnErrorGetDetailStory({this.message});
//   @override
//   List<Object?> get props => [message];
// }
//
// class OnGetImage extends StoryState {
//   File? file;
//   OnGetImage({this.file});
//   @override
//   List<Object?> get props => [file];
// }

part of 'story_cubit.dart';

@immutable
abstract class StoryState extends Equatable {
  @override
  List<Object?> get props => [];
}

class StoryInitial extends StoryState {}

class OnLoadingGetStory extends StoryState {
  bool? isFirstFetch;
  OnLoadingGetStory({this.isFirstFetch});
  @override
  List<Object?> get props => [isFirstFetch];
}

class OnSuccessGetStory extends StoryState {
  StoryEntity? data;
  Placemark? placemark;
  OnSuccessGetStory({this.data, this.placemark});
  @override
  List<Object?> get props => [data, placemark];
}

class OnErrorGetStory extends StoryState {
  String? message;
  OnErrorGetStory({this.message});
  @override
  List<Object?> get props => [message];
}

class OnLoadingPostStory extends StoryState {}

class OnSuccessPostStory extends StoryState {
  String? message;
  OnSuccessPostStory({this.message});
  @override
  List<Object?> get props => [message];
}

class OnErrorPostStory extends StoryState {
  String? message;
  OnErrorPostStory({this.message});
  @override
  List<Object?> get props => [message];
}

class OnLoadingGetDetailStory extends StoryState {}

class OnSuccessGetDetailStory extends StoryState {
  StoryDetailEntity? data;
  Placemark? placemark;
  OnSuccessGetDetailStory({this.data, this.placemark});
  @override
  List<Object?> get props => [data, placemark];
}

class OnErrorGetDetailStory extends StoryState {
  String? message;
  OnErrorGetDetailStory({this.message});
  @override
  List<Object?> get props => [message];
}

class OnGetImage extends StoryState {
  File? file;
  OnGetImage({this.file});
  @override
  List<Object?> get props => [file];
}

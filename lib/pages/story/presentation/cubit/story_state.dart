part of 'story_cubit.dart';

@immutable
abstract class StoryState extends Equatable {
  @override
  List<Object?> get props => [];
}

class StoryInitial extends StoryState {}

class OnLoadingGetStory extends StoryState {}

class OnSuccessGetStory extends StoryState {
  StoryEntity? data;
  Placemark? placemark;
  OnSuccessGetStory({this.data, this.placemark});
  @override
  List<Object?> get props => [data, placemark];
}

class OnErrorGetStory extends StoryState {}

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

class OnGetImage extends StoryState {
  File? file;
  OnGetImage({this.file});
  @override
  List<Object?> get props => [file];
}

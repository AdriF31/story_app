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
  OnSuccessGetStory({this.data});
  @override
  List<Object?> get props => [data];
}

class OnErrorGetStory extends StoryState {}

class OnLoadingPostStory extends StoryState {}

class OnSuccessPostStory extends StoryState {
  Response? data;
  OnSuccessPostStory({this.data});
  @override
  List<Object?> get props => [data];
}

class OnErrorPostStory extends StoryState {}


class OnGetImage extends StoryState{
  File? file;
  OnGetImage({this.file});
  @override
  List<Object?> get props => [file];
}

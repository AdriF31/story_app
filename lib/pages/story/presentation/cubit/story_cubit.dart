import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:story_app/di/injection.dart';
import 'package:story_app/pages/story/domain/entities/story_entity.dart';
import 'package:story_app/pages/story/domain/use_cases/story_use_case.dart';

part 'story_state.dart';

class StoryCubit extends Cubit<StoryState> {
  StoryCubit() : super(StoryInitial());
  StoryUseCase storyUseCase = sl<StoryUseCase>();

  void getStories() async {
    emit(OnLoadingGetStory());
    try {
      var res = await storyUseCase.getStories();
      res.fold((l) => emit(OnErrorGetStory()),
          (r) => emit(OnSuccessGetStory(data: r)));
    } catch (e) {
      emit(OnErrorGetStory());
    }
  }
}

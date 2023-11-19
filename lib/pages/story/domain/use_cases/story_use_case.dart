import 'package:dartz/dartz.dart';
import 'package:story_app/core/error/failure.dart';
import 'package:story_app/pages/story/domain/entities/story_entity.dart';
import 'package:story_app/pages/story/domain/repositories/story_repository.dart';

import '../../../../di/injection.dart';

class StoryUseCase{
  final StoryRepository storyRepository = sl<StoryRepository>();

  Future<Either<Failure, StoryEntity>> getStories() {
    return storyRepository.getListStory();
  }
}
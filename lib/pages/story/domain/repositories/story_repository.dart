import 'package:dartz/dartz.dart';
import 'package:story_app/core/error/failure.dart';
import 'package:story_app/pages/story/domain/entities/story_entity.dart';

abstract class StoryRepository{
  Future<Either<Failure,StoryEntity>> getListStory();
}
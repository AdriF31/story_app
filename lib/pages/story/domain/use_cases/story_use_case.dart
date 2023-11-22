import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:story_app/core/error/failure.dart';
import 'package:story_app/pages/story/domain/entities/story_detail_entity.dart';
import 'package:story_app/pages/story/domain/entities/story_entity.dart';
import 'package:story_app/pages/story/domain/repositories/story_repository.dart';

import '../../../../di/injection.dart';

class StoryUseCase {
  final StoryRepository storyRepository = sl<StoryRepository>();

  Future<Either<Failure, StoryEntity>> getStories() {
    return storyRepository.getListStory();
  }

  Future<Either<Failure, StoryDetailEntity>> getDetailStory(String? id) {
    return storyRepository.getDetailStory(id);
  }

  Future<Either<Failure, Response>> postStory(
      {File? file, String? description, double? lat, double? lon}) {
    return storyRepository.postStory(
        file: file, description: description, lat: lat, lon: lon);
  }
}

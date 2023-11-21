import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:story_app/core/error/failure.dart';
import 'package:story_app/pages/story/domain/entities/story_entity.dart';

abstract class StoryRepository{
  Future<Either<Failure,StoryEntity>> getListStory();
  Future<Either<Failure,Response>> postStory({File? file, String? description, double? lat, double? lon});
}
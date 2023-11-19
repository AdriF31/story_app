import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:story_app/core/error/exception.dart';
import 'package:story_app/core/error/failure.dart';
import 'package:story_app/di/injection.dart';
import 'package:story_app/pages/story/data/data_source/remote_data_source.dart';
import 'package:story_app/pages/story/domain/entities/story_entity.dart';
import 'package:story_app/pages/story/domain/repositories/story_repository.dart';

class StoryRepositoryImpl extends StoryRepository {
  StoryRemoteDataSource storyRemoteDataSource = sl<StoryRemoteDataSource>();

  @override
  Future<Either<Failure, StoryEntity>> getListStory() async {
    try {
      var res = await storyRemoteDataSource.getStory();
      return Right(res);
    } on ServerException {
      return const Left(ServerFailure("An error has Occured"));
    } on SocketException {
      return const Left(ConnectionFailure("Check your internet connection"));
    }
  }
}

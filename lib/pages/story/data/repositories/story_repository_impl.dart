import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/src/response.dart';
import 'package:story_app/core/error/exception.dart';
import 'package:story_app/core/error/failure.dart';
import 'package:story_app/di/injection.dart';
import 'package:story_app/pages/story/data/data_source/story_remote_data_source.dart';
import 'package:story_app/pages/story/domain/entities/story_detail_entity.dart';
import 'package:story_app/pages/story/domain/entities/story_entity.dart';
import 'package:story_app/pages/story/domain/repositories/story_repository.dart';

class StoryRepositoryImpl extends StoryRepository {
  StoryRemoteDataSource storyRemoteDataSource = sl<StoryRemoteDataSource>();

  @override
  Future<Either<Failure, StoryEntity>> getListStory(
      {int? location, int? page, int? size}) async {
    try {
      var res = await storyRemoteDataSource.getStory(
          location: location, page: page, size: size);
      return Right(res);
    } on ServerException {
      return const Left(ServerFailure("An error has Occured"));
    } on SocketException {
      return const Left(ConnectionFailure("Check your internet connection"));
    }
  }

  @override
  Future<Either<Failure, Response>> postStory(
      {File? file, String? description, double? lat, double? lon}) async {
    try {
      var res = await storyRemoteDataSource.postStory(
          file: file, description: description, lat: lat, lon: lon);
      return Right(res);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on SocketException {
      return const Left(ConnectionFailure("Check your internet connection"));
    }
  }

  @override
  Future<Either<Failure, StoryDetailEntity>> getDetailStory(String? id) async {
    try {
      var res = await storyRemoteDataSource.getDetailStory(id);
      return Right(res);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on SocketException {
      return const Left(ConnectionFailure("Check your internet connection"));
    }
  }
}

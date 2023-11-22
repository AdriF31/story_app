import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:story_app/core/error/exception.dart';
import 'package:story_app/core/error/failure.dart';
import 'package:story_app/pages/authentication/data/data_source/auth_remote_data_source.dart';
import 'package:story_app/pages/authentication/domain/entities/login_entity.dart';
import 'package:story_app/pages/authentication/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRemoteDataSource authRemoteDataSource = AuthRemoteDataSourceImpl();

  @override
  Future<Either<Failure, LoginEntity>> login(
      {String? email, String? password}) async {
    try {
      var res =
          await authRemoteDataSource.login(email: email, password: password);
      return Right(res);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on SocketException {
      return const Left(ConnectionFailure("Check your internet connection"));
    }
  }

  @override
  Future<Either<Failure, Response>> register(
      {String? name, String? email, String? password}) async {
    try {
      var res = await authRemoteDataSource.register(
          name: name, email: email, password: password);
      return Right(res);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on SocketException {
      return const Left(ConnectionFailure("Check your internet connection"));
    }
  }
}

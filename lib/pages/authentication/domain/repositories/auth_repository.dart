import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:story_app/core/error/failure.dart';
import 'package:story_app/pages/authentication/domain/entities/login_entity.dart';

abstract class AuthRepository {
  Future<Either<Failure, LoginEntity>> login(
      {String? email, String? password});
  Future<Either<Failure, Response>> register(
      {String? name, String? email, String? password});
}

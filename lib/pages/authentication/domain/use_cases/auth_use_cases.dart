import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:story_app/core/error/failure.dart';
import 'package:story_app/pages/authentication/domain/entities/login_entity.dart';
import 'package:story_app/pages/authentication/domain/repositories/auth_repository.dart';

import '../../../../di/injection.dart';

class AuthUseCase {
  final AuthRepository authRepository = sl<AuthRepository>();

  Future<Either<Failure, LoginEntity>> login(
      {String? name, String? email, String? password}) {
    return authRepository.login(email: email, password: password);
  }

  Future<Either<Failure, Response>> register(
      {String? name, String? email, String? password}) {
    return authRepository.register(
        name: name, email: email, password: password);
  }
}

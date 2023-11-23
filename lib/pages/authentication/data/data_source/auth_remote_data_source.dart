import 'dart:io';

import 'package:dio/dio.dart';
import 'package:story_app/core/error/exception.dart';
import 'package:story_app/core/network.dart';
import 'package:story_app/di/injection.dart';
import 'package:story_app/pages/authentication/data/models/login_model.dart';

abstract class AuthRemoteDataSource {
  Future<LoginModel> login({String? email, String? password});

  Future<Response> register({String? name, String? email, String? password});
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  Network network = sl<Network>();

  @override
  Future<LoginModel> login({String? email, String? password}) async {
    try {
      var res = await network.dio
          .post("/login", data: {"email": email, "password": password});
      if (res.statusCode == 200) {
        return LoginModel.fromJson(res.data);
      } else {
        throw ServerException(message: res.data?['message']);
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError ||
          e.type == DioExceptionType.connectionTimeout) {
        throw const SocketException("Check your internet connection");
      } else {
        throw ServerException(message: e.response?.data['message']);
      }
    }
  }

  @override
  Future<Response> register(
      {String? name, String? email, String? password}) async {
    try {
      var res = await network.dio.post("/register",
          data: {"name": name, "email": email, "password": password});
      if (res.statusCode == 201) {
        return res;
      } else {
        throw ServerException(message: res.data['message']);
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError ||
          e.type == DioExceptionType.connectionTimeout) {
        throw const SocketException("Check your internet connection");
      } else {
        throw ServerException(message: e.response?.data['message']);
      }
    }
  }
}

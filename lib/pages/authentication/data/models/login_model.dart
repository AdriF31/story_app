// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

import 'package:story_app/pages/authentication/domain/entities/login_entity.dart';

LoginModel loginModelFromJson(String str) =>
    LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel extends LoginEntity {
  final bool? error;
  final String? message;
  final LoginResult? loginResult;

  const LoginModel({
    this.error,
    this.message,
    this.loginResult,
  }) : super(error: error, message: message, loginResult: loginResult);

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        error: json["error"],
        message: json["message"],
        loginResult: json["loginResult"] == null
            ? null
            : LoginResult.fromJson(json["loginResult"]),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "loginResult": loginResult?.toJson(),
      };
}

class LoginResult extends LoginResultEntity {
  final String? userId;
  final String? name;
  final String? token;

  const LoginResult({
    this.userId,
    this.name,
    this.token,
  }) : super(userId: userId, name: name, token: token);

  factory LoginResult.fromJson(Map<String, dynamic> json) => LoginResult(
        userId: json["userId"],
        name: json["name"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "name": name,
        "token": token,
      };
}

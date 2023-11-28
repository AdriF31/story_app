// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:story_app/pages/authentication/domain/entities/login_entity.dart';

part 'login_model.g.dart';

@JsonSerializable()
class LoginModel extends LoginEntity {
  final bool? error;
  final String? message;
  final LoginResult? loginResult;

  const LoginModel({
    this.error,
    this.message,
    this.loginResult,
  }) : super(error: error, message: message, loginResult: loginResult);

  factory LoginModel.fromJson(Map<String, dynamic> json) =>
      _$LoginModelFromJson(json);

  Map<String, dynamic> toJson() => _$LoginModelToJson(this);
}

@JsonSerializable()
class LoginResult extends LoginResultEntity {
  final String? userId;
  final String? name;
  final String? token;

  const LoginResult({
    this.userId,
    this.name,
    this.token,
  }) : super(userId: userId, name: name, token: token);

  factory LoginResult.fromJson(Map<String, dynamic> json) =>
      _$LoginResultFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResultToJson(this);
}

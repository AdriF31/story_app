part of 'auth_bloc.dart';

@immutable
abstract class AuthState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoginLoading extends AuthState {}

class AuthLoginSuccess extends AuthState {
  LoginEntity? data;
  AuthLoginSuccess({this.data});

  @override
  List<Object?> get props => [data];
}

class AuthLoginError extends AuthState {
  String? message;
  AuthLoginError({this.message});
  @override
  List<Object?> get props => [message];
}

class AuthRegisterLoading extends AuthState {}

class AuthRegisterSuccess extends AuthState {
  String? message;
  AuthRegisterSuccess({this.message});

  @override
  List<Object?> get props => [message];
}

class AuthRegisterError extends AuthState {
  String? message;
  AuthRegisterError({this.message});
  @override
  List<Object?> get props => [message];
}

class Obscured extends AuthState {
  bool? isObscured;
  Obscured({this.isObscured});
  @override
  // TODO: implement props
  List<Object?> get props => [isObscured];
}

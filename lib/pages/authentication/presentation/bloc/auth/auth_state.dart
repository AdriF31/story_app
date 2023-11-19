part of 'auth_bloc.dart';

@immutable
abstract class AuthState extends Equatable{
  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {

}

class AuthLoginLoading extends AuthState{}

class AuthLoginSuccess extends AuthState{
  LoginEntity? data;
  AuthLoginSuccess({this.data});

  @override
  List<Object?> get props => [data];
}

class AuthLoginError extends AuthState{}

class AuthRegisterLoading extends AuthState{}

class AuthRegisterSuccess extends AuthState{
  Response? data;
  AuthRegisterSuccess({this.data});

  @override
  List<Object?> get props => [data];
}

class AuthRegisterError extends AuthState{}

class Obscured extends AuthState{
  bool? isObscured;
  Obscured({this.isObscured});
  @override
  // TODO: implement props
  List<Object?> get props => [isObscured];
}




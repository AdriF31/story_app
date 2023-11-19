part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class OnLogin extends AuthEvent{
  String? email;
  String? password;
  OnLogin({this.email,this.password});
}

class OnRegister extends AuthEvent{
  String? name;
  String? email;
  String? password;
  OnRegister({this.name,this.email,this.password});
}

class ObscurePassword extends AuthEvent{
  bool? isObscure;
  ObscurePassword({this.isObscure});
}



import 'package:equatable/equatable.dart';

class LoginEntity extends Equatable{
const LoginEntity({this.error,this.message,this.loginResult});
final bool? error;
final String? message;
final LoginResultEntity? loginResult;

  @override
  List<Object?> get props =>[error,message,loginResult];
}

class LoginResultEntity extends Equatable{
  const LoginResultEntity({this.userId,this.name,this.token});
  final String? userId;
  final String? name;
  final String? token;

  @override
  List<Object?> get props => [userId,name,token];
}
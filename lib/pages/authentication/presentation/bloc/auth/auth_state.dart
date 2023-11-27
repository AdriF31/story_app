part of 'auth_bloc.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState.initial() = _Initial;
  const factory AuthState.loginLoading() = _LoginLoading;
  const factory AuthState.loginSuccess({LoginEntity? data}) = _LoginSuccess;
  const factory AuthState.loginError({String? message}) = _LoginError;
  const factory AuthState.registerLoading() = _RegisterLoading;
  const factory AuthState.registerSuccess({String? message}) = _RegisterSuccess;
  const factory AuthState.registerError({String? message}) = _RegisterError;
  const factory AuthState.obscured({bool? isObscured}) = _Obscured;
}

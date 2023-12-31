import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:story_app/di/injection.dart';
import 'package:story_app/pages/authentication/domain/entities/login_entity.dart';
import 'package:story_app/pages/authentication/domain/use_cases/auth_use_cases.dart';
import 'package:story_app/utils/secure_storage.dart';

part 'auth_bloc.freezed.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  bool? obscured = true;
  AuthBloc() : super(const AuthState.initial()) {
    AuthUseCase authUseCase = sl<AuthUseCase>();

    on<AuthEvent>((event, emit) async {
      if (event is OnLogin) {
        emit(const AuthState.loginLoading());
        try {
          var res = await authUseCase.login(
              email: event.email, password: event.password);

          res.fold((l) => emit(AuthState.loginError(message: l.message)),
              (r) async {
            emit(AuthState.loginSuccess(data: r));
            await SecureStorage.setToken(value: r.loginResult?.token);
          });
        } catch (e) {
          emit(AuthState.loginError(message: e.toString()));
        }
      }
      if (event is OnRegister) {
        emit(const AuthState.registerLoading());
        try {
          var res = await authUseCase.register(
              name: event.name, email: event.email, password: event.password);

          res.fold((l) => emit(AuthState.registerError(message: l.message)),
              (r) {
            emit(AuthState.registerSuccess(message: r.data['message']));
          });
        } catch (e) {
          emit(const AuthState.registerError());
        }
      }
      if (event is ObscurePassword) {
        obscured = event.isObscure;
        emit(AuthState.obscured(isObscured: event.isObscure));
      }
    });
  }
}

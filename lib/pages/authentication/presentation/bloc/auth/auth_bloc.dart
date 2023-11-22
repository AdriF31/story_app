import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:story_app/di/injection.dart';
import 'package:story_app/pages/authentication/domain/entities/login_entity.dart';
import 'package:story_app/pages/authentication/domain/use_cases/auth_use_cases.dart';
import 'package:story_app/utils/secure_storage.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  bool? obscured = true;
  AuthBloc() : super(AuthInitial()) {
    AuthUseCase authUseCase = sl<AuthUseCase>();

    on<AuthEvent>((event, emit) async {
      if (event is OnLogin) {
        emit(AuthLoginLoading());
        try {
          var res = await authUseCase.login(
              email: event.email, password: event.password);

          res.fold((l) => emit(AuthLoginError(message: l.message)), (r) async {
            emit(AuthLoginSuccess(data: r));
            await SecureStorage.setToken(value: r.loginResult?.token);
          });
        } catch (e) {
          emit(AuthLoginError(message: e.toString()));
        }
      }
      if (event is OnRegister) {
        emit(AuthRegisterLoading());
        try {
          var res = await authUseCase.register(
              name: event.name, email: event.email, password: event.password);

          res.fold((l) => emit(AuthRegisterError(message: l.message)), (r) {
            emit(AuthRegisterSuccess(message: r.data['message']));
          });
        } catch (e) {
          emit(AuthRegisterError());
        }
      }
      if (event is ObscurePassword) {
        obscured = event.isObscure;
        emit(Obscured(isObscured: event.isObscure));
      }
    });
  }
}

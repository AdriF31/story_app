import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:story_app/pages/authentication/presentation/bloc/auth/auth_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:story_app/pages/authentication/presentation/pages/login/login_view.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(),
      child: const AnnotatedRegion<SystemUiOverlayStyle>(value: SystemUiOverlayStyle.dark,child: LoginView()),
    );
  }
}

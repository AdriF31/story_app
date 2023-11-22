import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:story_app/common.dart';
import 'package:story_app/pages/authentication/presentation/bloc/auth/auth_bloc.dart';
import 'package:story_app/routes/routes.dart';
import 'package:story_app/utils/app_decoration.dart';
import 'package:story_app/utils/elevated_button_widget.dart';
import 'package:story_app/utils/theme/text_style.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> form = GlobalKey<FormState>();

    TextEditingController emailController = TextEditingController();

    TextEditingController passwordController = TextEditingController();

    bool? isObscured = true;

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.login),
        centerTitle: true,
      ),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (_, state) {
          if (state is AuthLoginSuccess) {
            Fluttertoast.showToast(msg: state.data?.message ?? "");
            context.go(listStoryRoute);
          }
          if (state is AuthLoginError) {
            Fluttertoast.showToast(msg: state.message ?? "");
          }
          if (state is Obscured) {
            isObscured = state.isObscured;
          }
        },
        builder: (_, state) {
          return Center(
            child: SingleChildScrollView(
              child: Form(
                key: form,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Semantics(
                        label: "Email TextField",
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppLocalizations.of(context)!.email,
                              semanticsLabel: "Email",
                              style: text18WhiteRegular,
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            TextFormField(
                              controller: emailController,
                              decoration: customInputDecoration(
                                hintText: "Email",
                                prefixIcon: const Icon(
                                  FluentIcons.mail_24_regular,
                                  size: 28,
                                ),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return AppLocalizations.of(context)!
                                      .email_empty_error;
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.password,
                            semanticsLabel: "Password",
                            style: text18WhiteRegular,
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          TextFormField(
                            controller: passwordController,
                            obscureText: isObscured!,
                            decoration: customInputDecoration(
                                hintText: "Password",
                                prefixIcon: const Icon(
                                  FluentIcons.key_24_regular,
                                  size: 28,
                                ),
                                suffixIcon: IconButton(
                                    onPressed: () {
                                      if (isObscured!) {
                                        context.read<AuthBloc>().add(
                                            ObscurePassword(isObscure: false));
                                      } else {
                                        context.read<AuthBloc>().add(
                                            ObscurePassword(isObscure: true));
                                      }
                                    },
                                    icon: Icon(isObscured!
                                        ? FluentIcons.eye_24_regular
                                        : FluentIcons.eye_off_24_regular))),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return AppLocalizations.of(context)!
                                    .password_empty_error;
                              }
                              if (value.length < 8) {
                                return AppLocalizations.of(context)!
                                    .password_length_error;
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      ElevatedButtonWidget(
                        onPressed: () {
                          if (form.currentState!.validate()) {
                            context.read<AuthBloc>().add(OnLogin(
                                email: emailController.text,
                                password: passwordController.text));
                          }
                        },
                        buttonText: AppLocalizations.of(context)!.login,
                        isLoading: state is AuthLoginLoading,
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      RichText(
                        text: TextSpan(
                          text: AppLocalizations.of(context)!.dont_have_account,
                          style: text14WhiteMedium,
                          children: <WidgetSpan>[
                            WidgetSpan(
                              child: GestureDetector(
                                onTap: () {
                                  context.push("/register");
                                },
                                child: Text(
                                  AppLocalizations.of(context)!.register,
                                  style: text14WhiteBold,
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

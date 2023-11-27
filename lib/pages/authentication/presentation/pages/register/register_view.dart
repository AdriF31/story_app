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

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> form = GlobalKey<FormState>();
    TextEditingController nameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    bool? isObscured = true;
    bool? isLoading = false;
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.register),
        centerTitle: true,
      ),
      body: Center(
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (_, state) {
            state.maybeWhen(
                registerSuccess: (message) {
                  Fluttertoast.showToast(msg: message ?? "");
                  context.go(loginRoute);
                },
                registerError: (message) {
                  Fluttertoast.showToast(msg: message ?? "");
                },
                obscured: (obscured) {
                  isObscured = obscured;
                },
                orElse: () {});
            isLoading = state.maybeWhen(
                registerLoading: () => true, orElse: () => false);
          },
          builder: (_, state) {
            return SingleChildScrollView(
              child: Form(
                key: form,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Semantics(
                        label: "Username TextField",
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppLocalizations.of(context)!.username,
                              semanticsLabel: "Username",
                              style: text18WhiteRegular,
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            TextFormField(
                              controller: nameController,
                              decoration: customInputDecoration(
                                hintText: "Username",
                                prefixIcon: const Icon(
                                  FluentIcons.person_24_regular,
                                  size: 28,
                                ),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return AppLocalizations.of(context)!
                                      .name_error;
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
                                if (RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                        .hasMatch(emailController.text) ==
                                    false) {
                                  return AppLocalizations.of(context)!
                                      .email_not_valid;
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
                            context.read<AuthBloc>().add(OnRegister(
                                name: nameController.text,
                                email: emailController.text,
                                password: passwordController.text));
                          }
                        },
                        buttonText: AppLocalizations.of(context)!.register,
                        isLoading: isLoading,
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      RichText(
                        text: TextSpan(
                          text: AppLocalizations.of(context)!.have_account,
                          style: text14WhiteMedium,
                          children: <WidgetSpan>[
                            WidgetSpan(
                              child: GestureDetector(
                                onTap: () {
                                  context.pop();
                                },
                                child: Text(
                                  AppLocalizations.of(context)!.login,
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
            );
          },
        ),
      ),
    );
  }
}

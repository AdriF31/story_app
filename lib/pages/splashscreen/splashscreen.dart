import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:story_app/routes/routes.dart';
import 'package:story_app/utils/secure_storage.dart';
import 'package:story_app/utils/theme/text_style.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    checkLoginStatus();
    super.initState();
  }

  void checkLoginStatus() async {
    print(await SecureStorage.getToken());
    Future.delayed(const Duration(seconds: 2), () async {
      if (await SecureStorage.getToken() != null &&
          (await SecureStorage.getToken()).isNotEmpty) {
        print("token not null");
        context.go(listStoryRoute);
      } else {
        print("token null");
        context.go(loginRoute);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          "Story App",
          style: text18WhiteBold,
        ),
      ),
    );
  }
}

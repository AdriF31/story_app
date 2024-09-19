import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:story_app/pages/authentication/presentation/pages/login/login_page.dart';
import 'package:story_app/pages/authentication/presentation/pages/register/register_page.dart';
import 'package:story_app/pages/splashscreen/splashscreen.dart';
import 'package:story_app/pages/story/presentation/bottom_navigation/bottom_navigaton.dart';
import 'package:story_app/pages/story/presentation/list_story/list_story_page.dart';
import 'package:story_app/pages/story/presentation/post_story/post_story_page.dart';
import 'package:story_app/pages/story/presentation/story_detail/story_detail_page.dart';

import '../core/app/app.dart';
import '../main.dart';

const splashScreenRoute = "/";
const loginRoute = "/login";
const registerRoute = "/register";
const listStoryRoute = "/list_story";
const postStoryRoute = "/postStory";
const detailStoryRoute = "/detailStory";
const bottomNavigationRoute = "/bottomNavigation";
final GoRouter router =
    GoRouter(navigatorKey: alice.getNavigatorKey(), routes: <RouteBase>[
  GoRoute(
    path: splashScreenRoute,
    name: "splashscreen",
    builder: (BuildContext context, GoRouterState state) {
      return const SplashScreen();
    },
  ),
  GoRoute(
    path: loginRoute,
    name: "login",
    builder: (BuildContext context, GoRouterState state) {
      return const LoginPage();
    },
  ),
  GoRoute(
    path: registerRoute,
    name: "register",
    builder: (BuildContext context, GoRouterState state) {
      return const RegisterPage();
    },
  ),
  GoRoute(
      path: listStoryRoute,
      name: "list_story",
      builder: (BuildContext context, GoRouterState state) {
        return const ListStoryPage();
      },
      routes: <RouteBase>[]),
  GoRoute(
      path: detailStoryRoute,
      name: "detail_story",
      builder: (BuildContext context, GoRouterState state) {
        String? id = state.extra as String;
        return StoryDetailPage(
          id: id,
        );
      }),
  GoRoute(
    path: postStoryRoute,
    name: "post_story",
    builder: (BuildContext context, GoRouterState state) {
      VoidCallback? callback = state.extra as VoidCallback;
      return PostStoryPage(
        callback: callback,
      );
    },
  ),
  GoRoute(
    path: bottomNavigationRoute,
    name: "bottom_navigation",
    builder: (BuildContext context, GoRouterState state) {
      return const BottomNavigation();
    },
  ),
]);

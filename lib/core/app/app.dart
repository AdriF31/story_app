import 'package:alice/alice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:story_app/core/language/language_cubit.dart';
import 'package:story_app/routes/routes.dart';
import 'package:story_app/utils/theme/app_theme.dart';

import '../../common.dart';

late Alice alice;

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LanguageCubit()..getLanguage(code: 'en'),
      child: BlocBuilder<LanguageCubit, LocaleState>(
        builder: (_, state) {
          return MaterialApp.router(
            title: "Story App",
            debugShowCheckedModeBanner: false,
            locale:
                Locale(state is LocaleInitial ? state.locale ?? "en" : 'en'),
            supportedLocales: const [
              Locale('en', 'US'),
              Locale('id', 'ID'),
            ],
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            theme: AppTheme.darkTheme,
            routerConfig: router,
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_flavor/flutter_flavor.dart';
import 'package:story_app/core/app/app.dart';
import 'package:story_app/di/injection.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  FlavorConfig(
    name: "premium",
    variables: {"premium": true},
  );

  runApp(const App());
}

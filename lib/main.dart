import 'package:flutter/material.dart';
import 'package:story_app/core/app/app.dart';
import 'package:story_app/di/injection.dart' as di;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp( const App());
}





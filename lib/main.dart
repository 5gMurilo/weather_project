import 'package:flutter/material.dart';
import 'package:flutter_wheater/src/view/splash_screen.dart';

void main(List<String> args) {
  runApp(
    MainApp(),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreen(),
    );
  }
}

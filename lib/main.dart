import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:subanimals/routes.dart';
import 'package:subanimals/screens/auth/auth_screen.dart';


void main() {
  SharedPreferences.setMockInitialValues({});
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Sub Animals",
      debugShowCheckedModeBanner: false,
      theme: _buildDarkTheme(),
      home: AuthScreen('signUp'),
      routes: routes()
    );
  }

  ThemeData _buildDarkTheme() {
    final baseTheme = ThemeData(
      fontFamily: "Open Sans",
    );
    return baseTheme.copyWith(
      brightness: Brightness.dark,
      primaryColor: Color(0xFF143642),
      primaryColorLight: Color(0xFF26667d),
      primaryColorDark: Color(0xFF08161b),
      primaryColorBrightness: Brightness.dark,
      accentColor: Colors.white,
      errorColor: Colors.greenAccent
    );
  }
}

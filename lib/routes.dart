import 'package:flutter/material.dart';

import 'package:subanimals/utils/constants.dart';
import 'package:subanimals/screens/home/home_screen.dart';
import 'package:subanimals/screens/auth/signin/controller.dart' as signIn;
import 'package:subanimals/screens/auth/signup/controller.dart' as signup;
import 'package:subanimals/screens/settings/settings_screen.dart';


routes () {
  dynamic routes = <String, WidgetBuilder>{
    screenHome: (BuildContext context) => HomePage(),
    screenSettings: (BuildContext context) => SettingsPage(),
    screenSignIn: (BuildContext context) => signIn.Controller(),
    screenSignUp: (BuildContext context) => AuthScreen('signUp'),
  };

  return routes;
}
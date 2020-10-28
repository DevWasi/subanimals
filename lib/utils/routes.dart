import 'package:flutter/material.dart';

import 'package:subanimals/utils/constants.dart';
import 'package:subanimals/screens/common/common.dart';
import 'package:subanimals/screens/home/home_screen.dart';
import 'package:subanimals/screens/settings/settings_screen.dart';


routes () {
  dynamic routes = <String, WidgetBuilder>{
    screenHome: (BuildContext context) => HomePage(),
    screenSettings: (BuildContext context) => SettingsPage(),
    screenSignIn: (BuildContext context) => AuthPage('signin'),
    screenSignUp: (BuildContext context) => AuthPage('signup'),
  };

  return routes;
}
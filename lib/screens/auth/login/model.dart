import 'package:flutter/material.dart';
import 'package:subanimals/screens/auth/auth_screen.dart';

Map model = {
  "entities": [
    {
      "attribute": "email",
      "label": "Email",
      "type": "text",
      "cursor_color": Colors.white,
      "icon": Icons.email,
      "text_color": TextStyle(color: Colors.white70),
      "initial_value": "wasibiit@gmail.com",
      "border": UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
      ),
    },
    {
      "attribute": "password",
      "label": "Password",
      "type": "password",
      "cursor_color": Colors.white,
      "icon": Icons.lock,
      "text_color": TextStyle(color: Colors.white70),
      "initial_value": "123456",
      "border": UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white70)),
    }
  ],
  "instance": AuthScreenState(),
  "entity": "login",
  "actions": [
    {
      "name": "signIn",
      "type": "submit",
      "color": Colors.white70,
      "text_style": TextStyle(fontSize: 15),
      "alignment": Alignment.center,
      "padding": EdgeInsets.symmetric(vertical: 15.0, horizontal: 50.0),
      "shape":
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(40.0))
    }
  ]
};
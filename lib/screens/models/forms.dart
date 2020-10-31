import 'package:flutter/material.dart';

import 'package:subanimals/utils/manager.dart';
import 'package:subanimals/screens/auth/auth_screen.dart';
import 'package:subanimals/common/validator.dart';
import 'package:subanimals/screens/auth/login/model.dart';

getModel(entity) {
  Map model = {
    "signIn": {
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
    },
    "signUp": {
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
      "actions": [
        {
          "name": "signUp",
          "type": "submit",
          "color": Colors.white70,
          "text_style": TextStyle(fontSize: 15),
          "alignment": Alignment.center,
          "padding": EdgeInsets.symmetric(vertical: 15.0, horizontal: 50.0),
          "shape":
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(40.0))
        }
      ]
    }
  };
  return model[entity];
}

getFields(entity, formskey, context, scaffoldKey) {
  Map model = getModel(entity);
  List actions = model["actions"];
  List<Widget> fields = [];
  model["entities"].forEach((entity) {
    switch (entity['type']) {
      case 'password': fields.add(passwordField(entity));
        break;
      default: fields.add(textField(entity));
      break;
    }
    fields.add(SizedBox(height: 30.0));
  });
  actions.forEach((action) {
    fields.add(formButton(action, entity, formskey, context, scaffoldKey));
  });
  return fields;
}

passwordField(attribute){
  return TextFormField(
    textInputAction: attribute['input_action'],
    validator: (value) {
      return validateString(attribute['label'], value);
    },
    onSaved: (value) async {
      final _prefs = await PreferenceManager.getInstance();
      _prefs.setItem(attribute['label'], value);
    },
    cursorColor: attribute['cursor_color'],
    obscureText: true,
    style: attribute['text_color'],
    initialValue: attribute['initial_value'],
    decoration: InputDecoration(
        icon: Icon(attribute['icon']),
        border: attribute['border'],
        labelStyle: attribute['text_color'],
        labelText: attribute['label']
    ),
  );
}

textField(attribute){
  return TextFormField(
    textInputAction: attribute['input_action'],
    validator: (value) {
      String text;
      if(value.isNotEmpty){
        text = validateString(attribute['label'], value);
      }else if(value.isEmpty) {
        text = 'All Fields Are Required';
      }
      return text;
    },
    onSaved: (value) async {
      final _prefs = await PreferenceManager.getInstance();
      _prefs.setItem(attribute['label'], value);
    },
    cursorColor: attribute['cursor_color'],
    style: attribute['text_color'],
    initialValue: attribute['initial_value'],
    decoration: InputDecoration(
        icon: Icon(attribute['icon']),
        border: attribute['border'],
        labelStyle: attribute['text_color'],
        labelText: attribute['label']
    ),
  );
}

formButton(action, entity, formkey, context, scaffoldKey) {
  return Container(
    alignment: action['alignment'],
    child: RaisedButton(
        shape: action['shape'],
        padding: action['padding'],
        color: action['color'],
        child: Text(action['name'].toUpperCase(), style: action['text_style']),
        onPressed: () {
          model["instance"].submitForm(entity, formkey, context, scaffoldKey);
        }
    ),
  );
}
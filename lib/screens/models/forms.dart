import 'package:flutter/material.dart';

import 'package:subanimals/utils/manager.dart';
import 'package:subanimals/screens/common/common.dart';


getActions(entity) {
  List actions;
  switch (entity) {
    case "signup":
      actions = [
        {"name": "signup", "type": "submit"}
      ];
      break;
    case "signin":
      actions = [
        {"name": "signin", "type": "submit"}
      ];
      break;
  }

  return actions;
}

getModel(entity) {
  List model;
  switch (entity) {
    case 'signup':
      model = [
        {"attribute": "email", "label": "Email", "type": "text",
          "cursor_color": Colors.white, "icon": Icons.email},
        {"attribute": "password", "label": "Password", "type": "password",
        "cursor_color": Colors.white, "icon": Icons.lock}
      ];
      break;
    case 'signin':
      model = [
        {"attribute": "email", "label": "Email", "type": "text",
        "cursor_color": Colors.white, "icon": Icons.email},
        {"attribute": "password", "label": "Password", "type": "password",
        "cursor_color": Colors.white, "icon": Icons.lock}
      ];
      break;
  }

  return model;
}

getFields(entity, formskey, context, scaffoldKey) {
  List model = getModel(entity);
  List actions = getActions(entity);
  List<Widget> fields = [];
  model.forEach((attribute) {
    switch (attribute['type']) {
      case 'password': fields.add(passwordField(attribute));
        break;
      default: fields.add(textField(attribute));
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
    textInputAction: TextInputAction.done,
    validator: (value) {
      return validateString(attribute['label'], value);
    },
    onSaved: (value) async {
      final _prefs = await PreferenceManager.getInstance();
      _prefs.setItem(attribute['label'], value);
    },
    cursorColor: attribute['cursor_color'],
    obscureText: true,
    style: TextStyle(color: Colors.white70),
    decoration: InputDecoration(
      icon: Icon(attribute['icon']),
      hintText: attribute['label'],
      border:
      UnderlineInputBorder(borderSide: BorderSide(color: Colors.white70)),
      hintStyle: TextStyle(color: Colors.white70),
    ),
  );
}

textField(attribute){
  return TextFormField(
    textInputAction: TextInputAction.done,
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
    style: TextStyle(color: Colors.white70),
    decoration: InputDecoration(
      icon: Icon(attribute['icon']),
      hintText: attribute['label'],
      border:
      UnderlineInputBorder(borderSide: BorderSide(color: Colors.white70)),
      hintStyle: TextStyle(color: Colors.white70),
    ),
  );
}

formButton(action, entity, formskey, context, scaffoldKey) {
  AuthPageState _instance = AuthPageState();
  return Container(
    alignment: Alignment.center,
    child: FlatButton(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
      color: Colors.white70,
      child: new Text(action['name'].toUpperCase(), style: TextStyle(fontSize: 15 )),
      onPressed: () {_instance.submitForm(entity, formskey, context, scaffoldKey);}
    ),
  );
}

String validateString(String key, String value) {
  if (value.isEmpty) {

    return key + ' Is Required';
  } else if (key == 'Email' &&
      !RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
          .hasMatch(value)) {

    return 'Please Enter A Valid Email';
  } else if(key == 'Password' && value.length < 6) {

    return 'Password must be 6 digit long';
  } else {

    return null;
  }
}
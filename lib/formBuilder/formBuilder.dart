import 'package:flutter/material.dart';
import 'package:subanimals/formBuilder/validator.dart';
import 'package:subanimals/common/commonController.dart';

import 'package:subanimals/utils/manager.dart';

getFields(model, formskey, context, scaffoldKey) {
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
  model["actions"].forEach((action) {
    fields.add(formButton(action, formskey, context, scaffoldKey));
  });
  return fields;
}

passwordField(entity){
  return TextFormField(
    textInputAction: entity['input_action'],
    validator: (value) {
      return validateString(entity['label'], value);
    },
    onSaved: (value) async {
      final _prefs = await PreferenceManager.getInstance();
      _prefs.setItem(entity['label'], value);
    },
    cursorColor: entity['cursor_color'],
    obscureText: true,
    style: entity['text_color'],
    initialValue: entity['initial_value'],
    decoration: InputDecoration(
        icon: Icon(entity['icon']),
        border: entity['border'],
        labelStyle: entity['text_color'],
        labelText: entity['label']
    ),
  );
}

textField(entity){
  return TextFormField(
    textInputAction: entity['input_action'],
    validator: (value) {
      String text;
      if(value.isNotEmpty){
        text = validateString(entity['label'], value);
      }else if(value.isEmpty) {
        text = 'All Fields Are Required';
      }
      return text;
    },
    onSaved: (value) async {
      final _prefs = await PreferenceManager.getInstance();
      _prefs.setItem(entity['label'], value);
    },
    cursorColor: entity['cursor_color'],
    style: entity['text_color'],
    initialValue: entity['initial_value'],
    decoration: InputDecoration(
        icon: Icon(entity['icon']),
        border: entity['border'],
        labelStyle: entity['text_color'],
        labelText: entity['label']
    ),
  );
}

formButton(action, formkey, context, scaffoldKey) {
  return Container(
    alignment: action['alignment'],
    child: RaisedButton(
        shape: action['shape'],
        padding: action['padding'],
        color: action['color'],
        child: Text(action['name'].toUpperCase(), style: action['text_style']),
        onPressed: () {
          CommonController({}).submitForm(action['name'], formkey, context, scaffoldKey);
        }
    ),
  );
}
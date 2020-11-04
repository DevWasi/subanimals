import 'package:subanimals/common/commonView.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:subanimals/utils/constants.dart';
import 'package:subanimals/screens/common/common.dart';
import 'package:subanimals/remote/request/request_handler.dart';

class CommonController {
  Map model;
  CommonController(this.model);

  submitForm(entity, formskey, context, scaffoldKey) async {
    String path;
    if (formskey.currentState.validate()) {
      formskey.currentState.save();
      dynamic body = await createMap(entity);

      scaffoldKey.currentState.showSnackBar(buidSnackBar("---entity"));
      switch (entity) {
        case 'signIn': path = '/auth/attempt';
        break;
        case 'signUp': path = '/customers';
        break;
      }
      RequestHandler().post(path, body: body).then((value) {
        switch(entity) {
          case 'signIn':
            switch(value) {
              case '200': Navigator.popAndPushNamed(context, screenHome);
              break;
              case '400': scaffoldKey.currentState
                  .showSnackBar(buidSnackBar(entity));
              break;
            }
            break;
          case 'signUp':
            switch(value) {
              case '200':Navigator.popAndPushNamed(context, screenHome);
              break;
              case '422': scaffoldKey.currentState
                  .showSnackBar(buidSnackBar(entity));
            }
            break;
        }
      });
    }
  }
}
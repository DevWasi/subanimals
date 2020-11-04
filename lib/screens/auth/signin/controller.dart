import 'package:flutter/material.dart';
import 'package:subanimals/common/commonController.dart';
import 'package:subanimals/screens/auth/signin/model.dart';
import 'package:subanimals/screens/auth/signin/view.dart';

class Controller extends CommonController {
  Controller():super(model) {
    View();
  }
}
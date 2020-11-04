import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:subanimals/utils/constants.dart';
import 'package:subanimals/formBuilder/formBuilder.dart';
import 'package:subanimals/screens/common/common.dart';
import 'package:subanimals/remote/request/request_handler.dart';

class CommonView extends StatefulWidget {

  final Map model;
  CommonView(this.model);

  @override
  CommonViewState createState() => CommonViewState();

}

class CommonViewState extends State<CommonView> {
  RequestHandler _client = RequestHandler();
  GlobalKey<FormState> formKey =  new GlobalKey();
  final scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light
        .copyWith(statusBarColor: Colors.transparent));

    return Scaffold(
      key: scaffoldKey,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.grey[600], Colors.grey[900]],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter),
        ),
        child: ListView(
          children: <Widget>[
            headerSection(widget.model["name"]),
            SizedBox(height: 30.0),
            Padding(
              padding: const EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 0.0),
              child: Form(
                key: formKey,
                child: Column(
                    children: getFields(widget.model, formKey, context, scaffoldKey)
                ),
              ),
            ),
            SizedBox(height: 30.0),
            Divider(
              color: Colors.white,
              endIndent: 80.0,
              indent: 80.0,
            ),
            textButton(widget.model["name"]),
            // _buildFacebookButton(),
            // SizedBox(height: 30.0),
            // _buildGoogleButton()
          ],
        ),
      ),
    );
  }

  // getForm(entity, formKey, context, scaffoldKey) {
  //   return
  // }

  textButton(text) {
    switch(text) {
      case 'signUp':
        return Container(
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 50.0),
          alignment: Alignment.center,
          child: GestureDetector(
            onTap: () {Navigator.popAndPushNamed(context, screenSignIn);},
            child: Text(
              'Already Have An Account?',
              style: TextStyle(fontSize: 15, color: Colors.white70),
            ),
          ),
        );
        break;
      case 'signIn':
        return Container(
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 50.0),
          alignment: Alignment.center,
          child: GestureDetector(
            onTap: () {Navigator.popAndPushNamed(context, screenSignUp);},
            child: Text(
              'Create New Account',
              style: TextStyle(fontSize: 15, color: Colors.white70),
            ),
          ),
        );
        break;
    }
  }
}
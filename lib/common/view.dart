import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:subanimals/utils/constants.dart';
import 'package:subanimals/screens/models/forms.dart';
import 'package:subanimals/screens/common/common.dart';
import 'package:subanimals/remote/request/request_handler.dart';

class View extends StatefulWidget {

  final String name;
  View(this.name);

  @override
  ViewState createState() => ViewState();

}

class ViewState extends State<View> {
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
            headerSection(widget.name.toUpperCase()),
            SizedBox(height: 30.0),
            Padding(
              padding: const EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 0.0),
              child: Form(
                key: formKey,
                child: Column(
                    children: getForm(entity, formKey, context, scaffoldKey)
                ),
              ),
            ),
            SizedBox(height: 30.0),
            Divider(
              color: Colors.white,
              endIndent: 80.0,
              indent: 80.0,
            ),
            textButton(widget.name),
            // _buildFacebookButton(),
            // SizedBox(height: 30.0),
            // _buildGoogleButton()
          ],
        ),
      ),
    );
  }

  getForm(entity, formKey, context, scaffoldKey) {
    return
  }

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

  // Widget _buildFacebookButton() {
  //   return Container(
  //     width: MediaQuery.of(context).size.width,
  //     height: 40.0,
  //     padding: EdgeInsets.symmetric(horizontal: 15.0),
  //     margin: EdgeInsets.only(top: 15.0),
  //     child: RaisedButton.icon(
  //       color: Colors.indigoAccent,
  //       onPressed: () async {
  //         final _prefs = await PreferenceManager.getInstance();
  //         dynamic token = await signUpWithFacebook();
  //         if (_prefs.getItem("token") == token) {
  //           Navigator.popAndPushNamed(context, screenHome);
  //         } else if (_prefs.getItem("token") != token) {
  //           scaffoldKey.currentState
  //               .showSnackBar(buidSnackBar("LOGIN FAILED"));
  //         }
  //       },
  //       icon: Icon(
  //         FontAwesomeIcons.facebookF,
  //         size: 30.0,
  //       ),
  //       label: Text("SIGN UP WITH FACEBOOK"),
  //       shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(18.0),
  //           side: BorderSide(color: Colors.black)),
  //     ),
  //   );
  // }

  // Widget _buildGoogleButton() {
  //   return Container(
  //     width: MediaQuery.of(context).size.width,
  //     height: 40.0,
  //     padding: EdgeInsets.symmetric(horizontal: 15.0),
  //     margin: EdgeInsets.only(top: 15.0),
  //     child: RaisedButton.icon(
  //       color: Colors.white,
  //       onPressed: () {signIn();},
  //       icon: Icon(
  //         FontAwesomeIcons.googlePlusG,
  //         size: 30.0,
  //       ),
  //       label: Text("SIGN UP WITH GOOGLE"),
  //       shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(18.0),
  //           side: BorderSide(color: Colors.black)),
  //     ),
  //   );
  // }

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
      _client.post(path, body: body).then((value) {
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
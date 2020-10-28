import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:subanimals/utils/manager.dart';
import 'package:subanimals/utils/constants.dart';
import 'package:subanimals/screens/models/forms.dart';
import 'package:subanimals/remote/request/request_handler.dart';
import 'package:subanimals/screens/auth/googleauth/google_login.dart';
import 'package:subanimals/screens/auth/facebookauth/facebook_login.dart';

Widget appBar(String name, dynamic context) {
  String text;
  switch(name) {
    case 'signin' : text = 'signup'.toUpperCase();
    break;
    case 'signup' : text = 'signin'.toUpperCase();
  }
  return AppBar(
    actions: <Widget>[
      Container(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        child: RaisedButton(
          color: Colors.grey[400],
          child: Text(text),
          onPressed: () {
            switch (name) {
              case 'signin': Navigator.popAndPushNamed(context, screenSignUp);
              break;
              case 'signup': Navigator.popAndPushNamed(context, screenSignIn);
            }

          },
        ),
      ),
    ],
  );
}

Widget headerSection(String name) {
  return Container(
    margin: EdgeInsets.only(top: 50.0),
    padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
    child: Center(
      child: Text(name,
          style: TextStyle(
              color: Colors.white70,
              fontSize: 40.0,
              fontWeight: FontWeight.bold)),
    ),
  );
}

buidSnackBar(String value) {
  return new SnackBar(
    content: new Text(
        value.toUpperCase() +' FAILED',
        style: TextStyle(color: Colors.white)
    ),
    duration: new Duration(seconds: 3),
    backgroundColor: Colors.black,
  );
}

Future<dynamic> createMap(String key) async {
  var map = new Map<String, dynamic>();
  var user = new Map<String, dynamic>();
  final _prefs = await PreferenceManager.getInstance();
  map['device_type'] = 'android';
  map['device_id'] = 'DeviceTokenGeneratedViaFMC';
  switch(key) {
    case "signup":
      map['username'] = _prefs.getItem("Email");
      map['password'] = _prefs.getItem("Password");
      user["customer"] = map;
      break;
    case "signin":
      map['username'] = _prefs.getItem("Email");
      map['password'] = _prefs.getItem("Password");
      map['app'] = 'customer';
      user["session"] = map;
      break;
    case "facebook_login":
      map['app'] = 'customer';
      map['access_token'] = await _prefs.getItem("token");
      user["facebook"] = map;
      break;
  }

  return user;
}

class AuthPage extends StatefulWidget {
  final String name;
  AuthPage(this.name);

  @override
  AuthPageState createState() => AuthPageState();

}

class AuthPageState extends State<AuthPage> {
  RequestHandler _client = RequestHandler();
  GlobalKey<FormState> formKey =  new GlobalKey();
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light
        .copyWith(statusBarColor: Colors.transparent));
    return Scaffold(
      appBar: appBar(widget.name, context),
      key: scaffoldKey,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.grey[800], Colors.grey[900]],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter),
        ),
        child: ListView(
          children: <Widget>[
            headerSection(widget.name.toUpperCase()),
            SizedBox(height: 30.0),
            getForm(widget.name, formKey, context, scaffoldKey),
            SizedBox(height: 30.0),
            _buildFacebookButton(),
            SizedBox(height: 30.0),
            _buildGoogleButton()
          ],
        ),
      ),
    );
  }

  Form getForm(entity, formKey, context, scaffoldKey) {
    return Form(
      key: formKey,
      child: Column(
          children: getFields(entity, formKey, context, scaffoldKey)
      ),
    );
  }

  Widget _buildFacebookButton() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 40.0,
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      margin: EdgeInsets.only(top: 15.0),
      child: RaisedButton.icon(
        color: Colors.indigoAccent,
        onPressed: () async {
          final _prefs = await PreferenceManager.getInstance();
          dynamic token = await signUpWithFacebook();
          if (_prefs.getItem("token") == token) {
            Navigator.popAndPushNamed(context, screenHome);
          } else if (_prefs.getItem("token") != token) {
            scaffoldKey.currentState
                .showSnackBar(buidSnackBar("LOGIN FAILED"));
          }
        },
        icon: Icon(
          FontAwesomeIcons.facebookF,
          size: 30.0,
        ),
        label: Text("SIGN UP WITH FACEBOOK"),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
            side: BorderSide(color: Colors.black)),
      ),
    );
  }

  Widget _buildGoogleButton() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 40.0,
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      margin: EdgeInsets.only(top: 15.0),
      child: RaisedButton.icon(
        color: Colors.white,
        onPressed: () {signIn();},
        icon: Icon(
          FontAwesomeIcons.googlePlusG,
          size: 30.0,
        ),
        label: Text("SIGN UP WITH GOOGLE"),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
            side: BorderSide(color: Colors.black)),
      ),
    );
  }

  submitForm(entity, formskey, context, scaffoldKey) async {
    if (formskey.currentState.validate()) {
      formskey.currentState.save();
      dynamic body = await createMap(entity);
      String path;
      switch (entity) {
        case 'signin': path = '/auth/attempt';
        break;
        case 'signup': path = '/customers';
        break;
      }
      _client.post(path, body: body).then((value) {
        switch(entity) {
          case 'signin':
            switch(value) {
              case '200': Navigator.popAndPushNamed(context, screenHome);
              break;
              case '400': scaffoldKey.currentState
                  .showSnackBar(buidSnackBar(entity));
              break;
            }
            break;
          case 'signup':
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
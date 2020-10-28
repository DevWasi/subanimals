import 'package:flutter_facebook_login/flutter_facebook_login.dart';


import 'package:subanimals/utils/manager.dart';
import 'package:subanimals/remote/request/request_handler.dart';

Future<dynamic> signUpWithFacebook() async {
  final fbLogin = FacebookLogin();
  RequestHandler _client = RequestHandler();
  final _prefs = await PreferenceManager.getInstance();

  final res = await fbLogin.logIn(["email"]);
  switch (res.status) {
    case FacebookLoginStatus.error:
      print("Error");
      break;
    case FacebookLoginStatus.cancelledByUser:
      print("Cancelled By User");
      break;
    case FacebookLoginStatus.loggedIn:
      _prefs.setItem("token", res.accessToken.token);
      _client.post('/auth/facebook_login');
  }

  return res.accessToken.token;
}

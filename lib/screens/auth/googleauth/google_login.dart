import 'package:google_sign_in/google_sign_in.dart';

import 'package:subanimals/utils/manager.dart';
import 'package:subanimals/utils/constants.dart';
import 'package:subanimals/remote/request/request_handler.dart';

GoogleSignInAccount _currentUser;
GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

Future<dynamic> signIn() async {
  RequestHandler _client = RequestHandler();
  final _prefs = await PreferenceManager.getInstance();

  print("----------------------------");
  print(_googleSignIn.signIn());
  print("----------------------------");

  try{
    await _googleSignIn.signIn();
  }catch(e){
    print('ERROR');
  }
}

Future<void> signOut() async {
  _googleSignIn.disconnect();
}
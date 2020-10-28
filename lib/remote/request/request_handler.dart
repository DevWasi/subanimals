import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:subanimals/utils/manager.dart';
import 'package:subanimals/utils/constants.dart';
import 'package:subanimals/screens/common/common.dart';

class RequestHandler {
  Future<dynamic> post (String path, {dynamic body, bool flag = false}) async {
    final _prefs = await PreferenceManager.getInstance();
    if (flag) {
      final map = await createMap("facebook_login");
      http.post(BASE+path+'?lang=${_prefs.getItem("lang")}',
          headers: HEADERS,
          body: jsonEncode(map)
      );
    } else {
      final res = http.post(BASE+path, headers: HEADERS, body: jsonEncode(body));

      return res.then((value) {
        return value.statusCode.toString();
      });
    }
  }

  Future<dynamic> by (String path, dynamic query, {bool sync = false}) async {
    if(sync) {
      dynamic data = await http.post(BASE+'/'+path+'/by',
          headers: HEADERS,
          body: jsonEncode(query));
      data = jsonDecode(data.body);

      return data[path];
    } else {
      return http.post(BASE+'/'+path+'/by',
          headers: HEADERS,
          body: jsonEncode(query)).then((value) {
        final data = jsonDecode(value.body);

        return data[path];
      });
    }
  }

  Future<bool> getProfile() async {
    final _prefs = await PreferenceManager.getInstance();
    final graphResponse = await http.get(
        'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email&access_token=${_prefs.getItem("token")}');
    var profile = jsonDecode(graphResponse.body);

    return profile;
  }
}
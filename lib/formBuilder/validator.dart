
String validateString(String key, String value) {
  if (value.isEmpty) {
    return key + ' Is Required';
  } else if (key == 'Email' &&
      !RegExp(
          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
          .hasMatch(value)) {
    return 'Please Enter A Valid Email';
  } else if (key == 'Password' && value.length < 6) {
    return 'Password must be 6 digit long';
  } else {
    return null;
  }
}
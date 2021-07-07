import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

void updateCookie(http.Response response, SharedPreferences prefs) {
  String? rawCookie = response.headers['set-cookie'];
  print('update cookie ${prefs.getString('cookie')}');
  if (rawCookie != null) {
    int index = rawCookie.indexOf(';');
    prefs.setString('cookie', rawCookie.substring(0, index));
  }
}

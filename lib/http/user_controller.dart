import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_chair_frontend/models/user.dart';
import 'package:smart_chair_frontend/utils/const.dart';
import 'package:smart_chair_frontend/utils/cookies.dart';

Future<String> createUser(
    String email, String password, Map<String, dynamic> chairs) async {
  User user = User.toCreate(email: email, password: password, chairs: chairs);
  var data = user.createToJson();

  try {
    var response = await http.post(
        Uri.https("$URL_PATH_API", "/users/create_user"),
        headers: <String, String>{},
        body: data);

    print(response.statusCode);
    var bodyResponse = jsonDecode(utf8.decoder.convert(response.bodyBytes));

    if (response.statusCode == HttpStatus.created) {
      print(jsonDecode(response.body));
      return "Usuário criado com sucesso";
    } else {
      return Future.error(bodyResponse['errors'][0]['title']);
    }
  } catch (e) {
    return e.toString();
  }
}

Future<User> login(String email, String password) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  print("email $email , pass $password");

  User user = User.toLogIn(email: email, password: password);
  var data = user.loginToJson();

  try {
    var response = await http.post(Uri.https("$URL_PATH_API", "/users/login"),
        headers: <String, String>{}, body: data);

    print(response.statusCode);
    var bodyResponse = jsonDecode(utf8.decoder.convert(response.bodyBytes));
    if (response.statusCode == HttpStatus.ok) {
      updateCookie(response, prefs);

      user.token = response.headers['set-cookie'];

      return user; //bodyResponse['data'][0]['status'].toString();
    } else {
      return Future.error(bodyResponse['errors'][0]['title']);
    }
  } catch (e) {
    return e;
  }
}

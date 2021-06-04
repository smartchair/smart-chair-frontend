import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_chair_frontend/models/user.dart';
import 'package:smart_chair_frontend/utils/const.dart';
import 'package:smart_chair_frontend/utils/cookies.dart';

Future<String> createUser(User user) async {
  String json =
      '{"email": "${user.email}", "password" : "${user.password}", "chairs" : ${user.chairs} }';
  print(json);

  try {
    var response =
        await http.post(Uri.https("$URL_PATH_API", "/users/create_user"),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: json);

    print(response.statusCode);
    var bodyResponse = jsonDecode(response.body);
    if (response.statusCode == HttpStatus.created) {
      print(jsonDecode(response.body));
      return "Usuário criado com sucesso";
    } else {
      print(jsonDecode(response.body));
      return Future.error(bodyResponse['errors'][0]['title']);
    }
  } catch (e) {
    return e.toString();
  }
}

Future<User> login(User user) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  String json =
      '{"username": "${user.email}", "password" : "${user.password}"}';
  print(json);

  try {
    var response = await http.post(Uri.https("$URL_PATH_API", "/users/login"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json);

    print(response.statusCode);
    var bodyResponse = jsonDecode(response.body);
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

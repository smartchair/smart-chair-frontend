import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_chair_frontend/models/user.dart';
import 'package:smart_chair_frontend/utils/const.dart';

Future<SharedPreferences> initPrefs() {
  Future<SharedPreferences> prefs = SharedPreferences.getInstance();
  return prefs;
}

//Future<SharedPreferences> prefs = SharedPreferences.getInstance();

Future<String> createUser(User user) async {
  String json =
      '{"email": "${user.email}", "password" : "${user.password}", "chairIds" : ${user.chairId} }';
  print(json);
  var response =
      await http.post(Uri.https("$URL_PATH_API", "/users/create_user"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: json);

  if (response.statusCode == 200) {
    return response.statusCode.toString(); //response.body;
  } else {
    return "Bad request";
  }
}

Future<String> login(User user) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  String json =
      '{"username": "${user.email}", "password" : "${user.password}"}';
  print(json);
  var response = await http.post(Uri.https("$URL_PATH_API", "/users/login"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json);
  //print(response.statusCode);
  var bodyResponse = jsonDecode(response.body);
  if (response.statusCode == 200) {
    prefs.setString('token', bodyResponse['data'][0]['token']);
    print(prefs.getString('token'));

    return bodyResponse['data'][0]['status'].toString(); //response.body;
  } else {
    return bodyResponse['errors'][0]['title'];
  }
}

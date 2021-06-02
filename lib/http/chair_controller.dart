import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_chair_frontend/models/chair.dart';
import 'dart:io';
import 'package:smart_chair_frontend/utils/const.dart';

Map<String, String> headers = {};

Future getChair() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  headers['cookie'] = prefs.getString("cookie");

  var userId = prefs.getString('email');
  print('user id $userId');

  try {
    var response = await http.get(
        Uri.https(
          URL_PATH_API,
          "/users/$userId/get-chairs",
        ),
        headers: headers);
    var bodyResponse = jsonDecode(response.body);

    if (response.statusCode == HttpStatus.ok) {
      return bodyResponse['data'][0]['chairs']; //chair.chairIds;
    } else {
      return Future.error(bodyResponse['detail']); //"Bad request";
    }
  } catch (e) {
    return e;
  }
}

Future<String> addChair(Chair chair) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  chair.userId = prefs.getString("email");

  String json =
      '{"chairId": "${chair.chairId}", "chairNickname" : "${chair.chairNickname}" }';
  print(json);

  try {
    headers['cookie'] = prefs.getString("cookie");

    var response = await http.post(
        Uri.https("$URL_PATH_API", "/users/${chair.userId}/add-chair"),
        headers: headers,
        body: json);

    if (response.statusCode == HttpStatus.ok) {
      return response.statusCode.toString(); //response.body;
    } else {
      return throw ("Bad request");
    }
  } catch (e) {
    return e;
  }
}

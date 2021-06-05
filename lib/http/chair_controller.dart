import 'dart:convert';
import 'dart:async';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_chair_frontend/models/chair.dart';
import 'package:smart_chair_frontend/models/user.dart';
import 'package:smart_chair_frontend/stores/user_manager_store.dart';
import 'dart:io';
import 'package:smart_chair_frontend/utils/const.dart';

Map<String, String> headers = {};

final UserManagerStore userManagerStore = GetIt.I<UserManagerStore>();

Future<Map<String, dynamic>> getChairs(User user) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  headers['cookie'] = prefs.getString("cookie");

  var userId = user.email;

  try {
    var response = await http.get(
        Uri.https(
          URL_PATH_API,
          "/users/$userId/get-chairs",
        ),
        headers: headers);
    var bodyResponse = jsonDecode(response.body);

    if (response.statusCode == HttpStatus.ok) {
      print(bodyResponse['data'][0]['chairs']);
      return bodyResponse['data'][0]['chairs']; //chair.chairIds;
    } else {
      return Future.error(
          "Erro para carregar seus dispositivos"); //"Bad request";
    }
  } catch (e) {
    return e;
  }
}

Future addChairs(Map<String, dynamic> chairMap) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  //print(' chairMap ${chairMap['chairId']}, ${chairMap['chairNickname']}');

  String json =
      '{"chairId": "${chairMap['chairId']}", "chairNickname" : "${chairMap['chairNickname']}" }';
  print(json);

  try {
    headers['cookie'] = prefs.getString("cookie");

    var response = await http.post(
        Uri.https(
            "$URL_PATH_API", "/users/${userManagerStore.user.email}/add-chair"),
        headers: headers,
        body: json);

    var bodyResponse = jsonDecode(response.body);
    print(response.statusCode);
    if (response.statusCode == HttpStatus.ok) {
      return bodyResponse['data'][0]['chair_ids']; //response.body;
    } else {
      return Future.error(bodyResponse['errors'][0]['title']);
    }
  } catch (e) {
    return e;
  }
}

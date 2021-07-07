import 'dart:convert';
import 'dart:async';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_chair_frontend/models/chair.dart';
import 'package:smart_chair_frontend/stores/user_manager_store.dart';
import 'dart:io';
import 'package:smart_chair_frontend/utils/const.dart';

Map<String, String> headers = {};

final UserManagerStore? userManagerStore = GetIt.I<UserManagerStore>();

Future<Map<String, dynamic>?> getChairs(String? email) async {
  print('before request');
  SharedPreferences prefs = await SharedPreferences.getInstance();
  headers['cookie'] = prefs.getString("cookie") ?? '';

  print('before request');

  try {
    var response = await http.get(
        Uri.https(
          URL_PATH_API,
          "/users/$email/get-chairs",
        ),
        headers: headers);
    var bodyResponse = jsonDecode(utf8.decoder.convert(response.bodyBytes));
    print(response);
    print(bodyResponse);

    if (response.statusCode == HttpStatus.ok) {
      print(bodyResponse['data'][0]['chairs']);
      return bodyResponse['data'][0]['chairs']; //chair.chairIds;
    } else {
      return Future.error(
          "Erro para carregar seus dispositivos"); //"Bad request";
    }
  } catch (e) {
    print(e);
  }
}

Future addChairs(String? chairId, String? chairNickname) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  Chair chair = Chair.toAdd(chairId: chairId, chairNickname: chairNickname);
  var data = chair.addChairToJson();

  try {
    headers['cookie'] = prefs.getString("cookie")!;

    var response = await http.post(
        Uri.https("$URL_PATH_API",
            "/users/${userManagerStore!.user!.email}/add-chair"),
        headers: headers,
        body: data);

    var bodyResponse = jsonDecode(utf8.decoder.convert(response.bodyBytes));
    print(response.statusCode);
    print(bodyResponse);
    if (response.statusCode == HttpStatus.ok) {
      return bodyResponse['data'][0]['chairs']; //response.body;
    } else if (response.statusCode == HttpStatus.unauthorized) {
      return Future.error("Por favor faça seu login novamente");
    } else {
      return Future.error(bodyResponse['errors'][0]['title']);
    }
  } catch (e) {
    return e;
  }
}

Future removeChairs(String? chairId) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  Chair chair = Chair.toAdd(chairId: chairId, chairNickname: '');
  var data = chair.addChairToJson();

  try {
    headers['cookie'] = prefs.getString("cookie")!;

    var response = await http.post(
        Uri.https("$URL_PATH_API",
            "/users/${userManagerStore!.user!.email}/remove-chair"),
        headers: headers,
        body: data);

    var bodyResponse = jsonDecode(utf8.decoder.convert(response.bodyBytes));
    print(response.statusCode);
    print(bodyResponse);
    if (response.statusCode == HttpStatus.ok) {
      return bodyResponse['data'][0]['chairs']; //response.body;
    } else if (response.statusCode == HttpStatus.unauthorized) {
      return Future.error("Por favor faça seu login novamente");
    } else {
      return Future.error(bodyResponse['errors'][0]['title']);
    }
  } catch (e) {
    return e;
  }
}

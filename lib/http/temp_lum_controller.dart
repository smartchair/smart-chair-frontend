import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'dart:convert';

import 'package:smart_chair_frontend/utils/const.dart';

Map<String, String> headers = {};

Future getCurrentTempChair(String chairId) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  headers['cookie'] = prefs.getString("cookie");

  try {
    var response = await http.get(
        Uri.https(
          URL_PATH_API,
          "/chair/current/temp/$chairId",
        ),
        headers: headers);

    var bodyResponse = jsonDecode(response.body);
    if (response.statusCode == HttpStatus.ok) {
      print(bodyResponse['data'][0]['currentTemp']);
      return bodyResponse['data'][0]['currentTemp']; //chair.chairIds;
    } else if (response.statusCode == HttpStatus.unauthorized) {
      return Future.error("Por favor faça seu login novamente");
    } else {
      return Future.error(
          "Erro para carregar dados da temperatura"); //"Bad request";
    }
  } catch (e) {
    return e;
  }
}

Future getCurrentLumChair(String chairId) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  headers['cookie'] = prefs.getString("cookie");

  try {
    var response = await http.get(
        Uri.https(
          URL_PATH_API,
          "/chair/current/lum/$chairId",
        ),
        headers: headers);

    var bodyResponse = jsonDecode(response.body);
    if (response.statusCode == HttpStatus.ok) {
      print(bodyResponse['data'][0]['currentLum']);
      return bodyResponse['data'][0]['currentLum']; //chair.chairIds;
    } else if (response.statusCode == HttpStatus.unauthorized) {
      return Future.error("Por favor faça seu login novamente");
    } else {
      return Future.error(
          "Erro para carregar dados da luminosidade"); //"Bad request";
    }
  } catch (e) {
    return e;
  }
}

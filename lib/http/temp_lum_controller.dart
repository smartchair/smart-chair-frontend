import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'dart:convert';

import 'package:smart_chair_frontend/utils/const.dart';

Map<String, String> headers = {};

Future getCurrentTempChair(String? chairId) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  headers['cookie'] = prefs.getString("cookie")!;

  if (chairId == "" || chairId == null) {
    return Future.error('Sem dispositivos');
  }

  try {
    var response = await http.get(
        Uri.https(
          URL_PATH_API,
          "/chair/current/temp/$chairId",
        ),
        headers: headers);

    print(response.statusCode);
    // var bodyResponse = jsonDecode(response.body);

    if (response.statusCode == HttpStatus.ok) {
      var bodyResponse = jsonDecode(response.body);
      print(bodyResponse['data'][0]['currentTemp']);
      return bodyResponse['data'][0]['currentTemp']; //chair.chairIds;
    } else {
      return Future.error(
          "Erro para carregar dados da temperatura"); //"Bad request";
    }
  } catch (e) {
    return e;
  }
}

Future getCurrentLumChair(String? chairId) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  headers['cookie'] = prefs.getString("cookie")!;

  if (chairId == "" || chairId == null) {
    return Future.error('Sem dispositivos');
  }

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
    } else {
      return Future.error(
          "Erro para carregar dados da luminosidade"); //"Bad request";
    }
  } catch (e) {
    return e;
  }
}

Future getAllTempChair(String? chairId) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  headers['cookie'] = prefs.getString("cookie")!;

  if (chairId == "" || chairId == null) {
    return Future.error('Sem dispositivos');
  }

  try {
    var response = await http.get(
        Uri.https(
          URL_PATH_API,
          "/chair/all/temp/$chairId",
        ),
        headers: headers);

    var bodyResponse = jsonDecode(response.body);
    if (response.statusCode == HttpStatus.ok) {
      return bodyResponse['data'][0]['Temps']; //chair.chairIds;
    } else {
      return Future.error(
          "Erro para carregar dados da temperatura"); //"Bad request";
    }
  } catch (e) {
    return e;
  }
}

Future getAllLumChair(String? chairId) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  headers['cookie'] = prefs.getString("cookie")!;

  if (chairId == "" || chairId == null) {
    return Future.error('Sem dispositivos');
  }

  try {
    var response = await http.get(
        Uri.https(
          URL_PATH_API,
          "/chair/all/lum/$chairId",
        ),
        headers: headers);

    var bodyResponse = jsonDecode(response.body);
    if (response.statusCode == HttpStatus.ok) {
      return bodyResponse['data'][0]['Lums']; //chair.chairIds;
    } else {
      return Future.error(
          "Erro para carregar dados de luminosidade"); //"Bad request";
    }
  } catch (e) {
    return e;
  }
}

Future getAllHumChair(String? chairId) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  headers['cookie'] = prefs.getString("cookie")!;

  if (chairId == "" || chairId == null) {
    return Future.error('Sem dispositivos');
  }

  try {
    var response = await http.get(
        Uri.https(
          URL_PATH_API,
          "/chair/all/hum/$chairId",
        ),
        headers: headers);

    var bodyResponse = jsonDecode(response.body);
    if (response.statusCode == HttpStatus.ok) {
      return bodyResponse['data'][0]['Hums']; //chair.chairIds;
    } else {
      return Future.error(
          "Erro para carregar dados de umidade"); //"Bad request";
    }
  } catch (e) {
    return e;
  }
}

Future getAllNoiseChair(String? chairId) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  headers['cookie'] = prefs.getString("cookie")!;

  if (chairId == "" || chairId == null) {
    return Future.error('Sem dispositivos');
  }

  try {
    var response = await http.get(
        Uri.https(
          URL_PATH_API,
          "/chair/all/noise/$chairId",
        ),
        headers: headers);

    var bodyResponse = jsonDecode(response.body);
    if (response.statusCode == HttpStatus.ok) {
      return bodyResponse['data'][0]['Noises'];
    } else {
      return Future.error("Erro para carregar dados de ruído"); //"Bad request";
    }
  } catch (e) {
    return e;
  }
}

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_chair_frontend/utils/const.dart';

Map<String, String> headers = {};

Future getAverageSensor(String chairId, DateTime date) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  headers['cookie'] = prefs.getString("cookie")!;

  DateFormat format = DateFormat("dd-MM-yy");
  var formattedDate = format.format(date);
  print(date);
  print(formattedDate);
  print(chairId);

  try {
    var response = await http.post(
        Uri.https(
          URL_PATH_API,
          "/chair/average",
        ),
        headers: headers,
        body: '{"day": "$formattedDate", "chairId": "$chairId"}');

    var bodyResponse = jsonDecode(response.body);
    print('average graphs statu code ${response.statusCode}');
    if (response.statusCode == HttpStatus.ok) {
      return bodyResponse; //chair.chairIds;
    } else {
      return Future.error(
          "Erro para carregar dados do gráfico"); //"Bad request";
    }
  } catch (e) {
    return e;
  }
}

Future getDataCurrentDay(String chairId, DateTime date, String prop) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  headers['cookie'] = prefs.getString("cookie")!;

  DateFormat format = DateFormat("dd-MM-yy");
  var formattedDate = format.format(date);
  print(formattedDate);
  print(chairId);

  try {
    var response = await http.post(
        Uri.https(
          URL_PATH_API,
          "/chair/day/$prop",
        ),
        headers: headers,
        body: '{"day": "$formattedDate", "chairId": "$chairId"}');

    var bodyResponse = jsonDecode(response.body);
    if (response.statusCode == HttpStatus.ok) {
      return bodyResponse['data'][0][
          '${prop.substring(0)[0].toUpperCase()}${prop.substring(1)}']; // format prop with firstCase capitalized
    } else {
      return Future.error(
          "Erro para carregar dados do gráfico"); //"Bad request";
    }
  } catch (e) {
    return e;
  }
}

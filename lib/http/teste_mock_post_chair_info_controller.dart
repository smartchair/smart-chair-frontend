import 'dart:io';
import 'dart:math';

import 'package:http/http.dart' as http;
import 'dart:async';

import 'package:smart_chair_frontend/utils/const.dart';

Future<void> addMockNewChair(String? chairId) async {
  var temp = new Random().nextInt(40);
  var noise = new Random().nextInt(40);
  var lum = new Random().nextInt(40);
  var hum = new Random().nextInt(40);

  var presence = true;

  print('inside request');

  var data =
      '{"chairId": "$chairId","temp" : "$temp", "presence" : "$presence", "noise" : "$noise", "lum" : "$lum", "hum" : "$hum", "time" : "${DateTime.now()}" }';

  try {
    var response =
        await http.post(Uri.https("$URL_PATH_API", "/log/info"), body: data);

    //var bodyResponse = jsonDecode(utf8.decoder.convert(response.bodyBytes));
    print(response.statusCode);
    //print(bodyResponse);
    if (response.statusCode == HttpStatus.ok) {
      print('response ok');
    }
  } catch (e) {
    print(e);
  }
}

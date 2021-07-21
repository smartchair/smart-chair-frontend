import 'package:mobx/mobx.dart';
import 'dart:async';

import 'package:smart_chair_frontend/http/temp_lum_controller.dart';

part 'current_chair_data_store.g.dart';

class CurrentChairDataStore = _CurrentChairDataStore
    with _$CurrentChairDataStore;

abstract class _CurrentChairDataStore with Store {
  @observable
  bool loading = false;

  @observable
  double? temp;

  @observable
  double? lum;

  @observable
  String error = '';

  @observable
  double averageTemp = 0.0;

  @observable
  double averageLum = 0.0;

  @observable
  double averageHum = 0.0;

  @observable
  double averageNoise = 0.0;

  @action
  Future<void> getCurrentTemp(String? chair) async {
    loading = true;
    error = '';
    print('inside store value $chair');
    print('inside store value error $error');
    try {
      temp = await getCurrentTempChair(chair);
      print('graph store temp $temp');
    } catch (e) {
      error = e.toString();
    }
    print('inside store value error $error');

    loading = false;
  }

  @action
  Future<void> getCurrentLum(String? chair) async {
    loading = true;
    error = '';

    try {
      lum = await getCurrentLumChair(chair);
      print('graph store lum $lum');
    } catch (e) {
      error = e.toString();
    }

    loading = false;
  }

  @action
  Future<void> getAllAverageDataCurrentChair(String? chair) async {
    loading = true;
    error = '';
    try {
      var listTemp = await getAllTempChair(chair);
      var listLum = await getAllLumChair(chair);
      var listHum = await getAllHumChair(chair);
      var listNoise = await getAllNoiseChair(chair);

      print("lenght temp:${listTemp.length}");
      print("lenght lum:${listLum.length}");
      print("length hum: ${listHum.length}");
      print("lenght noise: ${listNoise.length}");

      averageTemp =
          listTemp.map((item) => item["temp"]).reduce((a, b) => a + b) /
              listTemp.length;
      print(averageTemp);
      averageLum = listLum.map((item) => item["lum"]).reduce((a, b) => a + b) /
          listLum.length;
      averageHum = listHum.map((item) => item["hum"]).reduce((a, b) => a + b) /
          listHum.length;
      averageNoise =
          listNoise.map((item) => item["noise"]).reduce((a, b) => a + b) /
              listNoise.length;
    } catch (e) {
      error = e.toString();
    }

    loading = false;
  }

  @action
  void resetChairData(double? value) {
    temp = value;
    lum = value;
  }
}

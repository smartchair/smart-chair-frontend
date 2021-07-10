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
  Future<void> getAllTempCurrentChair(String? chair) async {
    loading = true;
    error = '';
    try {
      var listTemp = await getAllTempChair(chair);
      print(listTemp);
      averageTemp = listTemp.map((temp) => temp).reduce((a, b) => a + b) /
          listTemp.length;
      print(averageTemp);
    } catch (e) {
      error = e.toString();
    }

    loading = false;
  }

  @action
  Future<void> getAllLumCurrentChair(String? chair) async {
    loading = true;

    try {
      var listLum = await getAllLumChair(chair);
      print(listLum);
      averageLum =
          listLum.map((temp) => temp).reduce((a, b) => a + b) / listLum.length;
      print(averageLum);
    } catch (e) {
      error = e.toString();
    }

    loading = false;
  }

  @action
  Future<void> getAllHumCurrentChair(String? chair) async {
    loading = true;
    error = '';

    try {
      var listHum = await getAllHumChair(chair);
      print(listHum);
      averageHum =
          listHum.map((temp) => temp).reduce((a, b) => a + b) / listHum.length;
      print(averageHum);
    } catch (e) {
      error = e.toString();
    }

    loading = false;
  }

  @action
  Future<void> getAllNoiseCurrentChair(String? chair) async {
    loading = true;
    error = '';
    try {
      var listNoise = await getAllNoiseChair(chair);
      print(listNoise);
      averageNoise = listNoise.map((temp) => temp).reduce((a, b) => a + b) /
          listNoise.length;
      print(averageNoise);
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

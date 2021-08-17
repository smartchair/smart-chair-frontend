import 'package:mobx/mobx.dart';
import 'dart:async';
import 'package:intl/intl.dart';
import 'package:smart_chair_frontend/http/graphs_controller.dart';
import 'package:smart_chair_frontend/http/temp_lum_controller.dart';

part 'current_chair_data_store.g.dart';

class CurrentChairDataStore = _CurrentChairDataStore
    with _$CurrentChairDataStore;

abstract class _CurrentChairDataStore with Store {
  @observable
  bool loading = false;

  @observable
  double temp = 0.0;

  @observable
  double lum = 0.0;

  @observable
  int hours = 0;

  @observable
  int minutes = 0;

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
    try {
      temp = await getCurrentTempChair(chair);
    } catch (e) {
      error = e.toString();
    }

    loading = false;
  }

  @action
  Future<void> getCurrentLum(String? chair) async {
    loading = true;
    error = '';

    try {
      lum = await getCurrentLumChair(chair);
    } catch (e) {
      error = e.toString();
    }

    loading = false;
  }

  @action
  Future<void> getPresence(String? chair) async {
    loading = true;
    error = '';

    try {
      var list = await getAllPresence(chair);

      var lastNoPresenceElement =
          list.where((x) => x['presence'] == false).toList().last;
      print(' presence false $lastNoPresenceElement');
      var lastPresenceElement =
          list.where((x) => x['presence'] == true).toList().last;
      print(' presence true $lastPresenceElement');

      DateFormat format = DateFormat("dd-MM-yy HH:mm:ss");
      var lastPresenceDate = format.parse(lastPresenceElement['dateTime']);
      var lastNoPresenceDate = format.parse(lastNoPresenceElement['dateTime']);

      print('dates formatted $lastPresenceDate $lastNoPresenceDate');

      print(lastNoPresenceDate.difference(lastPresenceDate));
      if (!lastNoPresenceDate.difference(lastPresenceDate).isNegative) {
        hours = 0;
        minutes = 0;
      } else {
        print('date time now ${DateTime.now()}');
        print(DateTime.now().difference(lastPresenceDate));
        hours = DateTime.now().difference(lastNoPresenceDate).inHours;
        minutes = DateTime.now().difference(lastNoPresenceDate).inMinutes;
        print('Hours: $hours');
        print('minutes: $minutes');
      }
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
      //var list = await getAverageSensor(chair!, DateTime.now());
      var listTemp = await getAllTempChair(chair);
      var listLum = await getAllLumChair(chair);
      var listHum = await getAllHumChair(chair);
      var listNoise = await getAllNoiseChair(chair);
      var listPresence = await getAllPresence(chair);

      print(listPresence);

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
  void resetChairData(double value) {
    temp = value;
    lum = value;
  }
}

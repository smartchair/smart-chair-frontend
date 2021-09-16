import 'dart:async';

import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:smart_chair_frontend/http/graphs_controller.dart';

import 'chair_store.dart';

part 'graph_data_store.g.dart';

class GraphStore = _GraphStore with _$GraphStore;

abstract class _GraphStore with Store {
  @observable
  bool loading = false;

  @observable
  double temp = 0;

  @observable
  bool loadingTemp = false;

  @observable
  bool loadingLum = false;

  @observable
  bool loadingHum = false;

  ObservableList listAverage = ObservableList();

  @observable
  String? error;

  @observable
  String dateReferenceGraphs = DateTime.now().toString();

  ObservableMap<String, dynamic> mapTemps = ObservableMap<String, dynamic>();
  ObservableMap<String, dynamic> mapLums = ObservableMap<String, dynamic>();
  ObservableMap<String, dynamic> mapHums = ObservableMap<String, dynamic>();

  @action
  void setReferenceDateGraphs(String value) => dateReferenceGraphs = value;

  @action
  Future<void> getAverageSensors() async {
    loading = true;

    try {
      final chairId = GetIt.I<ChairStore>().selectedChair;
      print(chairId);

      var listAverageAux = await (getAverageSensor(chairId!, DateTime.now()));
      listAverage.addAll(listAverageAux);
      print('inside sptr $listAverage');
    } catch (e) {
      print(e);
    }

    loading = false;
  }

  var countIdenticalHour = 0;
  double value = 0.0;
  String? lastChairSelected;

  @action
  void clearMaps() {
    mapTemps.clear();
    mapLums.clear();
    mapHums.clear();
  }

  @action
  Future<void> getDataCurrentDayTemp() async {
    loading = true;
    loadingTemp = true;

    print('data fro data chart temp$dateReferenceGraphs');
    try {
      final chairId = GetIt.I<ChairStore>().selectedChair;
      print(chairId);

      _checkChairDifference(chairId);

      List<dynamic> listAverageAux = await (getDataCurrentDay(
          chairId!, DateTime.parse(dateReferenceGraphs), 'temp'));

      if (listAverageAux.isEmpty) {
        mapTemps.clear();
      }

      Map<String, dynamic> mapTempsLocal = Map<String, dynamic>();
      for (var i = 0; i < listAverageAux.length; i++) {
        if (i + 1 == listAverageAux.length) {
          // the last one from the list
          countIdenticalHour++;
          value += listAverageAux[i]['temp'];
          _calculateAVG(
              mapTempsLocal, value, countIdenticalHour, listAverageAux[i]);

          mapTemps.addAll(mapTempsLocal);
          print('mapTemps $mapTemps');
        } else {
          if (listAverageAux[i]['hour'].toString().split(':')[0] ==
              listAverageAux[i + 1]['hour'].toString().split(':')[0]) {
            countIdenticalHour++;
            value += listAverageAux[i]['temp'];
          } else {
            _calculateAVG(
                mapTempsLocal, value, countIdenticalHour, listAverageAux[i]);
          }
        }
      }
    } catch (e) {
      print(e);
    }

    loading = false;
    loadingTemp = false;
  }

  @action
  Future<void> getDataCurrentDayLum() async {
    loading = true;

    print('data fro data chart lum $dateReferenceGraphs');

    try {
      final chairId = GetIt.I<ChairStore>().selectedChair;
      print(chairId);

      List<dynamic> listAverageAux = await (getDataCurrentDay(
          chairId!, DateTime.parse(dateReferenceGraphs), 'lum'));

      if (listAverageAux.isEmpty) {
        mapLums.clear();
      }

      Map<String, dynamic> mapLumLocal = Map<String, dynamic>();
      for (var i = 0; i < listAverageAux.length; i++) {
        if (i + 1 == listAverageAux.length) {
          // the last one from the list
          countIdenticalHour++;
          value += listAverageAux[i]['lum'];
          _calculateAVG(
              mapLumLocal, value, countIdenticalHour, listAverageAux[i]);

          mapLums.addAll(mapLumLocal);
          print('mapLums $mapLums');
        } else {
          if (listAverageAux[i]['hour'].toString().split(':')[0] ==
              listAverageAux[i + 1]['hour'].toString().split(':')[0]) {
            countIdenticalHour++;
            value += listAverageAux[i]['lum'];
          } else {
            _calculateAVG(
                mapLumLocal, value, countIdenticalHour, listAverageAux[i]);
          }
        }
      }
    } catch (e) {
      print(e);
    }

    loading = false;
  }

  @action
  Future<void> getDataCurrentDayHum() async {
    loading = true;

    print('data fro data chart hum $dateReferenceGraphs');

    try {
      final chairId = GetIt.I<ChairStore>().selectedChair;
      print(chairId);

      List<dynamic> listAverageAux = await (getDataCurrentDay(
          chairId!, DateTime.parse(dateReferenceGraphs), 'hum'));

      if (listAverageAux.isEmpty) {
        mapHums.clear();
      }

      Map<String, dynamic> mapHumLocal = Map<String, dynamic>();
      for (var i = 0; i < listAverageAux.length; i++) {
        if (i + 1 == listAverageAux.length) {
          // the last one from the list
          countIdenticalHour++;
          value += listAverageAux[i]['hum'];
          _calculateAVG(
              mapHumLocal, value, countIdenticalHour, listAverageAux[i]);

          mapHums.addAll(mapHumLocal);
          print('mapHums $mapHums');
        } else {
          if (listAverageAux[i]['hour'].toString().split(':')[0] ==
              listAverageAux[i + 1]['hour'].toString().split(':')[0]) {
            countIdenticalHour++;
            value += listAverageAux[i]['hum'];
          } else {
            _calculateAVG(
                mapHumLocal, value, countIdenticalHour, listAverageAux[i]);
          }
        }
      }
    } catch (e) {
      print(e);
    }

    loading = false;
  }

  void _calculateAVG(mapTemps, value, countIdenticalHour, listAverageAux) {
    var avg = double.parse((value / countIdenticalHour).toStringAsFixed(1));
    mapTemps.putIfAbsent(
        listAverageAux['hour'].toString().split(':')[0], () => avg);
    this.countIdenticalHour = 0;
    this.value = 0.0;
    //print('mapTemps $mapTemps');
  }

  void _checkChairDifference(String? chairId) {
    if (lastChairSelected != chairId) {
      print('chair is different');
      lastChairSelected = chairId!;
      mapTemps.clear();
      mapLums.clear();
      mapHums.clear();
    }
  }
}

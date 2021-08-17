import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'dart:async';

import 'package:smart_chair_frontend/http/graphs_controller.dart';

import 'chair_store.dart';
import 'user_manager_store.dart';

part 'graph_data_store.g.dart';

class GraphStore = _GraphStore with _$GraphStore;

abstract class _GraphStore with Store {
  @observable
  bool loading = false;

  @observable
  double temp = 0;

  ObservableList listAverage = ObservableList();

  @observable
  String? error;

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
}

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

  @observable
  List? listAverage;

  @observable
  String? error;

  @action
  Future<void> getCurrentTemp() async {
    loading = true;

    try {
      final chairs = GetIt.I<UserManagerStore>().user!.chairs;
      print(chairs);

      temp = await (getCurrentTempChair('ESP-07'));
      print('graph store temp $temp');
    } catch (e) {
      print(e);
    }

    loading = false;
  }

  @action
  Future<void> getAverageSensors() async {
    loading = true;

    try {
      final chairId = GetIt.I<ChairStore>().selectedChair;
      print(chairId);

      listAverage = await (getAverageSensor(chairId!, DateTime.now()));
    } catch (e) {
      print(e);
    }

    loading = false;
  }
}

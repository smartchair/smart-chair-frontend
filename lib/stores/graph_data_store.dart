import 'package:mobx/mobx.dart';
import 'dart:async';

import 'package:smart_chair_frontend/http/graphs_controller.dart';

part 'graph_data_store.g.dart';

class GraphStore = _GraphStore with _$GraphStore;

abstract class _GraphStore with Store {
  @observable
  bool loading = false;

  @observable
  double temp;

  @observable
  String error;

  @action
  Future<void> getCurrentTemp() async {
    loading = true;

    try {
      temp = await getCurrentTempChair('chair');
      print('graph store temp $temp');
    } catch (e) {
      print(e);
    }

    loading = false;
  }
}

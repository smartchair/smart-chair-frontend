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
  String? error;

  @action
  Future<void> getCurrentTemp(String? chair) async {
    loading = true;
    try {
      temp = await getCurrentTempChair(chair);
      print('graph store temp $temp');
    } catch (e) {
      //error = e as String?;
    }

    loading = false;
  }

  @action
  Future<void> getCurrentLum(String? chair) async {
    loading = true;

    try {
      lum = await getCurrentLumChair(chair);
      print('graph store lum $lum');
    } catch (e) {
      //error = e as String?;
    }

    loading = false;
  }

  @action
  void resetChairData(double? value) {
    temp = value;
    lum = value;
  }
}

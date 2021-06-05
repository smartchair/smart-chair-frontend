import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:smart_chair_frontend/http/chair_controller.dart';
import 'package:smart_chair_frontend/models/chair.dart';
import 'package:smart_chair_frontend/models/user.dart';
import 'dart:async';

import 'package:smart_chair_frontend/stores/user_manager_store.dart';

part 'chair_store.g.dart';

class ChairStore = _ChairStore with _$ChairStore;

abstract class _ChairStore with Store {
  @observable
  String result;

  @observable
  String error;

  @observable
  bool loading = false;

  @observable
  String chairNickname;

  @observable
  String chairId;

  @observable
  bool btnClicked = false;

  @action
  void setChairNickname(String value) => chairNickname = value;

  // ObservableMap mapChairs = ObservableMap();
  //
  // @action
  // void setChairs(Map<String, dynamic> chairs) {
  //   mapChairs.clear();
  //   mapChairs.addAll(chairs);
  //   loading = false;
  // }

  @computed
  bool get nameValid => chairNickname != null && chairNickname != '';
  String get nameError {
    if (chairNickname == null || nameValid) {
      return null;
    } else {
      return 'Nome obrigatório';
    }
  }

  @computed
  Function get deviceNamePressed => nameValid && !loading ? addChair : null;

  @action
  Future<void> getChair(String email) async {
    loading = true;
    try {
      User user = User();
      user.email = email;
      GetIt.I<UserManagerStore>().user.chairs = await getChairs(user);

      //setChairs(chairs);

    } catch (e) {
      error = e;
    }

    loading = false;
  }

  @action
  Future<void> addChair() async {
    btnClicked = true;
    loading = true;
    error = null;

    if (chairNickname != null) {
      var data = {"chairId": "$chairId", "chairNickname": "$chairNickname"};
      print('store data $data');
      try {
        var result = await addChairs(data);
        GetIt.I<UserManagerStore>().user.chairs.addAll(result);
        chairId = null;
        chairNickname = null;
      } catch (e) {
        error = e;
      }
    }

    loading = false;
  }
}

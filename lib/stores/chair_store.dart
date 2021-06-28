import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:smart_chair_frontend/http/chair_controller.dart';
import 'package:smart_chair_frontend/models/chair.dart';
import 'package:smart_chair_frontend/models/user.dart';
import 'package:smart_chair_frontend/stores/chair_manager_store.dart';
import 'dart:async';

import 'package:smart_chair_frontend/stores/user_manager_store.dart';

part 'chair_store.g.dart';

class ChairStore = _ChairStore with _$ChairStore;

abstract class _ChairStore with Store {
  _ChairStore({this.chair}) {
    if (chair == null) {
      chair = Chair();
    }

    chairNickname = chair.chairNickname ?? '';
    chairId = chair.chairId ?? '';
  }

  // _ChairStore.getChairs() {
  //   getChair();
  // }

  Chair chair;

  @observable
  String result;

  @observable
  String error;

  @observable
  bool loading = false;

  @observable
  String chairNickname = '';

  @observable
  String chairId;

  @observable
  bool btnClicked = false;

  @observable
  bool edit = false;

  @computed
  bool get nameValid => chairNickname != null && chairNickname != '';
  String get nameError {
    if (chairNickname.isNotEmpty || nameValid) {
      return null;
    } else {
      return 'Nome obrigatório';
    }
  }

  @computed
  Function get deviceNamePressed => nameValid && !loading ? addChair : null;

  @action
  void setError(String value) => error = value;

  @action
  void setChairNickname(String value) => chairNickname = value;

  @action
  void setChairId(String value) => chairId = value;

  @action
  Future<void> getChair() async {
    loading = true;
    error = null;
    try {
      GetIt.I<UserManagerStore>().user.chairs =
          await getChairs(GetIt.I<UserManagerStore>().user.email);

      if (GetIt.I<UserManagerStore>().user.chairs.isNotEmpty) {
        GetIt.I<ChairManagerStore>().selectedChair =
            GetIt.I<UserManagerStore>().user.chairs.keys.first;
      }
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

    try {
      var result = await addChairs(chairId, chairNickname);

      GetIt.I<UserManagerStore>().user.chairs.addAll(result);
      GetIt.I<ChairManagerStore>().selectedChair =
          GetIt.I<UserManagerStore>().user.chairs.keys.first;
    } catch (e) {
      error = e;
    }

    loading = false;
  }

  @action
  Future<void> removeChair() async {
    loading = true;
    try {
      await removeChairs(chairId);
      userManagerStore.user.chairs.removeWhere((key, value) => key == chairId);
      GetIt.I<ChairManagerStore>().selectedChair = '';
      getChair();
    } catch (e) {
      error = e;
    }
    loading = false;
  }

  // void _reset() {
  //   chairId = null;
  //   chairNickname = null;
  //   edit = false;
  // }
}

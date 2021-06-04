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

  // ObservableMap mapChairs = ObservableMap();
  //
  // @action
  // void setChairs(Map<String, dynamic> chairs) {
  //   mapChairs.clear();
  //   mapChairs.addAll(chairs);
  //   loading = false;
  // }

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
  Future<void> addChair(Chair chair) async {
    loading = true;
    error = null;

    try {
      var result = await addChairs(chair);
      GetIt.I<UserManagerStore>().user.chairs.addAll(result);
    } catch (e) {
      error = e;
    }
    loading = false;
  }
}

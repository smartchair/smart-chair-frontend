import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:smart_chair_frontend/models/user.dart';
import 'dart:async';

import 'package:smart_chair_frontend/stores/chair_store.dart';

import 'current_chair_data_store.dart';

part 'user_manager_store.g.dart';

class UserManagerStore = _UserManagerStore with _$UserManagerStore;

abstract class _UserManagerStore with Store {
  @observable
  User? user;

  @action
  void setUser(User? value) => user = value;

  @computed
  bool get isLoggedIn => user != null;

  @action
  Future<void> logout() async {
    setUser(null);
    GetIt.I<ChairStore>().resetChair(null);
    GetIt.I<CurrentChairDataStore>().resetChairData(null);
  }
}

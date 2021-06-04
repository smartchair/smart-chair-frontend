import 'package:mobx/mobx.dart';
import 'package:smart_chair_frontend/models/user.dart';
import 'dart:async';

part 'user_manager_store.g.dart';

class UserManagerStore = _UserManagerStore with _$UserManagerStore;

abstract class _UserManagerStore with Store {
  @observable
  User user;

  @action
  void setUser(User value) => user = value;

  // @computed
  // bool get isLoggedIn => user != null;

  @action
  Future<void> logout() async {
    //GetIt.I<ChairStore>().mapChairs.clear();
    //print(" map chairs logout ${GetIt.I<ChairStore>().mapChairs}");
    setUser(null);
  }
}

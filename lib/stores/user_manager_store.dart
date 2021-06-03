import 'package:mobx/mobx.dart';
import 'package:smart_chair_frontend/models/user.dart';

part 'user_manager_store.g.dart';

class UserManagerStore = _UserManagerStore with _$UserManagerStore;

abstract class _UserManagerStore with Store {
  // _UserManagerStore() {
  //   _getCurrentUser();
  // }

  @observable
  User user;

  @action
  void setUser(User value) => user = value;

  // @computed
  // bool get isLoggedIn => user != null;

  Future<void> logout() async {
    //await UserRepository().logout();
    setUser(null);
  }
}

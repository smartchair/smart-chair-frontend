import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:smart_chair_frontend/http/user_controller.dart';
import 'package:smart_chair_frontend/models/user.dart';
import 'package:smart_chair_frontend/stores/user_manager_store.dart';
import 'dart:async';

part 'login_store.g.dart';

class LoginStore = _LoginStore with _$LoginStore;

abstract class _LoginStore with Store {
  @observable
  String email;

  @observable
  String password;

  @observable
  bool loading = false;

  @observable
  String error;

  @action
  void setEmail(String value) => email = value;

  @action
  void setPass(String value) => password = value;

  @computed
  bool get emailValid =>
      email != null && email != ''; //&& email.isEmailValid();
  String get emailError {
    if (email == null || emailValid) {
      return null;
    } else {
      return 'E-mail obrigatório';
    }
  }

  @computed
  bool get passValid => password != null && password != '';
  String get passError {
    if (password == null || passValid) {
      return null;
    } else {
      return 'Senha obrigatória';
    }
  }

  @computed
  bool get formValid => passValid && emailValid;

  @computed
  Function get logInPressed => formValid && !loading ? _logIn : null;

  @action
  Future<void> _logIn() async {
    loading = true;
    error = null;

    try {
      User user = new User();
      user.email = email;
      user.password = password;

      final result = await login(user);
      GetIt.I<UserManagerStore>().setUser(result);
    } catch (e) {
      error = e;
    }
    loading = false;
  }
}

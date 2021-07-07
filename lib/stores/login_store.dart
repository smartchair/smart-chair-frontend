import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:smart_chair_frontend/http/user_controller.dart';
import 'package:smart_chair_frontend/stores/user_manager_store.dart';
import 'dart:async';

part 'login_store.g.dart';

class LoginStore = _LoginStore with _$LoginStore;

abstract class _LoginStore with Store {
  @observable
  String? email;

  @observable
  String? password;

  @observable
  bool loading = false;

  @observable
  String? error;

  @action
  void setEmail(String value) => email = value.toLowerCase();

  @action
  void setPass(String value) => password = value;

  @computed
  bool get emailValid =>
      email != null &&
      email != '' &&
      RegExp(r"^[a-zA-Z0-9.?#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9]{0,253}[a-zA-Z0-9])?)*$")
          .hasMatch(email!);
  String? get emailError {
    if (email == null || emailValid) {
      return null;
    } else if (email!.isEmpty) {
      return 'E-mail obrigatório';
    } else {
      return "E-mail inválido";
    }
  }

  @computed
  bool get passValid => password != null && password != '';
  String? get passError {
    if (password == null || passValid) {
      return null;
    } else {
      return 'Senha obrigatória';
    }
  }

  @computed
  bool get formValid => passValid && emailValid;

  @computed
  Function? get logInPressed => formValid && !loading ? _logIn : null;

  @action
  Future<void> _logIn() async {
    loading = true;
    error = null;

    try {
      final result = await login(email, password);
      GetIt.I<UserManagerStore>().setUser(result);
    } catch (e) {
      error = e as String?;
    }
    loading = false;
  }
}

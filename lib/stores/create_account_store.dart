import 'package:mobx/mobx.dart';
import 'package:smart_chair_frontend/http/user_controller.dart';
import 'package:smart_chair_frontend/models/user.dart';
import 'dart:async';

part 'create_account_store.g.dart';

class CreateAccountStore = _CreateAccountStore with _$CreateAccountStore;

abstract class _CreateAccountStore with Store {
  @observable
  String? name;

  @observable
  String? email;

  @observable
  String? password;

  @observable
  String? confirmPassword;

  @observable
  String? result;

  @action
  void setName(String value) => name = value;

  @action
  void setEmail(String value) => email = value;

  @action
  void setPassword(String value) => password = value;

  @action
  void setConfirmPassword(String value) => confirmPassword = value;

  @computed
  bool get nameValid => name != null && name != '';
  String? get nameError {
    if (name == null || nameValid) {
      return null;
    } else {
      return 'Nome obrigatório';
    }
  }

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
  bool get confirmPasswordValid =>
      confirmPassword != null && password == confirmPassword;
  String? get confirmPassError {
    if (confirmPasswordValid || confirmPassword == null) {
      return null;
    } else {
      return "Senhas não identicas";
    }
  }

  @computed
  bool get formValid => passValid && emailValid && confirmPasswordValid;

  @computed
  Function? get createAccountPressed =>
      formValid && !loading ? _createAccount : null;

  @observable
  bool loading = false;

  @observable
  String? error;

  @action
  Future<void> _createAccount() async {
    loading = true;
    error = null;

    try {
      result = await createUser(email, password, {});
    } catch (e) {
      error = e as String?;
    }
    loading = false;
  }
}

import 'package:mobx/mobx.dart';
import 'dart:async';

import 'package:smart_chair_frontend/http/user_controller.dart';

part 'forgot_pass_store.g.dart';

class ForgotPassStore = _ForgotPassStore with _$ForgotPassStore;

abstract class _ForgotPassStore with Store {
  @observable
  String? email;

  @observable
  String? password;

  @observable
  String? confirmPassword;

  @observable
  bool loading = false;

  @observable
  String? error;

  @observable
  String? result;

  @action
  void setEmail(String value) => email = value.toLowerCase();

  @action
  void setPassword(String value) => password = value;

  @action
  void setConfirmPassword(String value) => confirmPassword = value;

  @computed
  bool get emailValid =>
      email != null &&
      email != '' &&
      RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
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
  Function? get resetPasswordPressed =>
      formValid && !loading ? _resetPassword : null;

  @action
  Future<void> _resetPassword() async {
    loading = true;
    error = null;

    try {
      result = await forgotPassword(email!, password!);
    } catch (e) {
      error = e.toString();
    }
    loading = false;
  }
}

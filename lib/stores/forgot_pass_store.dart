import 'package:mobx/mobx.dart';
import 'dart:async';

import 'package:smart_chair_frontend/http/user_controller.dart';

part 'forgot_pass_store.g.dart';

class ForgotPassStore = _ForgotPassStore with _$ForgotPassStore;

abstract class _ForgotPassStore with Store {
  @observable
  String? email;

  @observable
  bool loading = false;

  @observable
  String? error;

  @observable
  String? result;

  @action
  void setEmail(String value) => email = value.toLowerCase();

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
  bool get formValid => emailValid;

  @computed
  Function? get sendEmailPressed => formValid && !loading ? _sendEmail : null;

  @action
  Future<void> _sendEmail() async {
    loading = true;
    error = null;

    try {
      await forgotPassword(email!);
    } catch (e) {
      error = e.toString();
    }
    loading = false;
  }
}

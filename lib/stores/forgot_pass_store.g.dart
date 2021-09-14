// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forgot_pass_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ForgotPassStore on _ForgotPassStore, Store {
  Computed<bool>? _$emailValidComputed;

  @override
  bool get emailValid =>
      (_$emailValidComputed ??= Computed<bool>(() => super.emailValid,
              name: '_ForgotPassStore.emailValid'))
          .value;
  Computed<bool>? _$passValidComputed;

  @override
  bool get passValid =>
      (_$passValidComputed ??= Computed<bool>(() => super.passValid,
              name: '_ForgotPassStore.passValid'))
          .value;
  Computed<bool>? _$confirmPasswordValidComputed;

  @override
  bool get confirmPasswordValid => (_$confirmPasswordValidComputed ??=
          Computed<bool>(() => super.confirmPasswordValid,
              name: '_ForgotPassStore.confirmPasswordValid'))
      .value;
  Computed<bool>? _$formValidComputed;

  @override
  bool get formValid =>
      (_$formValidComputed ??= Computed<bool>(() => super.formValid,
              name: '_ForgotPassStore.formValid'))
          .value;
  Computed<Function?>? _$resetPasswordPressedComputed;

  @override
  Function? get resetPasswordPressed => (_$resetPasswordPressedComputed ??=
          Computed<Function?>(() => super.resetPasswordPressed,
              name: '_ForgotPassStore.resetPasswordPressed'))
      .value;

  final _$emailAtom = Atom(name: '_ForgotPassStore.email');

  @override
  String? get email {
    _$emailAtom.reportRead();
    return super.email;
  }

  @override
  set email(String? value) {
    _$emailAtom.reportWrite(value, super.email, () {
      super.email = value;
    });
  }

  final _$passwordAtom = Atom(name: '_ForgotPassStore.password');

  @override
  String? get password {
    _$passwordAtom.reportRead();
    return super.password;
  }

  @override
  set password(String? value) {
    _$passwordAtom.reportWrite(value, super.password, () {
      super.password = value;
    });
  }

  final _$confirmPasswordAtom = Atom(name: '_ForgotPassStore.confirmPassword');

  @override
  String? get confirmPassword {
    _$confirmPasswordAtom.reportRead();
    return super.confirmPassword;
  }

  @override
  set confirmPassword(String? value) {
    _$confirmPasswordAtom.reportWrite(value, super.confirmPassword, () {
      super.confirmPassword = value;
    });
  }

  final _$loadingAtom = Atom(name: '_ForgotPassStore.loading');

  @override
  bool get loading {
    _$loadingAtom.reportRead();
    return super.loading;
  }

  @override
  set loading(bool value) {
    _$loadingAtom.reportWrite(value, super.loading, () {
      super.loading = value;
    });
  }

  final _$errorAtom = Atom(name: '_ForgotPassStore.error');

  @override
  String? get error {
    _$errorAtom.reportRead();
    return super.error;
  }

  @override
  set error(String? value) {
    _$errorAtom.reportWrite(value, super.error, () {
      super.error = value;
    });
  }

  final _$resultAtom = Atom(name: '_ForgotPassStore.result');

  @override
  String? get result {
    _$resultAtom.reportRead();
    return super.result;
  }

  @override
  set result(String? value) {
    _$resultAtom.reportWrite(value, super.result, () {
      super.result = value;
    });
  }

  final _$_resetPasswordAsyncAction =
      AsyncAction('_ForgotPassStore._resetPassword');

  @override
  Future<void> _resetPassword() {
    return _$_resetPasswordAsyncAction.run(() => super._resetPassword());
  }

  final _$_ForgotPassStoreActionController =
      ActionController(name: '_ForgotPassStore');

  @override
  void setEmail(String value) {
    final _$actionInfo = _$_ForgotPassStoreActionController.startAction(
        name: '_ForgotPassStore.setEmail');
    try {
      return super.setEmail(value);
    } finally {
      _$_ForgotPassStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPassword(String value) {
    final _$actionInfo = _$_ForgotPassStoreActionController.startAction(
        name: '_ForgotPassStore.setPassword');
    try {
      return super.setPassword(value);
    } finally {
      _$_ForgotPassStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setConfirmPassword(String value) {
    final _$actionInfo = _$_ForgotPassStoreActionController.startAction(
        name: '_ForgotPassStore.setConfirmPassword');
    try {
      return super.setConfirmPassword(value);
    } finally {
      _$_ForgotPassStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
email: ${email},
password: ${password},
confirmPassword: ${confirmPassword},
loading: ${loading},
error: ${error},
result: ${result},
emailValid: ${emailValid},
passValid: ${passValid},
confirmPasswordValid: ${confirmPasswordValid},
formValid: ${formValid},
resetPasswordPressed: ${resetPasswordPressed}
    ''';
  }
}

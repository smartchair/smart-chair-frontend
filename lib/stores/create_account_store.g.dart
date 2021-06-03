// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_account_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CreateAccountStore on _CreateAccountStore, Store {
  Computed<bool> _$nameValidComputed;

  @override
  bool get nameValid =>
      (_$nameValidComputed ??= Computed<bool>(() => super.nameValid,
              name: '_CreateAccountStore.nameValid'))
          .value;
  Computed<bool> _$emailValidComputed;

  @override
  bool get emailValid =>
      (_$emailValidComputed ??= Computed<bool>(() => super.emailValid,
              name: '_CreateAccountStore.emailValid'))
          .value;
  Computed<bool> _$passValidComputed;

  @override
  bool get passValid =>
      (_$passValidComputed ??= Computed<bool>(() => super.passValid,
              name: '_CreateAccountStore.passValid'))
          .value;
  Computed<bool> _$confirmPasswordValidComputed;

  @override
  bool get confirmPasswordValid => (_$confirmPasswordValidComputed ??=
          Computed<bool>(() => super.confirmPasswordValid,
              name: '_CreateAccountStore.confirmPasswordValid'))
      .value;
  Computed<bool> _$formValidComputed;

  @override
  bool get formValid =>
      (_$formValidComputed ??= Computed<bool>(() => super.formValid,
              name: '_CreateAccountStore.formValid'))
          .value;
  Computed<Function> _$createAccountPressedComputed;

  @override
  Function get createAccountPressed => (_$createAccountPressedComputed ??=
          Computed<Function>(() => super.createAccountPressed,
              name: '_CreateAccountStore.createAccountPressed'))
      .value;

  final _$nameAtom = Atom(name: '_CreateAccountStore.name');

  @override
  String get name {
    _$nameAtom.reportRead();
    return super.name;
  }

  @override
  set name(String value) {
    _$nameAtom.reportWrite(value, super.name, () {
      super.name = value;
    });
  }

  final _$emailAtom = Atom(name: '_CreateAccountStore.email');

  @override
  String get email {
    _$emailAtom.reportRead();
    return super.email;
  }

  @override
  set email(String value) {
    _$emailAtom.reportWrite(value, super.email, () {
      super.email = value;
    });
  }

  final _$passwordAtom = Atom(name: '_CreateAccountStore.password');

  @override
  String get password {
    _$passwordAtom.reportRead();
    return super.password;
  }

  @override
  set password(String value) {
    _$passwordAtom.reportWrite(value, super.password, () {
      super.password = value;
    });
  }

  final _$confirmPasswordAtom =
      Atom(name: '_CreateAccountStore.confirmPassword');

  @override
  String get confirmPassword {
    _$confirmPasswordAtom.reportRead();
    return super.confirmPassword;
  }

  @override
  set confirmPassword(String value) {
    _$confirmPasswordAtom.reportWrite(value, super.confirmPassword, () {
      super.confirmPassword = value;
    });
  }

  final _$resultAtom = Atom(name: '_CreateAccountStore.result');

  @override
  String get result {
    _$resultAtom.reportRead();
    return super.result;
  }

  @override
  set result(String value) {
    _$resultAtom.reportWrite(value, super.result, () {
      super.result = value;
    });
  }

  final _$loadingAtom = Atom(name: '_CreateAccountStore.loading');

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

  final _$errorAtom = Atom(name: '_CreateAccountStore.error');

  @override
  String get error {
    _$errorAtom.reportRead();
    return super.error;
  }

  @override
  set error(String value) {
    _$errorAtom.reportWrite(value, super.error, () {
      super.error = value;
    });
  }

  final _$_createAccountAsyncAction =
      AsyncAction('_CreateAccountStore._createAccount');

  @override
  Future<void> _createAccount() {
    return _$_createAccountAsyncAction.run(() => super._createAccount());
  }

  final _$_CreateAccountStoreActionController =
      ActionController(name: '_CreateAccountStore');

  @override
  void setName(String value) {
    final _$actionInfo = _$_CreateAccountStoreActionController.startAction(
        name: '_CreateAccountStore.setName');
    try {
      return super.setName(value);
    } finally {
      _$_CreateAccountStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setEmail(String value) {
    final _$actionInfo = _$_CreateAccountStoreActionController.startAction(
        name: '_CreateAccountStore.setEmail');
    try {
      return super.setEmail(value);
    } finally {
      _$_CreateAccountStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPassword(String value) {
    final _$actionInfo = _$_CreateAccountStoreActionController.startAction(
        name: '_CreateAccountStore.setPassword');
    try {
      return super.setPassword(value);
    } finally {
      _$_CreateAccountStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setConfirmPassword(String value) {
    final _$actionInfo = _$_CreateAccountStoreActionController.startAction(
        name: '_CreateAccountStore.setConfirmPassword');
    try {
      return super.setConfirmPassword(value);
    } finally {
      _$_CreateAccountStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
name: ${name},
email: ${email},
password: ${password},
confirmPassword: ${confirmPassword},
result: ${result},
loading: ${loading},
error: ${error},
nameValid: ${nameValid},
emailValid: ${emailValid},
passValid: ${passValid},
confirmPasswordValid: ${confirmPasswordValid},
formValid: ${formValid},
createAccountPressed: ${createAccountPressed}
    ''';
  }
}

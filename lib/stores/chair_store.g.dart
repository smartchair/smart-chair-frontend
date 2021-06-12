// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chair_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ChairStore on _ChairStore, Store {
  Computed<bool> _$nameValidComputed;

  @override
  bool get nameValid => (_$nameValidComputed ??=
          Computed<bool>(() => super.nameValid, name: '_ChairStore.nameValid'))
      .value;
  Computed<Function> _$deviceNamePressedComputed;

  @override
  Function get deviceNamePressed => (_$deviceNamePressedComputed ??=
          Computed<Function>(() => super.deviceNamePressed,
              name: '_ChairStore.deviceNamePressed'))
      .value;

  final _$resultAtom = Atom(name: '_ChairStore.result');

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

  final _$errorAtom = Atom(name: '_ChairStore.error');

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

  final _$loadingAtom = Atom(name: '_ChairStore.loading');

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

  final _$chairNicknameAtom = Atom(name: '_ChairStore.chairNickname');

  @override
  String get chairNickname {
    _$chairNicknameAtom.reportRead();
    return super.chairNickname;
  }

  @override
  set chairNickname(String value) {
    _$chairNicknameAtom.reportWrite(value, super.chairNickname, () {
      super.chairNickname = value;
    });
  }

  final _$chairIdAtom = Atom(name: '_ChairStore.chairId');

  @override
  String get chairId {
    _$chairIdAtom.reportRead();
    return super.chairId;
  }

  @override
  set chairId(String value) {
    _$chairIdAtom.reportWrite(value, super.chairId, () {
      super.chairId = value;
    });
  }

  final _$btnClickedAtom = Atom(name: '_ChairStore.btnClicked');

  @override
  bool get btnClicked {
    _$btnClickedAtom.reportRead();
    return super.btnClicked;
  }

  @override
  set btnClicked(bool value) {
    _$btnClickedAtom.reportWrite(value, super.btnClicked, () {
      super.btnClicked = value;
    });
  }

  final _$getChairAsyncAction = AsyncAction('_ChairStore.getChair');

  @override
  Future<void> getChair() {
    return _$getChairAsyncAction.run(() => super.getChair());
  }

  final _$addChairAsyncAction = AsyncAction('_ChairStore.addChair');

  @override
  Future<void> addChair() {
    return _$addChairAsyncAction.run(() => super.addChair());
  }

  final _$_ChairStoreActionController = ActionController(name: '_ChairStore');

  @override
  void setError(String value) {
    final _$actionInfo =
        _$_ChairStoreActionController.startAction(name: '_ChairStore.setError');
    try {
      return super.setError(value);
    } finally {
      _$_ChairStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setChairNickname(String value) {
    final _$actionInfo = _$_ChairStoreActionController.startAction(
        name: '_ChairStore.setChairNickname');
    try {
      return super.setChairNickname(value);
    } finally {
      _$_ChairStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
result: ${result},
error: ${error},
loading: ${loading},
chairNickname: ${chairNickname},
chairId: ${chairId},
btnClicked: ${btnClicked},
nameValid: ${nameValid},
deviceNamePressed: ${deviceNamePressed}
    ''';
  }
}

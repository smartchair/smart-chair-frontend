// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chair_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ChairStore on _ChairStore, Store {
  Computed<bool>? _$nameValidComputed;

  @override
  bool get nameValid => (_$nameValidComputed ??=
          Computed<bool>(() => super.nameValid, name: '_ChairStore.nameValid'))
      .value;
  Computed<Function?>? _$deviceNamePressedComputed;

  @override
  Function? get deviceNamePressed => (_$deviceNamePressedComputed ??=
          Computed<Function?>(() => super.deviceNamePressed,
              name: '_ChairStore.deviceNamePressed'))
      .value;

  final _$lastRefreshAtom = Atom(name: '_ChairStore.lastRefresh');

  @override
  DateTime? get lastRefresh {
    _$lastRefreshAtom.reportRead();
    return super.lastRefresh;
  }

  @override
  set lastRefresh(DateTime? value) {
    _$lastRefreshAtom.reportWrite(value, super.lastRefresh, () {
      super.lastRefresh = value;
    });
  }

  final _$resultAtom = Atom(name: '_ChairStore.result');

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

  final _$errorAtom = Atom(name: '_ChairStore.error');

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
  String? get chairNickname {
    _$chairNicknameAtom.reportRead();
    return super.chairNickname;
  }

  @override
  set chairNickname(String? value) {
    _$chairNicknameAtom.reportWrite(value, super.chairNickname, () {
      super.chairNickname = value;
    });
  }

  final _$chairIdAtom = Atom(name: '_ChairStore.chairId');

  @override
  String? get chairId {
    _$chairIdAtom.reportRead();
    return super.chairId;
  }

  @override
  set chairId(String? value) {
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

  final _$selectedChairAtom = Atom(name: '_ChairStore.selectedChair');

  @override
  String? get selectedChair {
    _$selectedChairAtom.reportRead();
    return super.selectedChair;
  }

  @override
  set selectedChair(String? value) {
    _$selectedChairAtom.reportWrite(value, super.selectedChair, () {
      super.selectedChair = value;
    });
  }

  final _$getChairAsyncAction = AsyncAction('_ChairStore.getChair');

  @override
  Future<void> getChair([dynamic chair]) {
    return _$getChairAsyncAction.run(() => super.getChair(chair));
  }

  final _$addChairAsyncAction = AsyncAction('_ChairStore.addChair');

  @override
  Future<void> addChair() {
    return _$addChairAsyncAction.run(() => super.addChair());
  }

  final _$removeChairAsyncAction = AsyncAction('_ChairStore.removeChair');

  @override
  Future<void> removeChair() {
    return _$removeChairAsyncAction.run(() => super.removeChair());
  }

  final _$_ChairStoreActionController = ActionController(name: '_ChairStore');

  @override
  void setError(String? value) {
    final _$actionInfo =
        _$_ChairStoreActionController.startAction(name: '_ChairStore.setError');
    try {
      return super.setError(value);
    } finally {
      _$_ChairStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setChairNickname(String? value) {
    final _$actionInfo = _$_ChairStoreActionController.startAction(
        name: '_ChairStore.setChairNickname');
    try {
      return super.setChairNickname(value);
    } finally {
      _$_ChairStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setChairId(String? value) {
    final _$actionInfo = _$_ChairStoreActionController.startAction(
        name: '_ChairStore.setChairId');
    try {
      return super.setChairId(value);
    } finally {
      _$_ChairStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setChangedChair(String? value) {
    final _$actionInfo = _$_ChairStoreActionController.startAction(
        name: '_ChairStore.setChangedChair');
    try {
      return super.setChangedChair(value);
    } finally {
      _$_ChairStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setLastRefreshChairs(DateTime? value) {
    final _$actionInfo = _$_ChairStoreActionController.startAction(
        name: '_ChairStore.setLastRefreshChairs');
    try {
      return super.setLastRefreshChairs(value);
    } finally {
      _$_ChairStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void resetChair(String? value) {
    final _$actionInfo = _$_ChairStoreActionController.startAction(
        name: '_ChairStore.resetChair');
    try {
      return super.resetChair(value);
    } finally {
      _$_ChairStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
lastRefresh: ${lastRefresh},
result: ${result},
error: ${error},
loading: ${loading},
chairNickname: ${chairNickname},
chairId: ${chairId},
btnClicked: ${btnClicked},
selectedChair: ${selectedChair},
nameValid: ${nameValid},
deviceNamePressed: ${deviceNamePressed}
    ''';
  }
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chair_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ChairStore on _ChairStore, Store {
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

  final _$getChairAsyncAction = AsyncAction('_ChairStore.getChair');

  @override
  Future<void> getChair(String email) {
    return _$getChairAsyncAction.run(() => super.getChair(email));
  }

  final _$addChairAsyncAction = AsyncAction('_ChairStore.addChair');

  @override
  Future<void> addChair(Chair chair) {
    return _$addChairAsyncAction.run(() => super.addChair(chair));
  }

  final _$_ChairStoreActionController = ActionController(name: '_ChairStore');

  @override
  void setChairs(List<String> chairs) {
    final _$actionInfo = _$_ChairStoreActionController.startAction(
        name: '_ChairStore.setChairs');
    try {
      return super.setChairs(chairs);
    } finally {
      _$_ChairStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
result: ${result},
error: ${error},
loading: ${loading}
    ''';
  }
}

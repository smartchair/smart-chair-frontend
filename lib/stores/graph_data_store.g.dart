// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'graph_data_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$GraphStore on _GraphStore, Store {
  final _$loadingAtom = Atom(name: '_GraphStore.loading');

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

  final _$tempAtom = Atom(name: '_GraphStore.temp');

  @override
  double get temp {
    _$tempAtom.reportRead();
    return super.temp;
  }

  @override
  set temp(double value) {
    _$tempAtom.reportWrite(value, super.temp, () {
      super.temp = value;
    });
  }

  final _$loadingTempAtom = Atom(name: '_GraphStore.loadingTemp');

  @override
  bool get loadingTemp {
    _$loadingTempAtom.reportRead();
    return super.loadingTemp;
  }

  @override
  set loadingTemp(bool value) {
    _$loadingTempAtom.reportWrite(value, super.loadingTemp, () {
      super.loadingTemp = value;
    });
  }

  final _$loadingLumAtom = Atom(name: '_GraphStore.loadingLum');

  @override
  bool get loadingLum {
    _$loadingLumAtom.reportRead();
    return super.loadingLum;
  }

  @override
  set loadingLum(bool value) {
    _$loadingLumAtom.reportWrite(value, super.loadingLum, () {
      super.loadingLum = value;
    });
  }

  final _$loadingHumAtom = Atom(name: '_GraphStore.loadingHum');

  @override
  bool get loadingHum {
    _$loadingHumAtom.reportRead();
    return super.loadingHum;
  }

  @override
  set loadingHum(bool value) {
    _$loadingHumAtom.reportWrite(value, super.loadingHum, () {
      super.loadingHum = value;
    });
  }

  final _$errorAtom = Atom(name: '_GraphStore.error');

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

  final _$dateReferenceGraphsAtom =
      Atom(name: '_GraphStore.dateReferenceGraphs');

  @override
  String get dateReferenceGraphs {
    _$dateReferenceGraphsAtom.reportRead();
    return super.dateReferenceGraphs;
  }

  @override
  set dateReferenceGraphs(String value) {
    _$dateReferenceGraphsAtom.reportWrite(value, super.dateReferenceGraphs, () {
      super.dateReferenceGraphs = value;
    });
  }

  final _$getAverageSensorsAsyncAction =
      AsyncAction('_GraphStore.getAverageSensors');

  @override
  Future<void> getAverageSensors() {
    return _$getAverageSensorsAsyncAction.run(() => super.getAverageSensors());
  }

  final _$getDataCurrentDayTempAsyncAction =
      AsyncAction('_GraphStore.getDataCurrentDayTemp');

  @override
  Future<void> getDataCurrentDayTemp() {
    return _$getDataCurrentDayTempAsyncAction
        .run(() => super.getDataCurrentDayTemp());
  }

  final _$getDataCurrentDayLumAsyncAction =
      AsyncAction('_GraphStore.getDataCurrentDayLum');

  @override
  Future<void> getDataCurrentDayLum() {
    return _$getDataCurrentDayLumAsyncAction
        .run(() => super.getDataCurrentDayLum());
  }

  final _$getDataCurrentDayHumAsyncAction =
      AsyncAction('_GraphStore.getDataCurrentDayHum');

  @override
  Future<void> getDataCurrentDayHum() {
    return _$getDataCurrentDayHumAsyncAction
        .run(() => super.getDataCurrentDayHum());
  }

  final _$_GraphStoreActionController = ActionController(name: '_GraphStore');

  @override
  void setReferenceDateGraphs(String value) {
    final _$actionInfo = _$_GraphStoreActionController.startAction(
        name: '_GraphStore.setReferenceDateGraphs');
    try {
      return super.setReferenceDateGraphs(value);
    } finally {
      _$_GraphStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void clearMaps() {
    final _$actionInfo = _$_GraphStoreActionController.startAction(
        name: '_GraphStore.clearMaps');
    try {
      return super.clearMaps();
    } finally {
      _$_GraphStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
loading: ${loading},
temp: ${temp},
loadingTemp: ${loadingTemp},
loadingLum: ${loadingLum},
loadingHum: ${loadingHum},
error: ${error},
dateReferenceGraphs: ${dateReferenceGraphs}
    ''';
  }
}

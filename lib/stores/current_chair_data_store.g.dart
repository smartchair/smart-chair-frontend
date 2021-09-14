// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'current_chair_data_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CurrentChairDataStore on _CurrentChairDataStore, Store {
  final _$loadingAtom = Atom(name: '_CurrentChairDataStore.loading');

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

  final _$tempAtom = Atom(name: '_CurrentChairDataStore.temp');

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

  final _$lumAtom = Atom(name: '_CurrentChairDataStore.lum');

  @override
  double get lum {
    _$lumAtom.reportRead();
    return super.lum;
  }

  @override
  set lum(double value) {
    _$lumAtom.reportWrite(value, super.lum, () {
      super.lum = value;
    });
  }

  final _$hoursAtom = Atom(name: '_CurrentChairDataStore.hours');

  @override
  String get hours {
    _$hoursAtom.reportRead();
    return super.hours;
  }

  @override
  set hours(String value) {
    _$hoursAtom.reportWrite(value, super.hours, () {
      super.hours = value;
    });
  }

  final _$minutesAtom = Atom(name: '_CurrentChairDataStore.minutes');

  @override
  int get minutes {
    _$minutesAtom.reportRead();
    return super.minutes;
  }

  @override
  set minutes(int value) {
    _$minutesAtom.reportWrite(value, super.minutes, () {
      super.minutes = value;
    });
  }

  final _$errorAtom = Atom(name: '_CurrentChairDataStore.error');

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

  final _$averageTempAtom = Atom(name: '_CurrentChairDataStore.averageTemp');

  @override
  double get averageTemp {
    _$averageTempAtom.reportRead();
    return super.averageTemp;
  }

  @override
  set averageTemp(double value) {
    _$averageTempAtom.reportWrite(value, super.averageTemp, () {
      super.averageTemp = value;
    });
  }

  final _$averageLumAtom = Atom(name: '_CurrentChairDataStore.averageLum');

  @override
  double get averageLum {
    _$averageLumAtom.reportRead();
    return super.averageLum;
  }

  @override
  set averageLum(double value) {
    _$averageLumAtom.reportWrite(value, super.averageLum, () {
      super.averageLum = value;
    });
  }

  final _$averageHumAtom = Atom(name: '_CurrentChairDataStore.averageHum');

  @override
  double get averageHum {
    _$averageHumAtom.reportRead();
    return super.averageHum;
  }

  @override
  set averageHum(double value) {
    _$averageHumAtom.reportWrite(value, super.averageHum, () {
      super.averageHum = value;
    });
  }

  final _$averageNoiseAtom = Atom(name: '_CurrentChairDataStore.averageNoise');

  @override
  double get averageNoise {
    _$averageNoiseAtom.reportRead();
    return super.averageNoise;
  }

  @override
  set averageNoise(double value) {
    _$averageNoiseAtom.reportWrite(value, super.averageNoise, () {
      super.averageNoise = value;
    });
  }

  final _$getCurrentTempAsyncAction =
      AsyncAction('_CurrentChairDataStore.getCurrentTemp');

  @override
  Future<void> getCurrentTemp(String? chair) {
    return _$getCurrentTempAsyncAction.run(() => super.getCurrentTemp(chair));
  }

  final _$getCurrentLumAsyncAction =
      AsyncAction('_CurrentChairDataStore.getCurrentLum');

  @override
  Future<void> getCurrentLum(String? chair) {
    return _$getCurrentLumAsyncAction.run(() => super.getCurrentLum(chair));
  }

  final _$getPresenceAsyncAction =
      AsyncAction('_CurrentChairDataStore.getPresence');

  @override
  Future<void> getPresence(String? chair) {
    return _$getPresenceAsyncAction.run(() => super.getPresence(chair));
  }

  final _$getAllAverageDataCurrentChairAsyncAction =
      AsyncAction('_CurrentChairDataStore.getAllAverageDataCurrentChair');

  @override
  Future<void> getAllAverageDataCurrentChair(String? chair) {
    return _$getAllAverageDataCurrentChairAsyncAction
        .run(() => super.getAllAverageDataCurrentChair(chair));
  }

  final _$_CurrentChairDataStoreActionController =
      ActionController(name: '_CurrentChairDataStore');

  @override
  void resetChairData(double value) {
    final _$actionInfo = _$_CurrentChairDataStoreActionController.startAction(
        name: '_CurrentChairDataStore.resetChairData');
    try {
      return super.resetChairData(value);
    } finally {
      _$_CurrentChairDataStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
loading: ${loading},
temp: ${temp},
lum: ${lum},
hours: ${hours},
minutes: ${minutes},
error: ${error},
averageTemp: ${averageTemp},
averageLum: ${averageLum},
averageHum: ${averageHum},
averageNoise: ${averageNoise}
    ''';
  }
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme_test_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ThemeTestStore on _ThemeTestStore, Store {
  Computed<ThemeMode>? _$themeModeComputed;

  @override
  ThemeMode get themeMode =>
      (_$themeModeComputed ??= Computed<ThemeMode>(() => super.themeMode,
              name: '_ThemeTestStore.themeMode'))
          .value;

  final _$isDarkAtom = Atom(name: '_ThemeTestStore.isDark');

  @override
  bool get isDark {
    _$isDarkAtom.reportRead();
    return super.isDark;
  }

  @override
  set isDark(bool value) {
    _$isDarkAtom.reportWrite(value, super.isDark, () {
      super.isDark = value;
    });
  }

  final _$isLightAtom = Atom(name: '_ThemeTestStore.isLight');

  @override
  bool get isLight {
    _$isLightAtom.reportRead();
    return super.isLight;
  }

  @override
  set isLight(bool value) {
    _$isLightAtom.reportWrite(value, super.isLight, () {
      super.isLight = value;
    });
  }

  final _$isThemeAutomaticAtom = Atom(name: '_ThemeTestStore.isThemeAutomatic');

  @override
  bool get isThemeAutomatic {
    _$isThemeAutomaticAtom.reportRead();
    return super.isThemeAutomatic;
  }

  @override
  set isThemeAutomatic(bool value) {
    _$isThemeAutomaticAtom.reportWrite(value, super.isThemeAutomatic, () {
      super.isThemeAutomatic = value;
    });
  }

  final _$_ThemeTestStoreActionController =
      ActionController(name: '_ThemeTestStore');

  @override
  void setDarkTheme(bool value) {
    final _$actionInfo = _$_ThemeTestStoreActionController.startAction(
        name: '_ThemeTestStore.setDarkTheme');
    try {
      return super.setDarkTheme(value);
    } finally {
      _$_ThemeTestStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setLightTheme(bool value) {
    final _$actionInfo = _$_ThemeTestStoreActionController.startAction(
        name: '_ThemeTestStore.setLightTheme');
    try {
      return super.setLightTheme(value);
    } finally {
      _$_ThemeTestStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setAutomaticTheme(bool value) {
    final _$actionInfo = _$_ThemeTestStoreActionController.startAction(
        name: '_ThemeTestStore.setAutomaticTheme');
    try {
      return super.setAutomaticTheme(value);
    } finally {
      _$_ThemeTestStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isDark: ${isDark},
isLight: ${isLight},
isThemeAutomatic: ${isThemeAutomatic},
themeMode: ${themeMode}
    ''';
  }
}

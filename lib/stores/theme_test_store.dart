import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'theme_test_store.g.dart';

class ThemeTestStore = _ThemeTestStore with _$ThemeTestStore;

abstract class _ThemeTestStore with Store {
  @observable
  bool isDark = false;

  @observable
  bool isLight = false;

  @observable
  bool isThemeAutomatic = true;

  @computed
  ThemeMode get themeMode {
    if (isDark) {
      _setThemePrefs(true, false, false);
      return ThemeMode.dark;
    } else if (isLight) {
      _setThemePrefs(false, true, false);
      return ThemeMode.light;
    } else {
      _setThemePrefs(false, false, true);
      return ThemeMode.system;
    }
  }

  @action
  void setDarkTheme(bool value) => isDark = value;
  @action
  void setLightTheme(bool value) => isLight = value;
  @action
  void setAutomaticTheme(bool value) => isThemeAutomatic = value;

  void _setThemePrefs(bool isDark, bool isLight, isSystem) async {
    print('isDark $isDark');
    print('isLight $isLight');
    print('isSystem $isSystem');

    SharedPreferences prefsTheme = await SharedPreferences.getInstance();

    prefsTheme.setBool('isDark', isDark);
    prefsTheme.setBool('isLight', isLight);
    prefsTheme.setBool('isSystem', isSystem);

    print('isDarkValue ${prefsTheme.getBool('isDark')}');
    print('isLightValue ${prefsTheme.getBool('isLight')}');
    print('isSystemValue ${prefsTheme.getBool('isSystem')}');
  }
}

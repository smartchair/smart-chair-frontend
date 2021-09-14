import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_chair_frontend/stores/chair_store.dart';
import 'package:smart_chair_frontend/stores/connectivity_store.dart';
import 'package:smart_chair_frontend/stores/current_chair_data_store.dart';
import 'package:smart_chair_frontend/stores/graph_data_store.dart';
import 'package:smart_chair_frontend/stores/theme_test_store.dart';
import 'package:smart_chair_frontend/stores/user_manager_store.dart';
import 'package:smart_chair_frontend/utils/const.dart';

import 'screens/loginPage/login_page.dart';
import 'utils/notification_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService().init();
  setupLocators();
  await getPrefsTheme();
  runApp(MyApp());
}

void setupLocators() {
  GetIt.I.registerSingleton(UserManagerStore());
  GetIt.I.registerSingleton(ChairStore());
  GetIt.I.registerSingleton(GraphStore());
  GetIt.I.registerSingleton(CurrentChairDataStore());
  GetIt.I.registerSingleton(ConnectivityStore());
  GetIt.I.registerSingleton(ThemeTestStore());
}

Future<void> getPrefsTheme() async {
  final ThemeTestStore themeTestStore = GetIt.I<ThemeTestStore>();
  SharedPreferences prefsTheme = await SharedPreferences.getInstance();

  if (prefsTheme.containsKey('isDark')) {
    var theme = prefsTheme.getBool('isDark');
    if (theme!) {
      themeTestStore.setDarkTheme(true);
      themeTestStore.setLightTheme(false);
      themeTestStore.setAutomaticTheme(false);
    }
  }
  if (prefsTheme.containsKey('isLight')) {
    var theme = prefsTheme.getBool('isLight');
    if (theme!) {
      themeTestStore.setDarkTheme(false);
      themeTestStore.setLightTheme(true);
      themeTestStore.setAutomaticTheme(false);
    }
  }
  if (prefsTheme.containsKey('isSystem')) {
    var theme = prefsTheme.getBool('isSystem');
    if (theme!) {
      themeTestStore.setDarkTheme(false);
      themeTestStore.setLightTheme(false);
      themeTestStore.setAutomaticTheme(true);
    }
  }
}

class MyApp extends StatelessWidget {
  final ThemeTestStore themeTestStore = GetIt.I<ThemeTestStore>();

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MaterialApp(
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate
        ],
        supportedLocales: [const Locale('pt', 'BR')],
        debugShowCheckedModeBanner: false,
        title: 'Smart Chair',
        themeMode: themeTestStore.themeMode,
        theme: ThemeData(
          appBarTheme: AppBarTheme(
              backgroundColor: customColor,
              iconTheme: IconThemeData(color: Colors.white),
              actionsIconTheme: IconThemeData(color: Colors.white)),
          primaryColor: customColor,
          accentColor: customColor,
          highlightColor: Colors.white.withOpacity(0.2),
          textSelectionTheme: TextSelectionThemeData(cursorColor: customColor),
        ),
        darkTheme: ThemeData(
          appBarTheme: AppBarTheme(
              backgroundColor: customColor,
              iconTheme: IconThemeData(color: Colors.white),
              actionsIconTheme: IconThemeData(color: Colors.white)),
          primaryColor: customColor,
          accentColor: customColor,
          brightness: Brightness.dark,
          textSelectionTheme: TextSelectionThemeData(cursorColor: customColor),
          inputDecorationTheme: InputDecorationTheme(
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: Colors.white),
            ),
          ),
        ),
        home: LoginPage(),
      ),
    );
  }
}

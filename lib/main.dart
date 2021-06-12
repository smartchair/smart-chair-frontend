import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:smart_chair_frontend/stores/chair_store.dart';
import 'package:smart_chair_frontend/stores/current_chair_data_store.dart';
import 'package:smart_chair_frontend/stores/graph_data_store.dart';
import 'package:smart_chair_frontend/stores/user_manager_store.dart';
import 'screens/loginPage/login_page.dart';

void main() {
  runApp(MyApp());
  setupLocators();
}

void setupLocators() {
  GetIt.I.registerSingleton(UserManagerStore());
  GetIt.I.registerSingleton(ChairStore());
  GetIt.I.registerSingleton(GraphStore());
  GetIt.I.registerSingleton(CurrentChairDataStore());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'POC APP FLUTTER',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
    );
  }
}

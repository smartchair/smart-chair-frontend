import 'package:connectivity/connectivity.dart';
import 'package:flutter/services.dart';
import 'package:mobx/mobx.dart';

part 'connectivity_store.g.dart';

class ConnectivityStore = _ConnectivityStore with _$ConnectivityStore;

abstract class _ConnectivityStore with Store {
  _ConnectivityStore() {
    initConnectivity();
  }

  @observable
  bool isConnected = false;

  @observable
  bool loading = false;

  ConnectivityResult result = ConnectivityResult.none;

  @action
  Future<void> initConnectivity() async {
    final Connectivity _connectivity = Connectivity();
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      //result = await _connectivity.checkConnectivity();
      _connectivity.onConnectivityChanged.listen((event) {
        switch (event) {
          case ConnectivityResult.wifi:
          case ConnectivityResult.mobile:
            isConnected = true;
            break;
          case ConnectivityResult.none:
            isConnected = false;
            break;
        }
      });
    } on PlatformException catch (e) {
      print(e.toString());
    }
  }
}

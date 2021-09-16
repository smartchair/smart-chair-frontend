import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:smart_chair_frontend/stores/connectivity_store.dart';
import 'package:smart_chair_frontend/utils/const.dart';

class OfflinePage extends StatefulWidget {
  const OfflinePage({Key? key}) : super(key: key);

  @override
  _OfflinePageState createState() => _OfflinePageState();
}

class _OfflinePageState extends State<OfflinePage> {
  final ConnectivityStore connectivityStore = GetIt.I<ConnectivityStore>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    when((_) => connectivityStore.isConnected, () async {
      Navigator.of(context).pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              child: Center(
                child: Text(
                  'Sem conexão com a internet',
                  style: TextStyle(
                      color: customColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w700),
                ),
              ),
            ),
            Icon(
              Icons.cloud_off,
              color: customColor,
              size: 150,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Por favor, verifique sua conexão com a internet para continuar a usar o app',
                style: TextStyle(
                  color: customColor,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

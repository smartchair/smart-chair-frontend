import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:smart_chair_frontend/bottomButtonWidget/bottom_button.dart';
import 'package:smart_chair_frontend/bottomNavigationBarMenu/bottom_navigation_bar_menu.dart';
import 'dart:async';
import 'package:smart_chair_frontend/models/chair.dart';
import 'package:smart_chair_frontend/screens/chairNamePage/chair_name_page.dart';
import 'package:smart_chair_frontend/screens/codeScanPage/code_scan_page.dart';
import 'package:smart_chair_frontend/screens/loginPage/login_page.dart';
import 'package:smart_chair_frontend/stores/chair_store.dart';
import 'package:smart_chair_frontend/stores/user_manager_store.dart';
import 'package:smart_chair_frontend/utils/const.dart';

class DevicePage extends StatefulWidget {
  DevicePage({Key key}) : super(key: key);

  @override
  _DevicePageState createState() => _DevicePageState();
}

class _DevicePageState extends State<DevicePage> {
  final UserManagerStore userManagerStore = GetIt.I<UserManagerStore>();
  final ChairStore chairStore = GetIt.I<ChairStore>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    when((_) => userManagerStore.user.chairs.isEmpty, () {
      Future.delayed(Duration(milliseconds: 200), chairStore.getChair);
    });

    // autorun((_) {
    //   Future.delayed(Duration(milliseconds: 200), chairStore.getChair);
    // });

    when((_) => chairStore.error != null, () {
      _showAlertDialog(context, chairStore.error);
      chairStore.setError(null);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meus dispositivos'),
        centerTitle: true,
        backgroundColor: customColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_rounded),
          onPressed: () => Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (_) => BottomNavigationBarMenu())),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.all(10.0),
            child: IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ScanScreen()));
              },
            ),
          ),
        ],
      ),
      body: Observer(builder: (_) {
        if (chairStore.loading) {
          return Center(child: CircularProgressIndicator());
        } else if (!chairStore.loading &&
            userManagerStore.user.chairs.length == 0) {
          return Center(
            child: Container(
              child: Text(
                "Nenhum dispositivo cadastrado",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
            ),
          );
        } else if (chairStore.error == "Por favor faça seu login novamente") {
          return Center(
            child: Container(
              child: Column(
                children: [
                  Text(chairStore.error),
                  SizedBox(
                    height: 12,
                  ),
                  BottomButton(false, primaryColor, customColor, "Login", () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (_) => LoginPage()));
                  })
                ],
              ),
            ),
          );
        } else {
          return RefreshIndicator(
            onRefresh: () => chairStore.getChair(),
            child: ListView.separated(
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(
                thickness: 2,
              ),
              itemCount: userManagerStore.user.chairs.length,
              itemBuilder: (context, index) {
                var listNameChairs =
                    userManagerStore.user.chairs.values.toList();
                var listIdsChairs = userManagerStore.user.chairs.keys.toList();
                return Container(
                  padding: EdgeInsets.all(8),
                  child: Dismissible(
                    key: Key(DateTime.now().microsecondsSinceEpoch.toString()),
                    background: Container(
                      padding: EdgeInsets.all(10),
                      color: Colors.red[400],
                      child: Align(
                        alignment: Alignment.centerRight,
                        child:
                            Icon(Icons.delete, size: 30, color: Colors.black54),
                      ),
                    ),
                    direction: DismissDirection.endToStart,
                    confirmDismiss: (direction) {
                      return showDialog<bool>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          content: Container(
                            width: 50,
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 20),
                                  child:
                                      Text('Deseja excluir esse dispositivo ?'),
                                ),
                              ],
                            ),
                          ),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop(false);
                              },
                              child: const Text('Cancelar'),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop(true);
                              },
                              child: const Text('Sim'),
                            ),
                          ],
                        ),
                      );
                    },
                    onDismissed: (direction) {
                      chairStore.setChairId(listIdsChairs[index]);
                      chairStore.removeChair();
                    },
                    child: ListTile(
                      title: Text(listNameChairs[index]),
                      trailing: IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () => _showConfirmDialog(context,
                            listNameChairs[index], listIdsChairs[index]),
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        }
      }),
    );
  }

  void _showAlertDialog(BuildContext context, String msg) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        content: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Text(msg),
            ),
          ],
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showConfirmDialog(
      BuildContext context, String chairName, String listIdsChairs) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        content: Container(
          width: 50,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text('Deseja editar o nome \n de seu dispositivo ?'),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              Chair chair = Chair();
              chair.chairId = listIdsChairs;
              chair.chairNickname = chairName;
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => ChairNamePage(
                            chair: chair,
                          )));
            },
            child: const Text('Sim'),
          ),
        ],
      ),
    );
  }
}

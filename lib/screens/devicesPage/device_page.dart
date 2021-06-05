import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:smart_chair_frontend/models/chair.dart';
import 'package:smart_chair_frontend/screens/codeScanPage/code_scan_page.dart';
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

    autorun((_) {
      if (userManagerStore.user.chairs.isEmpty) {
        chairStore.getChair(userManagerStore.user.email);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meus dispositivos'),
        centerTitle: true,
        backgroundColor: customColor,
        actions: [
          Padding(
            padding: EdgeInsets.all(10.0),
            child: IconButton(
              icon: Icon(Icons.add),
              onPressed: () async {
                // vai para a tela do QR
                // Chair chair = new Chair();
                // chair.chairId = "chair9013";
                // chair.chairNickname = 'Cadeira test4 ';
                // chair.userId = userManagerStore.user.email;
                //
                // chairStore.addChair(chair);

                Navigator.pushReplacement(context,
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
          return Center(child: Container(child: Text("Sem dispositivos")));
        } else {
          return ListView.separated(
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(),
            itemCount: userManagerStore.user.chairs.length,
            itemBuilder: (context, index) {
              var listNameChairs = userManagerStore.user.chairs.values.toList();
              return ListTile(title: Text(listNameChairs[index]));
            },
          );
        }
      }),
    );
  }

  void showAlertDialog(BuildContext context) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        content: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: TextFormField(
                  decoration: InputDecoration(labelText: 'Nome'),
                  onChanged: chairStore.setChairNickname),
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
}

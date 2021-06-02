import 'package:flutter/material.dart';
import 'package:smart_chair_frontend/http/chair_controller.dart';
import 'package:smart_chair_frontend/models/chair.dart';
import 'package:smart_chair_frontend/utils/const.dart';

class DevicePage extends StatefulWidget {
  DevicePage({Key key}) : super(key: key);

  @override
  _DevicePageState createState() => _DevicePageState();
}

class _DevicePageState extends State<DevicePage> {
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
                //SharedPreferences prefs = await SharedPreferences.getInstance();
                Chair chair = new Chair();
                chair.chairId = "chair05";
                chair.chairNickname = 'Cadeira n ';

                var msg = await addChair(chair);
                print(msg);
                // Navigator.push(context,
                //   MaterialPageRoute(builder: (context) => ScanScreen()));
              },
            ),
          ),
        ],
      ),
      body: FutureBuilder(
          future: getChair(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
              case ConnectionState.none:
                return Center(
                  child: CircularProgressIndicator(),
                );

              default:
                if (!snapshot.hasError && snapshot.data.length >= 1) {
                  return ListView.separated(
                    separatorBuilder: (BuildContext context, int index) =>
                        const Divider(),
                    itemCount:
                        snapshot.data.length == 0 ? 1 : snapshot.data.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(snapshot.data[index]['chairNickname']),
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Container(
                      child: Text(snapshot.error),
                    ),
                  );
                } else {
                  return Center(
                    child:
                        Container(child: Text('Nenhum dispositivo cadastrado')),
                  );
                }
            }

            // return ListView.builder(
            //   itemCount: 1,
            //   itemBuilder: (BuildContext context, int index) {
            //     return ListTile(
            //       title: Text('${devices[index]}'),
            //     );
            //   },
            // );
          }),
    );
  }
}

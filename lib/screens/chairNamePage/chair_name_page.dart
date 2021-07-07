import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:smart_chair_frontend/bottomButtonWidget/bottom_button.dart';
import 'package:smart_chair_frontend/models/chair.dart';
import 'package:smart_chair_frontend/screens/devicesPage/device_page.dart';
import 'package:smart_chair_frontend/stores/chair_store.dart';
import 'package:smart_chair_frontend/utils/const.dart';

class ChairNamePage extends StatefulWidget {
  ChairNamePage({this.chair});

  final Chair? chair;

  @override
  _ChairNamePageState createState() => _ChairNamePageState(chair!);
}

class _ChairNamePageState extends State<ChairNamePage> {
  _ChairNamePageState(Chair chair)
      : edit = chair.chairNickname != null,
        chairStore = ChairStore(chair: chair);

  final ChairStore chairStore;

  bool edit;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    when((_) => (!chairStore.loading && chairStore.btnClicked), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => DevicePage()));

      chairStore.btnClicked = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: customColor,
      ),
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Text(
                  edit
                      ? 'Editar nome do seu dispositivo'
                      : 'Defina um nome para seu dispositivo',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              SizedBox(
                height: 80,
              ),
              Observer(
                builder: (_) => Container(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: TextFormField(
                    initialValue: edit ? chairStore.chairNickname : null,
                    onChanged: chairStore.setChairNickname,
                    decoration: InputDecoration(
                        labelText: 'Nome do dispositivo',
                        errorText: chairStore.nameError),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Observer(
                builder: (_) => Container(
                  padding: EdgeInsets.symmetric(horizontal: 60),
                  child: BottomButton(
                      chairStore.loading,
                      primaryColor,
                      customColor,
                      "Salvar",
                      chairStore.deviceNamePressed as void Function()?),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

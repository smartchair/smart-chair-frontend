import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:smart_chair_frontend/bottomButtonWidget/bottom_button.dart';
import 'package:smart_chair_frontend/screens/devicesPage/device_page.dart';
import 'package:smart_chair_frontend/stores/chair_store.dart';
import 'package:smart_chair_frontend/utils/const.dart';

class ChairNamePage extends StatefulWidget {
  ChairNamePage({Key key}) : super(key: key);

  @override
  _ChairNamePageState createState() => _ChairNamePageState();
}

class _ChairNamePageState extends State<ChairNamePage> {
  final ChairStore chairStore = GetIt.I<ChairStore>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    when((_) => (!chairStore.loading && chairStore.btnClicked), () {
      Navigator.push(context, MaterialPageRoute(builder: (_) => DevicePage()));
      chairStore.btnClicked = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Text(
                  'Salvar dispositivo',
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
                  child: BottomButton(chairStore.loading, primaryColor,
                      customColor, "Salvar", chairStore.deviceNamePressed),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

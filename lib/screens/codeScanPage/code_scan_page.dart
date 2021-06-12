import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:smart_chair_frontend/bottomButtonWidget/bottom_button.dart';
import 'package:smart_chair_frontend/models/chair.dart';
import 'package:smart_chair_frontend/screens/chairNamePage/chair_name_page.dart';
import 'package:smart_chair_frontend/screens/devicesPage/device_page.dart';
import 'package:smart_chair_frontend/stores/chair_store.dart';
import 'package:smart_chair_frontend/stores/user_manager_store.dart';
import 'package:smart_chair_frontend/utils/const.dart';
import 'package:smart_chair_frontend/utils/util_screen.dart';
import 'dart:async';

class ScanScreen extends StatefulWidget {
  @override
  _ScanState createState() => new _ScanState();
}

class _ScanState extends State<ScanScreen> with ScreenUtil {
  final UserManagerStore userManagerStore = GetIt.I<UserManagerStore>();
  final ChairStore chairStore = ChairStore();
  final ChairStore chairStoreGlobal = GetIt.I<ChairStore>();
  String _scanBarcode = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    when((_) => chairStore.chairId != '', () {
      if (userManagerStore.user.chairs.containsKey(chairStore.chairId)) {
        chairStoreGlobal.setError("Cadeira já cadastrada");
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => DevicePage()));
        //chairStore.chairId = null;
      } else {
        //chairStore.setError(null);
        Chair chair = Chair();
        chair.chairId = chairStore.chairId;
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => ChairNamePage(
                      chair: chair,
                    )));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: customColor,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.center,
              child: Container(
                color: primaryColor,
                width: screenWidth(context) * 0.8,
                height: screenHeight(context) * 0.6,
                child: Card(
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ListTile(
                            leading: Icon(Icons.help_outline_outlined),
                            title: Text(
                              "Nessa etapa, iremos sincronizar a sua cadeira com a sua conta",
                              textAlign: TextAlign.start,
                            )),
                        SizedBox(
                          height: 20,
                        ),
                        ListTile(
                            leading: Icon(Icons.thumb_up_alt_outlined),
                            title: Text(
                              "Para isso, vamos solicitar a permissão de camêra no seu dispositivo para escanearmos o QR code",
                              textAlign: TextAlign.start,
                            )),
                        SizedBox(
                          height: 20,
                        ),
                        ListTile(
                            leading: Icon(Icons.preview_outlined),
                            title: Text(
                              "O QR se encontra na etiqueta da sua cadeira, basta escanea-lo para associar",
                              textAlign: TextAlign.start,
                            )),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          _scanBarcode,
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        BottomButton(false, primaryColor, customColor,
                            "Adicionar dispositivo", () {
                          scanQR(context);

                          // userManagerStore.user.chairs = jsonDecode(_scanBarcode);
                          // addChairs( userManagerStore.user.chairs);
                        })
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ));
  }

  Future<void> scanQR(BuildContext context) async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
      print(barcodeScanRes);

      chairStore.chairId = jsonDecode(barcodeScanRes)['chairId'];
      print('chair store chairId ${chairStore.chairId}');

      // Navigator.push(
      //     context, MaterialPageRoute(builder: (_) => ChairNamePage()));

      //_showAlertDialog(context);
      //chairStore.addChair(jsonDecode(barcodeScanRes));
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }
}

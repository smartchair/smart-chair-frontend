import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:smart_chair_frontend/bottomButtonWidget/bottom_button.dart';
import 'package:smart_chair_frontend/http/chair_controller.dart';
import 'package:smart_chair_frontend/models/chair.dart';
import 'package:smart_chair_frontend/utils/const.dart';
import 'package:smart_chair_frontend/utils/util_button.dart';
import 'package:smart_chair_frontend/utils/util_screen.dart';
import 'dart:async';

class ScanScreen extends StatefulWidget {
  // final String name;
  // final String email;
  // final String pass;
  //
  // ScanScreen({
  //   Key key,
  //   this.name,
  //   this.email,
  //   this.pass,
  // }) : super(key: key);

  @override
  _ScanState createState() =>
      new _ScanState(/*this.name, this.email, this.pass*/);
}

class _ScanState extends State<ScanScreen> with ScreenUtil, RoundedButtonUtil {
  String _scanBarcode = "unknown";
  //final String name;
  //final String email;
  //final String pass;

  //_ScanState(this.name, this.email, this.pass);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Adicionar dispositivo'),
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
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
                        // BottomButton(primaryColor, customColor, "Abrir camera",
                        //     () {
                        //   scanQR();
                        // })
                        BottomButton(false, primaryColor, customColor,
                            "Adicionar cadeira", () {
                          Chair chair = new Chair();
                          // chair.chairId = "1";
                          // chair.userId = "1"
                          scanQR();
                          chair = jsonDecode(_scanBarcode);
                          addChairs(chair);
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

  Future<void> scanQR() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }
}

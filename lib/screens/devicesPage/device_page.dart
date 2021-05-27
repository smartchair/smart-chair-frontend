import 'package:flutter/material.dart';
import 'package:smart_chair_frontend/utils/const.dart';

class DevicePage extends StatelessWidget {
  DevicePage({Key key}) : super(key: key);

  final List<String> devices = [
    'Cadeira Zika',
    'Cadeira Osvaldo',
    'Cadeira do Luquinha ',
    'Cadeira Rafa Gamer'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meus dispositivos'),
        centerTitle: true,
        backgroundColor: customColor,
      ),
      body: ListView.separated(
        separatorBuilder: (BuildContext context, int index) => const Divider(),
        itemCount: 4,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text('${devices[index]}'),
          );
        },
      ),
    );
  }
}

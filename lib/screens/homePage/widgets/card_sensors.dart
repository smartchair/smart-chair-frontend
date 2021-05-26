import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CardSensor extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: 150,
        width: 500,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          color: Colors.grey.shade300,
          child: InkWell(
            onTap: () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text("Termperatura: 90.0 Celsius"),
                    Text("Luminosidade: 100 lumens"),
                  ],
                ),
                Text("Tempo sentado: 1 hora"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

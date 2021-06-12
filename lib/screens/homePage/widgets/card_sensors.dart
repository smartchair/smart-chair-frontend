import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:shimmer/shimmer.dart';

class CardSensor extends StatelessWidget {
  final double temp;
  final double lum;

  CardSensor(this.temp, this.lum);

  @override
  Widget build(BuildContext context) {
    return Container(
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
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: 200,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "Temperatura:",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                    ),
                    (temp == null)
                        ? Align(
                            alignment: Alignment.center,
                            child: SizedBox(
                              height: 30,
                              width: 130,
                              child: Shimmer.fromColors(
                                baseColor: Colors.grey[200],
                                highlightColor: Colors.white70,
                                enabled: true,
                                child: Container(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          )
                        : Align(
                            alignment: Alignment.center,
                            child: Text(
                              "${temp == null ? 0 : temp} °C",
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.w700),
                            ),
                          ),
                    Text(
                      "Luminosidade:",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                    ),
                    (lum == null)
                        ? Align(
                            alignment: Alignment.center,
                            child: SizedBox(
                              height: 30,
                              width: 130,
                              child: Shimmer.fromColors(
                                baseColor: Colors.grey[200],
                                highlightColor: Colors.white70,
                                enabled: true,
                                child: Container(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          )
                        : Align(
                            alignment: Alignment.center,
                            child: Text(
                              "${lum == null ? 0 : lum.round()} lumens",
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.w700),
                            ),
                          ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Tempo sentado:",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Text(
                    " 1 hora",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

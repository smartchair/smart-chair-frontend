import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smart_chair_frontend/stores/chair_store.dart';
import 'package:smart_chair_frontend/stores/current_chair_data_store.dart';
import 'package:smart_chair_frontend/stores/user_manager_store.dart';

class CardSensor extends StatefulWidget {
  final double temp;
  final double lum;

  CardSensor({this.temp, this.lum});

  @override
  _CardSensorState createState() => _CardSensorState();
}

class _CardSensorState extends State<CardSensor> {
  final UserManagerStore userManagerStore = GetIt.I<UserManagerStore>();
  final CurrentChairDataStore currentChairDataStore =
      GetIt.I<CurrentChairDataStore>();
  final ChairStore chairStore = GetIt.I<ChairStore>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    reaction((_) => chairStore.selectedChair, (newChair) {
      currentChairDataStore.getCurrentTemp(newChair);
      currentChairDataStore.getCurrentLum(newChair);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.only(left: 20),
          child: Observer(
            builder: (_) => chairStore.loading
                ? SizedBox(
                    height: 30,
                    width: 85,
                    child: Shimmer.fromColors(
                      baseColor: Colors.grey[350],
                      highlightColor: Colors.white10,
                      enabled: true,
                      child: Container(
                        color: Colors.white,
                      ),
                    ),
                  )
                : Container(
                    child: DropdownButton<String>(
                      value: chairStore.selectedChair == ''
                          ? 'Selecione'
                          : chairStore.selectedChair,
                      onChanged: chairStore.setChangedChair,
                      items: userManagerStore.user.chairs.keys
                          .map<DropdownMenuItem<String>>((String key) {
                        return DropdownMenuItem<String>(
                          value: key,
                          child: Text(userManagerStore.user.chairs.values
                              .firstWhere((element) =>
                                  userManagerStore.user.chairs[key] ==
                                  element)),
                        );
                      }).toList(),
                    ),
                  ),
          ),
        ),
        Container(
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
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w500),
                        ),
                        Observer(builder: (_) {
                          if (currentChairDataStore.temp == null ||
                              currentChairDataStore.loading) {
                            return Align(
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
                            );
                          } else {
                            return Align(
                              alignment: Alignment.center,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 43),
                                child: Text(
                                  "${currentChairDataStore.temp == null ? 0 : currentChairDataStore.temp} °C",
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            );
                          }
                        }),
                        Text(
                          "Luminosidade:",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w500),
                        ),
                        Observer(builder: (_) {
                          if (currentChairDataStore.lum == null ||
                              currentChairDataStore.loading) {
                            return Align(
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
                            );
                          } else {
                            return Align(
                              alignment: Alignment.center,
                              child: Text(
                                "${currentChairDataStore.lum == null ? 0 : currentChairDataStore.lum.round()} lumens",
                                style: TextStyle(
                                    fontSize: 22, fontWeight: FontWeight.w700),
                              ),
                            );
                          }
                        }),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Tempo sentado:",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Text(
                        " 1 hora",
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.w700),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

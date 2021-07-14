import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smart_chair_frontend/stores/chair_store.dart';
import 'package:smart_chair_frontend/stores/current_chair_data_store.dart';
import 'package:smart_chair_frontend/utils/const.dart';

class SensorSummaryPage extends StatefulWidget {
  @override
  _SensorSummaryPageState createState() => _SensorSummaryPageState();
}

class _SensorSummaryPageState extends State<SensorSummaryPage> {
  final CurrentChairDataStore currentChairDataStore =
      GetIt.I<CurrentChairDataStore>();

  final ChairStore chairStore = GetIt.I<ChairStore>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.delayed(Duration(milliseconds: 100), () {
      currentChairDataStore
          .getAllAverageDataCurrentChair(chairStore.selectedChair);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: customColor,
      ),
      body: Container(
        alignment: Alignment.center,
        child: RefreshIndicator(
          onRefresh: () => currentChairDataStore
              .getAllAverageDataCurrentChair(chairStore.selectedChair),
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Text(
                        "Média Temperatura: ",
                        style: TextStyle(fontSize: 20),
                      ),
                      Observer(builder: (_) {
                        if (currentChairDataStore.loading) {
                          return shimmerWidget();
                        } else {
                          return dataSensors(
                              currentChairDataStore.averageTemp, "°C");
                        }
                      }),
                    ],
                  ),
                ),
                SizedBox(height: 100),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Text("Média Luminosidade: ",
                          style: TextStyle(fontSize: 20)),
                      Observer(builder: (_) {
                        if (currentChairDataStore.loading) {
                          return shimmerWidget();
                        } else {
                          return dataSensors(
                              currentChairDataStore.averageLum, "LM");
                        }
                      }),
                    ],
                  ),
                ),
                SizedBox(height: 100),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Text("Média Humidade: ", style: TextStyle(fontSize: 20)),
                      Observer(builder: (_) {
                        if (currentChairDataStore.loading) {
                          return shimmerWidget();
                        } else {
                          return dataSensors(
                              currentChairDataStore.averageHum, "%");
                        }
                      }),
                    ],
                  ),
                ),
                SizedBox(height: 100),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Text("Média Ruído: ", style: TextStyle(fontSize: 20)),
                      Observer(builder: (_) {
                        if (currentChairDataStore.loading) {
                          return shimmerWidget();
                        } else {
                          return dataSensors(
                              currentChairDataStore.averageNoise, "dBs");
                        }
                      }),
                    ],
                  ),
                ),
                SizedBox(height: 100),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget dataSensors(double data, String unit) {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.only(right: 43),
        child: Text(
          "${data.toStringAsFixed(0)} $unit",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }

  Widget shimmerWidget() {
    return SizedBox(
      height: 30,
      width: 130,
      child: Shimmer.fromColors(
        baseColor: Colors.grey[200]!,
        highlightColor: Colors.white70,
        enabled: true,
        child: Container(
          color: Colors.white,
        ),
      ),
    );
  }
}

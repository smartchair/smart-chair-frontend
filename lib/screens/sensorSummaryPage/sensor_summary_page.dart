import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smart_chair_frontend/stores/chair_store.dart';
import 'package:smart_chair_frontend/stores/current_chair_data_store.dart';
import 'package:smart_chair_frontend/stores/graph_data_store.dart';
import 'package:smart_chair_frontend/utils/const.dart';

import 'graphsWidgets/barGraphHum.dart';
import 'graphsWidgets/barGraphLum.dart';
import 'graphsWidgets/barGraphTemp.dart';

class SensorSummaryPage extends StatefulWidget {
  @override
  _SensorSummaryPageState createState() => _SensorSummaryPageState();
}

class _SensorSummaryPageState extends State<SensorSummaryPage> {
  final CurrentChairDataStore currentChairDataStore =
      GetIt.I<CurrentChairDataStore>();
  final ChairStore chairStore = GetIt.I<ChairStore>();

  final GraphStore graphStore = GetIt.I<GraphStore>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.delayed(Duration(milliseconds: 100), () {
      // currentChairDataStore
      //     .getAllAverageDataCurrentChair(chairStore.selectedChair);
      graphStore.getAverageSensors();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: customColor,
      ),
      body: Container(
        child: RefreshIndicator(
          onRefresh: () => graphStore.getAverageSensors(),
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    padding: EdgeInsets.all(12),
                    child: Text(
                      'Resumo 5 dias',
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 25),
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    padding: EdgeInsets.all(12),
                    child: Text(
                      'TEMPERATURA (ºC)',
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(5),
                  child: BarGraphTemp(graphStore),
                ),
                SizedBox(
                  height: 25,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    padding: EdgeInsets.all(12),
                    child: Text(
                      'LUMINOSIDADE (LUX)',
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(5),
                  child: BarGraphLum(graphStore),
                ),
                SizedBox(
                  height: 25,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    padding: EdgeInsets.all(12),
                    child: Text(
                      'HUMIDADE (%)',
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(5),
                  child: BarGraphHum(graphStore),
                ),
                SizedBox(
                  height: 25,
                ),
                // GestureDetector(
                //   onTap: () => Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //           builder: (_) => SummaryTempPage(graphStore))),
                //   child: Hero(
                //     tag: 'temp',
                //     child: Padding(
                //       padding: const EdgeInsets.all(8.0),
                //       child: BarGraph(
                //           graphStore, 'Temperatura (ºC)', 'averageTemp', 50),
                //     ),
                //   ),
                // ),
                // GestureDetector(
                //   onTap: () => Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //           builder: (_) => SummaryLumPage(graphStore))),
                //   child: Hero(
                //     tag: 'lum',
                //     child: Padding(
                //       padding: const EdgeInsets.all(8.0),
                //       child: BarGraph(
                //           graphStore, 'Luminosidade (Lux)', 'averageLum', 320),
                //     ),
                //   ),
                // ),
                // GestureDetector(
                //   onTap: () => Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //           builder: (_) => SummaryUmiPage(graphStore))),
                //   child: Hero(
                //     tag: 'umi',
                //     child: Padding(
                //       padding: const EdgeInsets.all(8.0),
                //       child: BarGraph(
                //           graphStore, 'Umidade (%)', 'averageHum', 100),
                //     ),
                //   ),
                // ),
                // GestureDetector(
                //   onTap: () => Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //           builder: (_) => SummarySoundPage(graphStore))),
                //   child: Hero(
                //     tag: 'sound',
                //     child: Padding(
                //       padding: const EdgeInsets.all(8.0),
                //       child: BarGraph(
                //           graphStore, 'Ruído (dBs)', 'averageNoise', 50),
                //     ),
                //   ),
                // ),

                // Container(
                //   padding: EdgeInsets.symmetric(horizontal: 20),
                //   child: Row(
                //     children: [
                //       Text(
                //         "Média Temperatura: ",
                //         style: TextStyle(fontSize: 20),
                //       ),
                //       Observer(builder: (_) {
                //         if (currentChairDataStore.loading) {
                //           return shimmerWidget();
                //         } else {
                //           return dataSensors(
                //               currentChairDataStore.averageTemp, "°C");
                //         }
                //       }),
                //     ],
                //   ),
                // ),
                // SizedBox(height: 100),
                // Container(
                //   padding: EdgeInsets.symmetric(horizontal: 20),
                //   child: Row(
                //     children: [
                //       Text("Média Luminosidade: ",
                //           style: TextStyle(fontSize: 20)),
                //       Observer(builder: (_) {
                //         if (currentChairDataStore.loading) {
                //           return shimmerWidget();
                //         } else {
                //           return dataSensors(
                //               currentChairDataStore.averageLum, "Lux");
                //         }
                //       }),
                //     ],
                //   ),
                // ),
                // SizedBox(height: 100),
                // Container(
                //   padding: EdgeInsets.symmetric(horizontal: 20),
                //   child: Row(
                //     children: [
                //       Text("Média Humidade: ", style: TextStyle(fontSize: 20)),
                //       Observer(builder: (_) {
                //         if (currentChairDataStore.loading) {
                //           return shimmerWidget();
                //         } else {
                //           return dataSensors(
                //               currentChairDataStore.averageHum, "%");
                //         }
                //       }),
                //     ],
                //   ),
                // ),
                // SizedBox(height: 100),
                // Container(
                //   padding: EdgeInsets.symmetric(horizontal: 20),
                //   child: Row(
                //     children: [
                //       Text("Média Ruído: ", style: TextStyle(fontSize: 20)),
                //       Observer(builder: (_) {
                //         if (currentChairDataStore.loading) {
                //           return shimmerWidget();
                //         } else {
                //           return dataSensors(
                //               currentChairDataStore.averageNoise, "dBs");
                //         }
                //       }),
                //     ],
                //   ),
                // ),
                // SizedBox(height: 100),
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
        baseColor: Colors.grey.withOpacity(0.4),
        highlightColor: Colors.grey.shade400,
        enabled: true,
        child: Container(
          color: Colors.white,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:smart_chair_frontend/barGraphWidget/barGraphWidget.dart';
import 'package:smart_chair_frontend/stores/graph_data_store.dart';

class BarChartTemp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => BarChartTempState();
}

class BarChartTempState extends State<BarChartTemp> {
  final GraphStore graphStore = GetIt.I<GraphStore>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    when((_) => graphStore.listAverage.isEmpty, () {
      graphStore.getAverageSensors();
    });
    // final dispose = autorun((_) => graphStore.getAverageSensors());
    //
    // dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: RefreshIndicator(
      onRefresh: () => graphStore.getAverageSensors(),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                padding: EdgeInsets.all(12),
                child: Text(
                  'Resumo 5 dias',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 25),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child:
                  BarGraph(graphStore, 'Temperatura (ºC)', 'averageTemp', 50),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child:
                  BarGraph(graphStore, 'Luminosidade (Lux)', 'averageLum', 320),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: BarGraph(graphStore, 'Umidade (%)', 'averageHum', 100),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: BarGraph(graphStore, 'Ruído (dBs)', 'averageNoise', 50),
            )
          ],
        ),
      ),
    ));
  }
}

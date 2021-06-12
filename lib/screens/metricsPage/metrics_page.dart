import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:smart_chair_frontend/barGraphTempWidget/bar_graph_temp_widget.dart';
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

    autorun((_) => graphStore.getCurrentTemp());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Observer(builder: (_) => BarGraphTemp(graphStore.temp)),
      ],
    );
  }
}

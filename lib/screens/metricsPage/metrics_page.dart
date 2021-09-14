import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:mobx/mobx.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smart_chair_frontend/stores/chair_store.dart';
import 'package:smart_chair_frontend/stores/graph_data_store.dart';
import 'package:smart_chair_frontend/stores/user_manager_store.dart';
import 'package:smart_chair_frontend/utils/const.dart';

import 'graphsWidget/line_chart_hum.dart';
import 'graphsWidget/line_chart_lum.dart';
import 'graphsWidget/line_chart_temp.dart';

class BarChartTemp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => BarChartTempState();
}

class BarChartTempState extends State<BarChartTemp> {
  final GraphStore graphStore = GetIt.I<GraphStore>();
  final ChairStore? chairStore = GetIt.I<ChairStore>();
  final UserManagerStore? userManagerStore = GetIt.I<UserManagerStore>();

  late ReactionDisposer disposeReaction;
  late ReactionDisposer disposeReaction2;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // Future.delayed(Duration(milliseconds: 100), () {
    //   graphStore.getDataCurrentDayTemp();
    //   graphStore.getDataCurrentDayLum();
    //   graphStore.getDataCurrentDayHum();
    // });

    when((_) => graphStore.listAverage.isEmpty, () {
      print('when reload');
      // graphStore.getAverageSensors();
      graphStore.getDataCurrentDayTemp();
      graphStore.getDataCurrentDayLum();
      graphStore.getDataCurrentDayHum();
    });

    disposeReaction =
        reaction((_) => chairStore!.selectedChair, (dynamic newChair) async {
      print('value chairSelected metrics_page ${chairStore!.selectedChair}');
      graphStore.clearMaps();
      await graphStore.getDataCurrentDayTemp();
      await graphStore.getDataCurrentDayLum();
      await graphStore.getDataCurrentDayHum();
    });

    disposeReaction2 = reaction((_) => graphStore.dateReferenceGraphs,
        (dynamic newDate) async {
      graphStore.clearMaps();
      await graphStore.getDataCurrentDayTemp();
      await graphStore.getDataCurrentDayLum();
      await graphStore.getDataCurrentDayHum();
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    disposeReaction();
    disposeReaction2();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () => _refreshData(),
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              Observer(
                builder: (_) => Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    padding: EdgeInsets.all(12),
                    child: Text(
                      '${DateFormat("d 'de' MMMM 'de' y", "pt_BR").format(DateTime.parse(graphStore.dateReferenceGraphs))}',
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 25),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: TextButton(
                  onPressed: () => _selectDate(context),
                  child: Text(
                    'Selecione uma data',
                    style: TextStyle(color: customColor),
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Row(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      padding: EdgeInsets.all(12),
                      child: Text(
                        'Cadeira atual',
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 20),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Observer(
                      builder: (_) {
                        if (chairStore!.loading) {
                          return SizedBox(
                            height: 30,
                            width: 85,
                            child: Shimmer.fromColors(
                              baseColor: Colors.grey.withOpacity(0.4),
                              highlightColor: Colors.grey.shade400,
                              enabled: true,
                              child: Container(
                                color: Colors.white,
                              ),
                            ),
                          );
                        } else if (chairStore!.selectedChair != '' &&
                            userManagerStore!.isLoggedIn) {
                          return Container(
                            child: DropdownButton<String>(
                              value: chairStore!.selectedChair,
                              onChanged: chairStore!.setChangedChair,
                              items: userManagerStore!.user!.chairs!.keys
                                  .map<DropdownMenuItem<String>>((String key) {
                                return DropdownMenuItem<String>(
                                  value: key,
                                  child: Text(
                                    userManagerStore!.user!.chairs!.values
                                        .firstWhere((element) =>
                                            userManagerStore!
                                                .user!.chairs![key] ==
                                            element),
                                  ),
                                );
                              }).toList(),
                            ),
                          );
                        } else {
                          return Container();
                        }
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  padding: EdgeInsets.all(12),
                  child: Text(
                    'TEMPERATURA (ºC)',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: LineChartTemp(graphStore),
              ),
              SizedBox(
                height: 35,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  padding: EdgeInsets.all(12),
                  child: Text(
                    'LUMINOSIDADE (LUX)',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: LineChartLum(graphStore),
              ),
              SizedBox(
                height: 35,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  padding: EdgeInsets.all(12),
                  child: Text(
                    'HUMIDADE (%)',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
                  ),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: LineChartHum(graphStore)),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _refreshData() async {
    await graphStore.getDataCurrentDayTemp();
    await graphStore.getDataCurrentDayLum();
    await graphStore.getDataCurrentDayHum();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.parse(graphStore.dateReferenceGraphs),
        firstDate: DateTime(2000),
        lastDate: DateTime(2025),
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme:
                  Theme.of(context).colorScheme.copyWith(primary: customColor),
            ), // This will change to light theme.
            child: child!,
          );
        });

    if (picked != null && picked != DateTime.now()) {
      graphStore.setReferenceDateGraphs(picked.toString());
    }
  }
}

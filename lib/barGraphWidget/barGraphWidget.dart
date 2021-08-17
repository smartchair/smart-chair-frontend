import 'dart:async';
import 'package:flutter/gestures.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import 'package:mobx/mobx.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smart_chair_frontend/stores/graph_data_store.dart';

class BarGraph extends StatefulWidget {
  GraphStore graphStore;
  String title;
  String sensor;
  double escala;

  BarGraph(this.graphStore, this.title, this.sensor, this.escala);

  final List<Color> availableColors = [
    Colors.purpleAccent,
    Colors.yellow,
    Colors.lightBlue,
    Colors.orange,
    Colors.pink,
    Colors.redAccent,
  ];

  @override
  State<StatefulWidget> createState() => BarGraphState();
}

class BarGraphState extends State<BarGraph> {
  final Color barBackgroundColor = const Color(0xff72d8bf);
  final Duration animDuration = const Duration(milliseconds: 250);

  int touchedIndex = -1;

  bool isPlaying = false;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => widget.graphStore.listAverage.isEmpty ||
              widget.graphStore.loading
          ? AspectRatio(
              aspectRatio: 1.5,
              child: Shimmer.fromColors(
                baseColor: Colors.grey[350]!,
                highlightColor: Colors.white10,
                enabled: true,
                child: Container(
                  color: Colors.white,
                ),
              ),
            )
          : AspectRatio(
              aspectRatio: 1.5,
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18)),
                color: const Color(0xff81e5cd),
                child: Stack(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Text(
                            widget.title,
                            style: TextStyle(
                                color: const Color(0xff0f4a3c),
                                fontSize: 24,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Text(
                            '',
                            style: TextStyle(
                                color: const Color(0xff379982),
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 17,
                          ),
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: BarChart(
                                mainBarData(),
                                swapAnimationDuration: animDuration,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  BarChartGroupData makeGroupData(
    int x,
    double y, {
    bool isTouched = false,
    Color barColor = Colors.white,
    double width = 15,
    List<int> showTooltips = const [],
  }) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          y: isTouched ? y + 1 : y,
          colors: isTouched ? [Colors.yellow] : [barColor],
          width: width,
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            y: widget.escala,
            colors: [barBackgroundColor],
          ),
        ),
      ],
      showingTooltipIndicators: showTooltips,
    );
  }

  List<BarChartGroupData> showingGroups() => List.generate(5, (i) {
        switch (i) {
          case 0:
            return makeGroupData(
                0,
                double.parse(widget.graphStore.listAverage[0][widget.sensor]
                    .toStringAsFixed(2)),
                isTouched: i == touchedIndex);
          case 1:
            return makeGroupData(
                1,
                double.parse(widget.graphStore.listAverage[1][widget.sensor]
                    .toStringAsFixed(2)),
                isTouched: i == touchedIndex);
          case 2:
            return makeGroupData(
                2,
                double.parse(widget.graphStore.listAverage[2][widget.sensor]
                    .toStringAsFixed(2)),
                isTouched: i == touchedIndex);
          case 3:
            return makeGroupData(
                3,
                double.parse(widget.graphStore.listAverage[3][widget.sensor]
                    .toStringAsFixed(2)),
                isTouched: i == touchedIndex);
          case 4:
            return makeGroupData(
                4,
                double.parse(widget.graphStore.listAverage[4][widget.sensor]
                    .toStringAsFixed(2)),
                isTouched: i == touchedIndex);

          default:
            return throw Error();
        }
      });

  BarChartData mainBarData() {
    return BarChartData(
      barTouchData: BarTouchData(
        touchTooltipData: BarTouchTooltipData(
            tooltipBgColor: Colors.blueGrey,
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              String weekDay;
              DateFormat format = DateFormat("dd-MM-yy");
              var formattedDate = format
                  .parse(widget.graphStore.listAverage[group.x.toInt()]['day']);

              switch (formattedDate.weekday - 1) {
                case 0:
                  weekDay = 'Segunda';
                  break;
                case 1:
                  weekDay = 'Terça';
                  break;
                case 2:
                  weekDay = 'Quarta';
                  break;
                case 3:
                  weekDay = 'Quinta';
                  break;
                case 4:
                  weekDay = 'Sexta';
                  break;
                case 5:
                  weekDay = 'Sábado';
                  break;
                case 6:
                  weekDay = 'Domingo';
                  break;
                default:
                  throw Error();
              }
              return BarTooltipItem(
                weekDay + '\n',
                TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: (rod.y - 1).toString(),
                    style: TextStyle(
                      color: Colors.yellow,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              );
            }),
        touchCallback: (barTouchResponse) {
          setState(() {
            if (barTouchResponse.spot != null &&
                barTouchResponse.touchInput is! PointerUpEvent &&
                barTouchResponse.touchInput is! PointerExitEvent) {
              touchedIndex = barTouchResponse.spot!.touchedBarGroupIndex;
            } else {
              touchedIndex = -1;
            }
          });
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value) => const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
          margin: 16,
          getTitles: (double value) {
            var weekday = 0;
            DateFormat format = DateFormat("dd-MM-yy");
            var formattedDate = format
                .parse(widget.graphStore.listAverage[value.toInt()]['day']);
            weekday = formattedDate.weekday;

            switch (weekday) {
              case 1:
                return 'Seg';
              case 2:
                return 'Ter';
              case 3:
                return 'Qua';
              case 4:
                return 'Qui';
              case 5:
                return 'Sex';
              case 6:
                return 'Sab';
              case 7:
                return 'Dom';
              default:
                return '';
            }
          },
        ),
        leftTitles: SideTitles(
          showTitles: false,
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: showingGroups(),
    );
  }

  Future<dynamic> refreshState() async {
    setState(() {});
    await Future<dynamic>.delayed(
        animDuration + const Duration(milliseconds: 50));
    if (isPlaying) {
      await refreshState();
    }
  }
}

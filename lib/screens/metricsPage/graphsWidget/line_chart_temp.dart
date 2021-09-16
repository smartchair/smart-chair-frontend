import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smart_chair_frontend/stores/graph_data_store.dart';

class LineChartTemp extends StatefulWidget {
  final GraphStore graphStore;

  LineChartTemp(this.graphStore);

  @override
  _LineChartTempState createState() => _LineChartTempState();
}

class _LineChartTempState extends State<LineChartTemp> {
  // final GraphStore graphStore = GetIt.I<GraphStore>();

  List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];

  bool showAvg = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Observer(
          builder: (_) => Align(
            alignment: Alignment.centerLeft,
            child: Container(
                padding: EdgeInsets.all(12),
                child:
                    DateTime.parse(widget.graphStore.dateReferenceGraphs).day ==
                            DateTime.now().day
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Temperatura média agora (${DateTime.now().hour.toString()}h)',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 20),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  '${widget.graphStore.mapTemps[DateTime.now().hour.toString()] ?? 0.0} ºC',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20),
                                ),
                              ),
                            ],
                          )
                        : Container()),
          ),
        ),
        Observer(builder: (_) {
          if (widget.graphStore.loading || widget.graphStore.loadingTemp) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: AspectRatio(
                aspectRatio: 1.7,
                child: Shimmer.fromColors(
                  baseColor: Colors.grey.withOpacity(0.4),
                  highlightColor: Colors.grey.shade400,
                  enabled: true,
                  child: Container(
                    color: Colors.white,
                  ),
                ),
              ),
            );
          } else if (widget.graphStore.mapTemps.isNotEmpty) {
            return Stack(
              children: <Widget>[
                AspectRatio(
                  aspectRatio: 1.70,
                  child: Container(
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(18),
                        ),
                        color: Color(0xff232d37)),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          right: 18.0, left: 12.0, top: 24, bottom: 12),
                      child: LineChart(
                        mainData(),
                      ),
                    ),
                  ),
                ),
                // SizedBox(
                //   width: 60,
                //   height: 34,
                //   child: TextButton(
                //     onPressed: () {
                //       setState(() {
                //         showAvg = !showAvg;
                //       });
                //     },
                //     child: Text(
                //       'avg',
                //       style: TextStyle(
                //           fontSize: 12,
                //           color: showAvg
                //               ? Colors.white.withOpacity(0.5)
                //               : Colors.white),
                //     ),
                //   ),
                // ),
              ],
            );
          } else {
            return Container(
              child: Text('Não há dados'),
            );
          }
        }),
      ],
    );
  }

  LineChartData mainData() {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: SideTitles(showTitles: false),
        topTitles: SideTitles(showTitles: false),
        bottomTitles: SideTitles(
          showTitles: true,
          interval: 1,
          getTextStyles: (value, context) => const TextStyle(
              color: Color(0xff68737d),
              fontWeight: FontWeight.bold,
              fontSize: 16),
          getTitles: (value) {
            switch (value.toInt()) {
              case 0:
                return '00';
              case 1:
                return '06';
              case 2:
                return '12';
              case 3:
                return '18';
            }
            return '';
          },
          reservedSize: 20,
          margin: 8,
        ),
        leftTitles: SideTitles(
          showTitles: true,
          interval: 10,
          getTextStyles: (value, context) => const TextStyle(
            color: Color(0xff67727d),
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 0:
                return '0';
              case 10:
                return '10';
              case 20:
                return '20';
              case 30:
                return '30';
            }
            return '';
          },
          reservedSize: 20,
          margin: 10,
        ),
      ),
      borderData: FlBorderData(
          show: true,
          border: Border.all(color: const Color(0xff37434d), width: 1)),
      minX: 0,
      maxX: 4,
      minY: 0,
      maxY: 40,
      lineBarsData: [
        LineChartBarData(
          spots: [
            FlSpot(0, widget.graphStore.mapTemps['00'] ?? 0.0), //24h
            FlSpot(0.17, widget.graphStore.mapTemps['01'] ?? 0.0), //1H
            FlSpot(0.34, widget.graphStore.mapTemps['02'] ?? 0.0), // 2H
            FlSpot(0.51, widget.graphStore.mapTemps['03'] ?? 0.0), //3H
            FlSpot(0.68, widget.graphStore.mapTemps['04'] ?? 0.0), //4H
            FlSpot(0.85, widget.graphStore.mapTemps['05'] ?? 0.0), //5H
            FlSpot(1.02, widget.graphStore.mapTemps['06'] ?? 0.0), //6H
            FlSpot(1.19, widget.graphStore.mapTemps['07'] ?? 0.0),
            FlSpot(1.36, widget.graphStore.mapTemps['08'] ?? 0.0),
            FlSpot(1.53, widget.graphStore.mapTemps['09'] ?? 0.0),
            FlSpot(1.70, widget.graphStore.mapTemps['10'] ?? 0.0),
            FlSpot(1.87, widget.graphStore.mapTemps['11'] ?? 0.0),
            FlSpot(2.04, widget.graphStore.mapTemps['12'] ?? 0.0),
            FlSpot(2.21, widget.graphStore.mapTemps['13'] ?? 0.0),
            FlSpot(2.38, widget.graphStore.mapTemps['14'] ?? 0.0),
            FlSpot(2.55, widget.graphStore.mapTemps['15'] ?? 0.0),
            FlSpot(2.72, widget.graphStore.mapTemps['16'] ?? 0.0),
            FlSpot(2.89, widget.graphStore.mapTemps['17'] ?? 0.0),
            FlSpot(3.06, widget.graphStore.mapTemps['18'] ?? 0.0),
            FlSpot(3.23, widget.graphStore.mapTemps['19'] ?? 0.0),
            FlSpot(3.4, widget.graphStore.mapTemps['20'] ?? 0.0),
            FlSpot(3.57, widget.graphStore.mapTemps['21'] ?? 0.0),
            FlSpot(3.74, widget.graphStore.mapTemps['22'] ?? 0.0),
            FlSpot(4, widget.graphStore.mapTemps['23'] ?? 0.0),
          ],
          isCurved: false,
          colors: gradientColors,
          barWidth: 2,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            colors:
                gradientColors.map((color) => color.withOpacity(0.3)).toList(),
          ),
        ),
      ],
    );
  }

  LineChartData avgData() {
    return LineChartData(
      lineTouchData: LineTouchData(enabled: false),
      gridData: FlGridData(
        show: true,
        drawHorizontalLine: true,
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          getTextStyles: (value, context) => const TextStyle(
              color: Color(0xff68737d),
              fontWeight: FontWeight.bold,
              fontSize: 16),
          getTitles: (value) {
            switch (value.toInt()) {
              case 2:
                return 'MAR';
              case 5:
                return 'JUN';
              case 8:
                return 'SEP';
            }
            return '';
          },
          margin: 8,
          interval: 1,
        ),
        leftTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value, context) => const TextStyle(
            color: Color(0xff67727d),
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 1:
                return '10k';
              case 3:
                return '30k';
              case 5:
                return '50k';
            }
            return '';
          },
          reservedSize: 32,
          interval: 1,
          margin: 12,
        ),
        topTitles: SideTitles(showTitles: false),
        rightTitles: SideTitles(showTitles: false),
      ),
      borderData: FlBorderData(
          show: true,
          border: Border.all(color: const Color(0xff37434d), width: 1)),
      minX: 0,
      maxX: 11,
      minY: 0,
      maxY: 6,
      lineBarsData: [
        LineChartBarData(
          spots: [
            FlSpot(0, 3.44),
            FlSpot(2.6, 3.44),
            FlSpot(4.9, 3.44),
            FlSpot(6.8, 3.44),
            FlSpot(8, 3.44),
            FlSpot(9.5, 3.44),
            FlSpot(11, 3.44),
          ],
          isCurved: true,
          colors: [
            ColorTween(begin: gradientColors[0], end: gradientColors[1])
                .lerp(0.2)!,
            ColorTween(begin: gradientColors[0], end: gradientColors[1])
                .lerp(0.2)!,
          ],
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(show: true, colors: [
            ColorTween(begin: gradientColors[0], end: gradientColors[1])
                .lerp(0.2)!
                .withOpacity(0.1),
            ColorTween(begin: gradientColors[0], end: gradientColors[1])
                .lerp(0.2)!
                .withOpacity(0.1),
          ]),
        ),
      ],
    );
  }
}

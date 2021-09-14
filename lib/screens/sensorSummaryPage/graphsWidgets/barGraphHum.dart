import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smart_chair_frontend/stores/graph_data_store.dart';

class BarGraphHum extends StatelessWidget {
  final GraphStore graphStore;

  BarGraphHum(this.graphStore);

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => graphStore.listAverage.isEmpty || graphStore.loading
          ? AspectRatio(
              aspectRatio: 1.7,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Shimmer.fromColors(
                  baseColor: Colors.grey.withOpacity(0.4),
                  highlightColor: Colors.grey.shade400,
                  enabled: true,
                  child: Container(
                    color: Colors.white,
                  ),
                ),
              ),
            )
          : AspectRatio(
              aspectRatio: 1.7,
              child: Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                color: const Color(0xff2c4260),
                child: BarChart(
                  BarChartData(
                    alignment: BarChartAlignment.spaceEvenly,
                    maxY: 120,
                    barTouchData: BarTouchData(
                      enabled: false,
                      touchTooltipData: BarTouchTooltipData(
                        tooltipBgColor: Colors.transparent,
                        tooltipPadding: const EdgeInsets.all(5),
                        tooltipMargin: 5,
                        getTooltipItem: (
                          BarChartGroupData group,
                          int groupIndex,
                          BarChartRodData rod,
                          int rodIndex,
                        ) {
                          return BarTooltipItem(
                            rod.y.toString(),
                            TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        },
                      ),
                    ),
                    titlesData: FlTitlesData(
                      show: true,
                      bottomTitles: SideTitles(
                        showTitles: true,
                        getTextStyles: (value, context) => const TextStyle(
                            color: Color(0xff7589a2),
                            fontWeight: FontWeight.bold,
                            fontSize: 14),
                        margin: 20,
                        getTitles: (double value) {
                          var weekday = 0;
                          DateFormat format = DateFormat("dd-MM-yy");
                          var formattedDate = format.parse(
                              graphStore.listAverage[value.toInt()]['day']);
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
                      leftTitles: SideTitles(showTitles: false),
                    ),
                    borderData: FlBorderData(
                      show: false,
                    ),
                    barGroups: [
                      BarChartGroupData(
                        x: 4,
                        barsSpace: 35.0,
                        barRods: [
                          BarChartRodData(
                            y: double.parse(graphStore.listAverage.reversed
                                .toList()[0]["averageHum"]
                                .toStringAsFixed(2)),
                            colors: [
                              Colors.lightBlueAccent,
                              Colors.greenAccent
                            ],
                          )
                        ],
                        showingTooltipIndicators: [0],
                      ),
                      BarChartGroupData(
                        x: 3,
                        barsSpace: 35.0,
                        barRods: [
                          BarChartRodData(
                            y: double.parse(graphStore.listAverage.reversed
                                .toList()[1]["averageHum"]
                                .toStringAsFixed(2)),
                            colors: [
                              Colors.lightBlueAccent,
                              Colors.greenAccent
                            ],
                          ),
                        ],
                        showingTooltipIndicators: [0],
                      ),
                      BarChartGroupData(
                        x: 2,
                        barsSpace: 35.0,
                        barRods: [
                          BarChartRodData(
                              y: double.parse(graphStore.listAverage.reversed
                                  .toList()[2]["averageHum"]
                                  .toStringAsFixed(2)),
                              colors: [
                                Colors.lightBlueAccent,
                                Colors.greenAccent
                              ])
                        ],
                        showingTooltipIndicators: [0],
                      ),
                      BarChartGroupData(
                        x: 1,
                        barsSpace: 35.0,
                        barRods: [
                          BarChartRodData(
                              y: double.parse(graphStore.listAverage.reversed
                                  .toList()[3]["averageHum"]
                                  .toStringAsFixed(2)),
                              colors: [
                                Colors.lightBlueAccent,
                                Colors.greenAccent
                              ])
                        ],
                        showingTooltipIndicators: [0],
                      ),
                      BarChartGroupData(
                        x: 0,
                        barsSpace: 35.0,
                        barRods: [
                          BarChartRodData(
                              y: double.parse(graphStore.listAverage.reversed
                                  .toList()[4]["averageHum"]
                                  .toStringAsFixed(2)),
                              colors: [
                                Colors.lightBlueAccent,
                                Colors.greenAccent
                              ])
                        ],
                        showingTooltipIndicators: [0],
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

class BarGraphTemp extends StatelessWidget {
  List? listAverage;

  BarGraphTemp(this.listAverage);

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => listAverage == null
          ? AspectRatio(
              aspectRatio: 1.7,
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
              aspectRatio: 1.7,
              child: Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4)),
                color: const Color(0xff2c4260),
                child: BarChart(
                  BarChartData(
                    alignment: BarChartAlignment.spaceEvenly,
                    maxY: 50,
                    barTouchData: BarTouchData(
                      enabled: false,
                      touchTooltipData: BarTouchTooltipData(
                        tooltipBgColor: Colors.transparent,
                        tooltipPadding: const EdgeInsets.all(0),
                        tooltipMargin: 8,
                        getTooltipItem: (
                          BarChartGroupData group,
                          int groupIndex,
                          BarChartRodData rod,
                          int rodIndex,
                        ) {
                          return BarTooltipItem(
                            rod.y.round().toString(),
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
                        getTextStyles: (value) => const TextStyle(
                            color: Color(0xff7589a2),
                            fontWeight: FontWeight.bold,
                            fontSize: 14),
                        margin: 20,
                        getTitles: (double value) {
                          var weekday = 0;
                          print(listAverage![value.toInt()]);
                          DateFormat format = DateFormat("dd-MM-yy");
                          var formattedDate =
                              format.parse(listAverage![value.toInt()]['day']);
                          weekday = formattedDate.weekday;
                          print(weekday);

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
                        x: 0,
                        barRods: [
                          BarChartRodData(
                              y: listAverage![0]["averageTemp"],
                              colors: [
                                Colors.lightBlueAccent,
                                Colors.greenAccent
                              ])
                        ],
                        showingTooltipIndicators: [0],
                      ),
                      BarChartGroupData(
                        x: 1,
                        barRods: [
                          BarChartRodData(
                              y: listAverage![1]["averageTemp"],
                              colors: [
                                Colors.lightBlueAccent,
                                Colors.greenAccent
                              ])
                        ],
                        showingTooltipIndicators: [0],
                      ),
                      BarChartGroupData(
                        x: 2,
                        barRods: [
                          BarChartRodData(
                              y: listAverage![2]["averageTemp"],
                              colors: [
                                Colors.lightBlueAccent,
                                Colors.greenAccent
                              ])
                        ],
                        showingTooltipIndicators: [0],
                      ),
                      BarChartGroupData(
                        x: 3,
                        barRods: [
                          BarChartRodData(
                              y: listAverage![3]["averageTemp"],
                              colors: [
                                Colors.lightBlueAccent,
                                Colors.greenAccent
                              ])
                        ],
                        showingTooltipIndicators: [0],
                      ),
                      BarChartGroupData(
                        x: 4,
                        barRods: [
                          BarChartRodData(
                              y: listAverage![4]["averageTemp"],
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

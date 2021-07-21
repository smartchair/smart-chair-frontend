import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class BarGraphTemp extends StatelessWidget {
  double temp = 0;

  BarGraphTemp(this.temp);

  //var diff = currentTime.difference(startTime).inHours;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.7,
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
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
                  List<DateTime>? listDates;
                  var currentTime = DateTime.now();
                  var lastWeek = new DateTime(
                      currentTime.year, currentTime.month, currentTime.day - 7);
                  listDates!.add(lastWeek);
                  var daySix = new DateTime(
                      currentTime.year, currentTime.month, currentTime.day - 6);
                  listDates.add(daySix);
                  var dayFive = new DateTime(
                      currentTime.year, currentTime.month, currentTime.day - 5);
                  listDates.add(dayFive);
                  var dayFour = new DateTime(
                      currentTime.year, currentTime.month, currentTime.day - 4);
                  listDates.add(dayFour);
                  var dayThree = new DateTime(
                      currentTime.year, currentTime.month, currentTime.day - 3);
                  listDates.add(dayThree);
                  var dayTow = new DateTime(
                      currentTime.year, currentTime.month, currentTime.day - 2);
                  listDates.add(dayTow);
                  var dayOne = new DateTime(
                      currentTime.year, currentTime.month, currentTime.day - 1);
                  listDates.add(dayOne);

                  switch (listDates[1].weekday) {
                    case 1:
                      return 'Mn';
                    case 2:
                      return 'Te';
                    case 3:
                      return 'Wd';
                    case 4:
                      return 'Tu';
                    case 5:
                      return 'Fr';
                    case 6:
                      return 'St';
                    case 7:
                      return 'Sn';
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
                      y: temp,
                      colors: [Colors.lightBlueAccent, Colors.greenAccent])
                ],
                showingTooltipIndicators: [0],
              ),
              BarChartGroupData(
                x: 1,
                barRods: [
                  BarChartRodData(
                      y: 10,
                      colors: [Colors.lightBlueAccent, Colors.greenAccent])
                ],
                showingTooltipIndicators: [0],
              ),
              BarChartGroupData(
                x: 2,
                barRods: [
                  BarChartRodData(
                      y: 14,
                      colors: [Colors.lightBlueAccent, Colors.greenAccent])
                ],
                showingTooltipIndicators: [0],
              ),
              BarChartGroupData(
                x: 3,
                barRods: [
                  BarChartRodData(
                      y: 15,
                      colors: [Colors.lightBlueAccent, Colors.greenAccent])
                ],
                showingTooltipIndicators: [0],
              ),
              BarChartGroupData(
                x: 3,
                barRods: [
                  BarChartRodData(
                      y: 13,
                      colors: [Colors.lightBlueAccent, Colors.greenAccent])
                ],
                showingTooltipIndicators: [0],
              ),
              BarChartGroupData(
                x: 3,
                barRods: [
                  BarChartRodData(
                      y: 10,
                      colors: [Colors.lightBlueAccent, Colors.greenAccent])
                ],
                showingTooltipIndicators: [0],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:outii/View/student_previous_data.dart';

class Bar_Chart extends StatelessWidget {
  const Bar_Chart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        barTouchData: barTouchData,
        titlesData: titlesData,
        borderData: borderData,
        barGroups: barGroups,
        gridData: FlGridData(show: false),
        maxY: 14,
      ),
    );
  }
}

List<BarChartGroupData> get barGroups1 =>
    List<BarChartGroupData>.generate(31, (int index) {
      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: value[index].toDouble(),
            color: Colors.blueAccent,
            borderRadius: BorderRadius.zero,
          )
        ],
        showingTooltipIndicators: [0],
      );
    }, growable: false);
Widget getTitles(double value, TitleMeta meta) {
  final style = TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.bold,
    fontSize: 12,
  );
  String text = (value.toInt() + 1).toString();

  return SideTitleWidget(
    axisSide: meta.axisSide,
    space: 3,
    child: Text(text, style: style),
  );
}

BarTouchData get barTouchData => BarTouchData(
      touchTooltipData: BarTouchTooltipData(
        tooltipBgColor: Colors.transparent,
        tooltipPadding: EdgeInsets.zero,
        tooltipMargin: 1,
        getTooltipItem: (
          BarChartGroupData group,
          int groupIndex,
          BarChartRodData rod,
          int rodIndex,
        ) {
          return BarTooltipItem(rod.toY.round().toString(), textStyle);
        },
      ),
    );

FlTitlesData get titlesData => FlTitlesData(
      show: true,
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 20,
          getTitlesWidget: getTitles,
        ),
      ),
      leftTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 25,
          interval: 2,
        ),
      ),
      topTitles: AxisTitles(
        sideTitles: SideTitles(showTitles: false),
      ),
      rightTitles: AxisTitles(
        sideTitles: SideTitles(showTitles: false),
      ),
    );

FlBorderData get borderData => FlBorderData(
      show: true,
    );

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

// import 'package:flutter_chart_demo/data/price_point.dart';
import 'package:food_wise/model/spending.dart';

class LineChartWidget extends StatelessWidget {
  final List<FlSpot> points;

  const LineChartWidget(this.points, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2,
      child: LineChart(
        LineChartData(
            lineBarsData: [
              LineChartBarData(
                spots: const [FlSpot(1681768800585, 5), FlSpot(1681855200947, 10), FlSpot(1681941600673, 0), FlSpot(1682028000546, 0), FlSpot(1682114400862, 10), FlSpot(1682200800875, 0), FlSpot(1682287200197, 5)],
                //points,//points.map((point) => FlSpot(point.date.millisecondsSinceEpoch.toDouble(), point.price.toDouble())).toList(),
                isCurved: true,
                dotData: FlDotData(
                  show: false,
                ),
              ),
            ],
          ),
      ),
    );
  }
}
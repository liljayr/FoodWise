// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/material.dart';

// import 'package:food_wise/model/spending.dart';
// import 'package:intl/intl.dart';

// class BarChartWidget extends StatefulWidget {
//   const BarChartWidget({Key? key, required this.points, required this.points2}) : super(key: key);

//   final List<Spending> points;
//   final List<Spending> points2;

//   @override
//   State<BarChartWidget> createState() => _BarChartWidgetState(points: this.points, points2: this.points2);
// }

// class _BarChartWidgetState extends State<BarChartWidget> {
//   final List<Spending> points;
//   final List<Spending> points2;

//   _BarChartWidgetState({required this.points, required this.points2});

//   @override
//   Widget build(BuildContext context) {
//     return AspectRatio(
//       aspectRatio: 2,
//       child: BarChart(
//         BarChartData(
//             barGroups: _chartGroups(),
//             borderData: FlBorderData(
//                 border: const Border(bottom: BorderSide(), left: BorderSide())),
//             gridData: FlGridData(show: false),
//             titlesData: FlTitlesData(
//               bottomTitles: AxisTitles(sideTitles: _bottomTitles),
//               leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
//               topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
//               rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
//             ),
//           ),
//       ),
//     );
//   }

//   List<BarChartGroupData> _chartGroups() {
//     print("BARSHIT");
//     print(points[0].date);
//     // print(DateFormat('EEEE').format(points[0].date.toDate()));
//     // print(points[0].date.toDate().weekday);
//     return points.map((point) =>
//       BarChartGroupData(
//         x: point.date,
//         // x: DateFormat('EEEE').format(points[0].date.toDate()),
//         // x: point.date.millisecondsSinceEpoch.toInt(),
//         barRods: [
//           BarChartRodData(
//             toY: point.price.toDouble()
//           )
//         ]
//       )

//     ).toList();
//   }

//   SideTitles get _bottomTitles => SideTitles(
//     showTitles: true,
//     getTitlesWidget: (value, meta) {
//       String text = '';
//       // print("AAAAAHKJLKJHJHGJHK");
//       // print(value);
//       // print(value.toInt());
//       switch (value.toInt()) {
//         case 0:
//           text = 'Sunday';
//           break;
//         case 1:
//           text = 'Monday';
//           break;
//         case 2:
//           text = 'Tuesday';
//           break;
//         case 3:
//           text = 'Wednesday';
//           break;
//         case 4:
//           text = 'Thursday';
//           break;
//         case 5:
//           text = 'Friday';
//           break;
//         case 6:
//           text = 'Saturday';
//           break;
//       }

//       return Text(text);
//     },
//   );
// }
/*import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_chart_json/Sales.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:food_wise/widget/bar_chart_2_widget.dart';
import 'package:food_wise/widget/barchart_test.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../model/spending.dart';
import '../widget/bar_chart_widget.dart';

class ChartDetails extends StatefulWidget {
  const ChartDetails({Key? key, required this.pageType}) : super(key: key);
  final String pageType;

  @override
  _ChartDetailPageState createState() {
    return _ChartDetailPageState();
  }
}

class ChartData {
        ChartData(this.x, this.y, this.color);
        final String x;
        final double? y;
        final Color color;
        // final double? y2;
      }

class _ChartDetailPageState extends State<ChartDetails> {
  late List<charts.Series<Spending, String>> _seriesBarData;
  late List<Spending> mydata;
  late List<ChartData> wasteData;

  _generateData(mydata) {
    _seriesBarData = [];// List<charts.Series<Spending, String>>();
    _seriesBarData.add(
      charts.Series(
        domainFn: (Spending sales, _) => sales.date.toString(),
        measureFn: (Spending sales, _) => sales.price,
        // colorFn: (Spending sales, _) =>
        //     charts.ColorUtil.fromDartColor(Color(int.parse(sales.colorVal))),
        id: 'Charts',
        data: mydata,
        labelAccessorFn: (Spending row, _) => "${row.date}",
      ),
    );
  }

  ChangeColor(int value, String column) {
    if(value > 5) {
      return Color(0xFFFF4121);
    }
    else{
      if(column == "price"){
        return Color(0xFF44ACA1);
      }
      else {
        return Color(0xFFF7B24A);
      }
    }
  }

  @override
  void initState() {
    wasteData = [
      ChartData('Wasted', 25, Color(0xFFFF4121)),
      ChartData('Left', 60, Color(0xFFF7B24A)),
      ChartData('Eaten', 15, Color(0xFF44ACA1))
    ];
    super.initState();
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Chart')),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('AvocadoSpentTest').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return LinearProgressIndicator();
        } else {
          List<Spending> sales = snapshot.data?.docs
              .map((documentSnapshot) => Spending(
                documentSnapshot.get('waste'),
                documentSnapshot.get('price'),
                documentSnapshot.get('date'),
                ChangeColor(documentSnapshot.get('price'), "price"),
                ChangeColor(documentSnapshot.get('price'), "waste")))
              //Spending.fromMap(date, documentSnapshot.get('date')))
              .toList() as List<Spending>;
          print("JKASHDFKJSHF");
          print(sales);
          return _buildChart(context, sales);
        }
      },
    );
  }
  // Widget _buildChart(BuildContext context, List<Spending> saledata) {
  //   mydata = saledata;
  //   _generateData(mydata);
  //   return Scaffold(
  //     // appBar: AppBar(
  //     //   title: Text(
  //     //         'My Items',
  //     //         style: TextStyle(fontSize: 25),
  //     //       ),
  //     // ),
  //     body: Center(
  //       // child: LineChartWidget(widget.spent), points: mydata
  //       // child: BarChartSample2(),
  //       child: BarChartWidget(points: mydata, points2: mydata,)
  //       // child: GroupedBarChart(animate: false, seriesList: mydata,),
  //       )
  //   );
  // }
  @override
  Widget _buildChart(BuildContext context, List<Spending> saledata) {
    print("akdjhfaksdjhfksdjhf");
    print(saledata[0].date.toDate().day);
    print(DateFormat('EEEE').format(saledata[0].date.toDate()));
    // final List<Spending> chartData = saledata;
    // <Spending>[
    //    ChartData('Germany', 128, 129),
    //    ChartData('Russia', 123, 92),
    //    ChartData('Norway', 107, 106),
    //    ChartData('USA', 87, 95),
    // ];
    return Scaffold(
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            border: Border.all(
              color: Colors.grey,
              width: 2.0
            )
          ),
          child: SfCartesianChart(
            title: ChartTitle(
              text: "Spending",
              alignment: ChartAlignment.near
            ),
            primaryXAxis: CategoryAxis(),
            legend: Legend(
              isVisible: true,
              position: LegendPosition.top
              ),
            series: <CartesianSeries>[
              ColumnSeries<Spending, String>(
                dataSource: saledata,
                onPointTap: (ChartPointDetails details) {
                  print(details.pointIndex);
                  print(details.seriesIndex);
                },
                selectionBehavior: SelectionBehavior(enable: true),
                // dataLabelSettings: DataLabelSettings(isVisible: true),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(5),
                  topRight: Radius.circular(5)
                ),
                xValueMapper: (Spending data, _) => DateFormat('EEEE').format(data.date.toDate()),
                yValueMapper: (Spending data, _) => data.price,
                color: Color(0xFF44ACA1),
                name: "Money Spent"
              ),
              ColumnSeries<Spending, String>(
                dataSource: saledata,
                onPointTap: (ChartPointDetails details) {
                  print(details.pointIndex);
                  print(details.seriesIndex);
                },
                selectionBehavior: SelectionBehavior(enable: true),
                // dataLabelSettings: DataLabelSettings(isVisible: true),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(5),
                  topRight: Radius.circular(5)
                ),
                xValueMapper: (Spending data, _) => DateFormat('EEEE').format(data.date.toDate()),
                yValueMapper: (Spending data, _) => data.waste,
                color: Color(0xFFF7B24A),
                name: "Money Wasted"
              )
            ]
          )
        ),
      )
    );
  }

     
}*/
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_chart_json/Sales.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:food_wise/widget/bar_chart_2_widget.dart';
import 'package:food_wise/widget/barchart_test.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../model/spending.dart';
import '../widget/bar_chart_widget.dart';

class Charts extends StatefulWidget {
  const Charts({Key? key, required this.pageType}) : super(key: key);
  final String pageType;

  @override
  _ChartPageState createState() {
    return _ChartPageState();
  }
}

class ChartData {
        ChartData(this.x, this.y, this.color);
        final String x;
        final double? y;
        final Color color;
        // final double? y2;
      }

class _ChartPageState extends State<Charts> {
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
                  child: Column(
                    children: [
                      Container(
                        child: SfCircularChart(
                          tooltipBehavior: TooltipBehavior(enable: true),
                          series: <CircularSeries>[
                            DoughnutSeries<ChartData, String>(
                                dataSource: wasteData,
                                pointColorMapper:(ChartData data,  _) => data.color,
                                xValueMapper: (ChartData data, _) => data.x,
                                yValueMapper: (ChartData data, _) => data.y,
                                name: 'Gold',
                                dataLabelMapper: (ChartData data, _) => data.x,
                                dataLabelSettings: DataLabelSettings(
                                  isVisible: true
                                )
                            )
                          ])
                      ),
                      Container(
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
                    Row(
                      children: [
                        Center(
                          child: Container(
                            decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            border: Border.all(
                              color: Colors.grey,
                              width: 2.0
                            )
                          ),
                            child: Column(
                              children: [
                                Text('Water Use'),
                                Text('320 L'),   // 320 liters per avocado https://greenly.earth/en-us/blog/ecology-news/what-is-the-avocados-environmental-impact
                              ],
                            )
                          ),
                        ),
                        Center(
                          child: Container(
                            decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            border: Border.all(
                              color: Colors.grey,
                              width: 2.0
                            )
                          ),
                            child: Column(
                              children:[
                                Text('CO2 Emissions'),
                                Text('425 g'),   // 850 g for 2 avocados https://8billiontrees.com/carbon-offsets-credits/carbon-ecological-footprint-calculators/carbon-footprint-of-avocado/#:~:text=The%20carbon%20footprint%20of%20two%20avocados%20is%20rated%20at%20850%20grams
                              ]
                            )
                          )
                        )
                      ],
                    )
                    ]
                  )
                ),
            )
        );
    }

     
}





// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// // import 'package:flutter_chart_json/Sales.dart';
// import 'package:charts_flutter/flutter.dart' as charts;

// import '../model/spending.dart';

// class Charts extends StatefulWidget {
//   @override
//   _ChartPageState createState() {
//     return _ChartPageState();
//   }
// }

// class _ChartPageState extends State<Charts> {
//   late List<charts.Series<Spending, String>> _seriesBarData;
//   late List<Spending> mydata;
//   _generateData(mydata) {
//     _seriesBarData = [];// List<charts.Series<Spending, String>>();
//     _seriesBarData.add(
//       charts.Series(
//         domainFn: (Spending sales, _) => sales.date.toString(),
//         measureFn: (Spending sales, _) => sales.price,
//         // colorFn: (Spending sales, _) =>
//         //     charts.ColorUtil.fromDartColor(Color(int.parse(sales.colorVal))),
//         id: 'Sales',
//         data: mydata,
//         labelAccessorFn: (Spending row, _) => "${row.date}",
//       ),
//     );
//   }
  

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Sales')),
//       body: _buildBody(context),
//     );
//   }

//   Widget _buildBody(BuildContext context) {
//     return StreamBuilder<QuerySnapshot>(
//       stream: FirebaseFirestore.instance.collection('AvocadoSpentTest').snapshots(),
//       builder: (context, snapshot) {
//         if (!snapshot.hasData) {
//           return LinearProgressIndicator();
//         } else {
//           List<Spending> sales = snapshot.data?.docs
//               .map((documentSnapshot) => Spending(documentSnapshot.get('price'), documentSnapshot.get('date')))
//               //Spending.fromMap(date, documentSnapshot.get('date')))
//               .toList() as List<Spending>;
//           print("JKASHDFKJSHF");
//           print(sales);
//           return _buildChart(context, sales);
//         }
//       },
//     );
//   }
//   Widget _buildChart(BuildContext context, List<Spending> saledata) {
//     mydata = saledata;
//     _generateData(mydata);
//     return AspectRatio(
//       aspectRatio: 2,
//       child: Container(
//         child: Center(
//           child: Column(
//             children: <Widget>[
//               Text(
//                 'Total Spendings',
//                 style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
//               ),
//               SizedBox(
//                 height: 10.0,
//               ),
//               Expanded(
//                 child: charts.BarChart(_seriesBarData,
//                     animate: true,
//                     animationDuration: Duration(seconds:2),
//                      behaviors: [
//                       new charts.DatumLegend(
//                         entryTextStyle: charts.TextStyleSpec(
//                             color: charts.MaterialPalette.purple.shadeDefault,
//                             fontFamily: 'Georgia',
//                             fontSize: 18),
//                       )
//                     ],
//                   ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }




// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/material.dart';

// // Import the firebase_core plugin
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// //Import firestore database
// import 'package:cloud_firestore/cloud_firestore.dart';
// import '../firebase_options.dart';
// import 'package:meta/meta.dart';
// import 'package:intl/intl.dart';
// import 'package:food_wise/model/spending.dart';

// import '../widget/bar_chart_widget.dart';
// import '../widget/line_chart_widget.dart';

// class Chart extends StatelessWidget {
//   const Chart({Key? key}) : super(key: key);
  
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Charts',
//       theme: ThemeData(
//         primarySwatch: Colors.green,
//       ),
//     );
//   }
// }

// class Charts extends StatefulWidget {
//   const Charts({Key? key, required this.saved, required this.spent, required this.co2, required this.water}) : super(key: key);

//   final List saved;
//   final List<Spending> spent;
//   final List co2;
//   final List water;

//   @override
//   _CState createState() => _CState();
// }

// class _CState extends State<Charts> {
//   var saved = [];
//   List<Spending> spent = [];
//   var co2 = [];
//   var water = [];

//   @override
//   void initState() {
//     super.initState();
//     onLoad();
//   }

//   Future<void> onLoad() async {
//     var collection = FirebaseFirestore.instance.collection('AvocadoSpentTest');
//     var snapshot = await collection.get();
//     print("AAAAAAAA");
//     print(snapshot.docs.first.data());
//     print(snapshot.docs[0]);
//     var data = snapshot.docs.first.data();
//     setState(() {
//         // this.spent = snapshot.docs.toList();
//         var prices = snapshot.docs.map((e)=>e.data()['price']).toList();
//         var dates = snapshot.docs.map((e)=>e.data()['date']).toList();
//         // var spentList = snapshot.docs.map((e) => Spending(e.data()['price'], e.data()['date']));
//         // kako.User.fromMap(e.data())).toList();
//         // var values = snapshot.docs.iterator;
//         print("HERE IS THE SPENT");
//         print(prices);
//         print(dates);

//         List<Spending> spent_vals = [];
//         print("Before:");
//         print((spent_vals.runtimeType));

//         for( var i = 0; i < dates.length ; i++ ) {
//           var new_point = new Spending(prices[i], dates[i]);
//           spent_vals.add(new_point);
//           print("added it in");
//           print(spent_vals);
//         }

//         this.spent = spent_vals;

//         // CHANGE TO FLSPOT LIST
//         // this.spent = List.generate(spent_vals.length, (index) {
//         //   return FlSpot(spent_vals[index].date.millisecondsSinceEpoch.toDouble(), spent_vals[index].price.toDouble());
//         // });
//         // print("AAAAAAAAAAAAAAAAAAAA");
//         // print(this.spent);

//         // print("new spent");
//         // print(spent_vals.runtimeType);
//         // print(spent_vals);
//         // this.spent = spent_vals;

//         // print("AAAAAAAA");
//         // print(this.spent.runtimeType);
//         // print(this.spent);

//         // Map<Timestamp, int> thirdMap = {};
//         // print("SPENT");
//         // print(this.spent);
//         // for( var i = 0; i >= this.spent.length ; i++ ) {
//         //   print("WHYYYY");
//         //   print(this.spent[i]);
//         // }

//         // Iterable<Map<Timestamp, int>> spent = snapshot.docs.map((e)=>thirdMap.addAll({e.data()['date'] as Timestamp: e.data()['price'] as int}));
//         // print("NEW MAP");
//         // print(spent);
//       });
//     // if (data != null && data['name'] != null) {
//     //   setState(() {
//     //     this.productName = data['name'] as String;
//     //   });
//     // }
//     // //this.productName = snapshot.docs.first.data()['name'] as String;
//     // print("product name:");
//     // print(this.productName);
//     // if (snapshot1.isEmpty == ConnectionState.done) {
//     //   if (snapshot) {
//     //     Text('Error: ${snapshot.error}');
//     //   } else {
//     //     var names = snapshot.docs.data?.docs.map((doc) => doc['name'] as String).join(', ') ?? '';
//     //     final b_timestamp = snapshot.data?.docs.first['Bought'] as Timestamp;
//     //     final b_date = b_timestamp.toDate(); // Convert the timestamp to a DateTime object
//     //     final b_formattedDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(b_date); // Format the date as a string
//     //     final e_timestamp = snapshot.data?.docs.first['Expires'] as Timestamp;
//     //     final e_date = e_timestamp.toDate(); // Convert the timestamp to a DateTime object
//     //     final e_formattedDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(e_date); // Format the date as a string
//     //     Home(key: ValueKey('my_home_page'), title: names, boughtTime: b_formattedDate, expireTime: e_formattedDate);
//     //   }
//     // }
//   }

  
//   @override
//   Widget build(BuildContext context){
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//               'My Items',
//               style: TextStyle(fontSize: 25),
//             ),
//       ),
//       body: Center(
//         // child: LineChartWidget(widget.spent),
//         child: BarChartWidget(points: widget.spent),
//         )
//     );
//   }
// }
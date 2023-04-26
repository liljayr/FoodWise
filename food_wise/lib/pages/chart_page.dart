import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

// Import the firebase_core plugin
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
//Import firestore database
import 'package:cloud_firestore/cloud_firestore.dart';
import '../firebase_options.dart';
import 'package:meta/meta.dart';
import 'package:intl/intl.dart';
import 'package:food_wise/model/spending.dart';

import '../widget/line_chart_widget.dart';

class Chart extends StatelessWidget {
  const Chart({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Charts',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
    );
  }
}

class Charts extends StatefulWidget {
  const Charts({Key? key, required this.saved, required this.spent, required this.co2, required this.water}) : super(key: key);

  final List saved;
  final List<FlSpot> spent;
  final List co2;
  final List water;

  @override
  _CState createState() => _CState();
}

class _CState extends State<Charts> {
  var saved = [];
  List<FlSpot> spent = [];
  var co2 = [];
  var water = [];

  @override
  void initState() {
    super.initState();
    onLoad();
  }

  Future<void> onLoad() async {
    var collection = FirebaseFirestore.instance.collection('AvocadoSpentTest');
    var snapshot = await collection.get();
    print("AAAAAAAA");
    print(snapshot.docs.first.data());
    print(snapshot.docs[0]);
    var data = snapshot.docs.first.data();
    setState(() {
        // this.spent = snapshot.docs.toList();
        var prices = snapshot.docs.map((e)=>e.data()['price']).toList();
        var dates = snapshot.docs.map((e)=>e.data()['date']).toList();
        // var spentList = snapshot.docs.map((e) => Spending(e.data()['price'], e.data()['date']));
        // kako.User.fromMap(e.data())).toList();
        // var values = snapshot.docs.iterator;
        print("HERE IS THE SPENT");
        print(prices);
        print(dates);

        List<Spending> spent_vals = [];
        print("Before:");
        print((spent_vals.runtimeType));

        for( var i = 0; i < dates.length ; i++ ) {
          var new_point = Spending(prices[i], dates[i]);
          spent_vals.add(new_point);
          print("added it in");
          print(spent_vals);
        }


        this.spent = List.generate(spent_vals.length, (index) {
          return FlSpot(spent_vals[index].date.millisecondsSinceEpoch.toDouble(), spent_vals[index].price.toDouble());
        });
        print("AAAAAAAAAAAAAAAAAAAA");
        print(this.spent);

        // print("new spent");
        // print(spent_vals.runtimeType);
        // print(spent_vals);
        // this.spent = spent_vals;

        // print("AAAAAAAA");
        // print(this.spent.runtimeType);
        // print(this.spent);

        // Map<Timestamp, int> thirdMap = {};
        // print("SPENT");
        // print(this.spent);
        // for( var i = 0; i >= this.spent.length ; i++ ) {
        //   print("WHYYYY");
        //   print(this.spent[i]);
        // }

        // Iterable<Map<Timestamp, int>> spent = snapshot.docs.map((e)=>thirdMap.addAll({e.data()['date'] as Timestamp: e.data()['price'] as int}));
        // print("NEW MAP");
        // print(spent);
      });
    // if (data != null && data['name'] != null) {
    //   setState(() {
    //     this.productName = data['name'] as String;
    //   });
    // }
    // //this.productName = snapshot.docs.first.data()['name'] as String;
    // print("product name:");
    // print(this.productName);
    // if (snapshot1.isEmpty == ConnectionState.done) {
    //   if (snapshot) {
    //     Text('Error: ${snapshot.error}');
    //   } else {
    //     var names = snapshot.docs.data?.docs.map((doc) => doc['name'] as String).join(', ') ?? '';
    //     final b_timestamp = snapshot.data?.docs.first['Bought'] as Timestamp;
    //     final b_date = b_timestamp.toDate(); // Convert the timestamp to a DateTime object
    //     final b_formattedDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(b_date); // Format the date as a string
    //     final e_timestamp = snapshot.data?.docs.first['Expires'] as Timestamp;
    //     final e_date = e_timestamp.toDate(); // Convert the timestamp to a DateTime object
    //     final e_formattedDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(e_date); // Format the date as a string
    //     Home(key: ValueKey('my_home_page'), title: names, boughtTime: b_formattedDate, expireTime: e_formattedDate);
    //   }
    // }
  }

  
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text(
              'My Items',
              style: TextStyle(fontSize: 25),
            ),
      ),
      body: Center(
        child: LineChart(
        LineChartData(
            lineBarsData: [
              LineChartBarData(
                spots: widget.spent,
                //const [FlSpot(1681768800585, 5), FlSpot(1681855200947, 10), FlSpot(1681941600673, 0), FlSpot(1682028000546, 0), FlSpot(1682114400862, 10), FlSpot(1682200800875, 0), FlSpot(1682287200197, 5)],
                //points,//points.map((point) => FlSpot(point.date.millisecondsSinceEpoch.toDouble(), point.price.toDouble())).toList(),
                isCurved: true,
                dotData: FlDotData(
                  show: false,
                ),
              ),
            ],
          ),
      ),
        )
    );
  }
}
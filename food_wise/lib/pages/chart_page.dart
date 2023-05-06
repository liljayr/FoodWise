import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_chart_json/Sales.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:food_wise/pages/second_chart_page.dart';
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
    String _pageType = pageType;
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
  bool _visible = false;
  bool wasteChart = false;
  int detailsChart = -1;

  List<ChartData> foodWasteAvo = [];
  //   ChartData("Veggies", 20, Color(0xFF1BA209)),
  //   ChartData("Meat", 40, Color(0xFF832205)),
  //   ChartData("Dairy", 40, Color(0xFF0B75D8))
  // ];
  List<ChartData> foodEatenAvo = [];
  //   ChartData("Veggies", 90, Color(0xFF1BA209)),
  //   ChartData("Meat", 5, Color(0xFF832205)),
  //   ChartData("Dairy", 5, Color(0xFF0B75D8))
  // ];
  List<ChartData> foodLeftAvo = [];
  //   ChartData("Veggies", 80, Color(0xFF1BA209)),
  //   ChartData("Meat", 5, Color(0xFF832205)),
  //   ChartData("Dairy", 15, Color(0xFF0B75D8))
  // ];
  List<ChartData> foodEatenLeftAvo = [];
  String leftEatenStr = "";

  _generateData(mydata) {
    _seriesBarData = []; // List<charts.Series<Spending, String>>();
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
    if (value > 5) {
      return Color(0xFFFF4121);
    } else {
      if (column == "price") {
        return Color(0xFF44ACA1);
      } else {
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
    onLoad();
  }

  Future<void> onLoad() async {
    var collectionEaten = FirebaseFirestore.instance.collection('AvocadoEaten');
    var snapshotEaten = await collectionEaten.get();
    var dataListEaten = snapshotEaten.docs.toList();
    foodEatenAvo = dataListEaten
        .map((e) => ChartData(e.get('category'), e.get('quantity'),
            Color(int.parse(e.get('color')))))
        .toList();

    print("Get left food");

    var collectionFood = FirebaseFirestore.instance.collection('AvocadoFood');
    var snapshotFood = await collectionFood.get();
    var dataListFood = snapshotFood.docs.toList();
    print("about to go");
    print(dataListFood);
    for (var i = 0; i < dataListFood.length; i++) {
      print(dataListFood[i]);
      print("aaaaaaa");
      print(dataListFood[i]['quantity']);
    }
    print("is this right");
    foodLeftAvo = dataListFood
        .map((e) => ChartData(e.get('category'), e.get('quantity'),
            Color(int.parse(e.get('color')))))
        .toList();

    print("is this ruight????????");
    print(foodLeftAvo);

    var collectionWasted =
        FirebaseFirestore.instance.collection('AvocadoWasted');
    var snapshotWasted = await collectionWasted.get();
    var dataListWasted = snapshotWasted.docs.toList();
    foodWasteAvo = dataListWasted
        .map((e) => ChartData(e.get('category'), e.get('quantity'),
            Color(int.parse(e.get('color')))))
        .toList();
    // print("ONLOAD");
    // snapshot.docs.map((e) {
    //     print("Mapping e to get what it is");
    //     print(e.data());
    //     print(e['category']);
    //   }
    // );
    // print("Did this work at all?");
    // print(mapperThingy);
    // print(dataList);
    // print(dataList[0]['category']);
    // print("done!");
    // var data = snapshot.docs.first.data();
    // if (data != null && data['name'] != null) {
    //   setState(() {
    //     this.productName = data['name'] as String;
    //   });
    // }
    //this.productName = snapshot.docs.first.data()['name'] as String;
    // print("product name:");
    // print(this.productName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(title: Text('Chart')),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    print("IS THEE PAGE KIND HERE");
    print(widget.pageType);
    return StreamBuilder<QuerySnapshot>(
      stream:
          FirebaseFirestore.instance.collection('AvocadoSpentTest').snapshots(),
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

  void setVisibility(int pointIndex) {
    print("Changing visibility pleeease");
    setState(() {
      if (!_visible) {
        // showing main chart, visible = false
        print("change to show detailed chart");
        if (pointIndex == 0) {
          // click on waste chart
          print("Click on waste chart");
          wasteChart = !wasteChart; // wasteChart false -> true
          detailsChart = pointIndex; // set detailsChart -1 -> 0
          _visible = !_visible; // visible false -> true
        } else if (pointIndex == 1 || pointIndex == 2) {
          // click on left or eat chart
          print("Click on left or eaten chart");
          detailsChart = pointIndex; // set detailsChart -1 -> 0
          _visible = !_visible; // visible false -> true
          if (pointIndex == 1) {
            foodEatenLeftAvo = foodLeftAvo;
            leftEatenStr = "Food Left";
          } else {
            foodEatenLeftAvo = foodEatenAvo;
            leftEatenStr = "Food Eaten";
          }
        }
      } else {
        // Showing detailed chart already
        print("Already showing detailed chart");
        print(detailsChart);
        print(pointIndex);
        if (pointIndex == detailsChart) {
          // reclick on same part of chart
          print("reclick on same chart part");
          _visible = !_visible;
          wasteChart = false;
          detailsChart = -1;
        } else if (detailsChart == 0) {
          // clicking from waste chart
          print("Clicking away from waste chart");
          wasteChart = !wasteChart;
          detailsChart = pointIndex;
          print(wasteChart);
          if (pointIndex == 1) {
            foodEatenLeftAvo = foodLeftAvo;
            leftEatenStr = "Food Left";
          } else {
            foodEatenLeftAvo = foodEatenAvo;
            leftEatenStr = "Food Eaten";
          }
        } else if (detailsChart == 1 || detailsChart == 2) {
          // clicking from left or eaten
          if (pointIndex == 0) {
            // clicking to waste
            print("going from left or eaten to waste");
            wasteChart = !wasteChart;
          }
          print("going between left and eaten charts");
          detailsChart = pointIndex;
          if (pointIndex == 1) {
            foodEatenLeftAvo = foodLeftAvo;
            leftEatenStr = "Food Left";
          } else {
            foodEatenLeftAvo = foodEatenAvo;
            leftEatenStr = "Food Eaten";
          }
        }
      }
      // if(detailsChart == pointIndex && !_visible){
      //   print("Clicked on the same one");
      //   _visible = !_visible;
      //   print(_visible);
      //   print(detailsChart);
      // }
      // else if(_visible){
      //   print("first click");
      //   detailsChart = pointIndex;
      //   _visible = !_visible;
      //   print(_visible);
      //   print(detailsChart);
      // }
      // else{
      //   print("only changing the details chart");
      //   detailsChart = pointIndex;
      //   print(_visible);
      //   print(detailsChart);
      // }
    });
  }

  Widget TextDis(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Container(
        child: Center(
          child: Column(
            children: [Text('aaaaaa')],
          ),
        ),
      ),
    ));
  }

  @override
  Widget _buildChart(BuildContext context, List<Spending> saledata) {
    // bool _visible = true;
    //print("akdjhfaksdjhfksdjhf");
    //print(saledata[0].date.toDate().day);
    //print(DateFormat('EEEE').format(saledata[0].date.toDate()));

    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(left: 39, top: 38),
              child: Row(
                  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 83),
                      child: Image.asset(
                        'lib/images/logo.png',
                        height: 23,
                        width: 110,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: Image.asset(
                        'lib/images/notification.png',
                        height: 52,
                        width: 52,
                      ),
                    ),
                    Image.asset(
                      'lib/images/profile.png',
                      height: 52,
                      width: 52,
                    ),
                  ]),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 39, top: 30),
              child: Text('Statistics',
                  style: TextStyle(
                      fontSize: 24,
                      color: Color(0xFF4E4E4E),
                      fontFamily: 'Montserat',
                      fontWeight: FontWeight.w900)),
            ),
            SizedBox(
              height: 17,
            ),
            Expanded(
              child: SingleChildScrollView(
                  child: Center(
                child: Container(
                    child: Column(children: [
                  // GestureDetector(
                  //   behavior: HitTestBehavior.translucent,
                  //   onTap: (){
                  //     print("Container clicked");
                  //   },
                  Padding(
                    padding: const EdgeInsets.only(top: 4, bottom: 28),
                    child: Container(
                        height: 200,
                        width: 312,
                        decoration: BoxDecoration(
                            color: Color(0xFFFFFFFF),
                            borderRadius: BorderRadius.circular(14),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xFF828282).withOpacity(0.2),
                                blurRadius: 23,
                                spreadRadius: -4,
                                offset: Offset(0, 4.0),
                              ),
                            ]),
                        child: Stack(
                          children: [
                            Positioned(
                              top: 18,
                              left: 20,
                              child: Container(
                                height: 29,
                                width: 29,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(3),
                                  color: Color(0xFFF7B24A).withOpacity(0.2),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(5.2),
                                  child: Image.asset(
                                    'lib/images/veg.png',
                                    height: 17,
                                    width: 18.53,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              child: Positioned(
                                top: 26,
                                left: 58,
                                child: Text('Your inventory',
                                    style: TextStyle(
                                        color: Color(0xFF4E4E4E),
                                        fontSize: 12,
                                        fontFamily: 'Montserat',
                                        fontWeight: FontWeight.w700)),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 40,
                              ),
                              child: SfCircularChart(
                                  // title: ChartTitle(
                                  //   text: "Food usage"
                                  // ),
                                  legend: Legend(isVisible: true),
                                  // onChartTouchInteractionUp:(ChartTouchInteractionArgs args){
                                  //   print("AAAAAAAA am i touching this now???");
                                  //   // print(args);
                                  //   // print(args.position.dx.toString());
                                  //   // print(args.position.dy.toString());
                                  //   setVisibility();
                                  //   print(detailsChart);
                                  // },
                                  tooltipBehavior:
                                      TooltipBehavior(enable: true),
                                  series: <CircularSeries>[
                                    DoughnutSeries<ChartData, String>(
                                        dataSource: wasteData,
                                        explode: true,
                                        onPointTap:
                                            (ChartPointDetails details) {
                                          print("WTFFFF");
                                          print("Point index");
                                          print(details.pointIndex);
                                          // detailsChart = details.pointIndex!;
                                          print("series index");
                                          print(details.seriesIndex);
                                          setVisibility(
                                              details.pointIndex as int);
                                          // TextDis(context);
                                          // setState(() {
                                          //   _visible = !_visible;
                                          //   print("Changing visible");
                                          //   print(_visible);
                                          // });
                                        },
                                        selectionBehavior:
                                            SelectionBehavior(enable: true),
                                        pointColorMapper: (ChartData data, _) =>
                                            data.color,
                                        xValueMapper: (ChartData data, _) =>
                                            data.x,
                                        yValueMapper: (ChartData data, _) =>
                                            data.y,
                                        // name: ((ChartData data, _) => data.x) as String,
                                        //dataLabelMapper: (ChartData data, _) =>
                                        //  data.x,
                                        dataLabelSettings: DataLabelSettings(
                                            isVisible: true,
                                            labelPosition:
                                                ChartDataLabelPosition.outside))
                                  ]),
                            ),
                          ],
                        )
                        // ),
                        ),
                  ),
                  if (_visible)
                    AnimatedOpacity(
                      opacity: _visible ? 1.0 : 0.0,
                      duration: const Duration(milliseconds: 500),
                      child: Container(
                        child: Column(
                          children: [
                            if (wasteChart)
                              Column(
                                children: [
                                  Container(
                                    height: 328,
                                    width: 312,
                                    decoration: BoxDecoration(
                                        color: Color(0xFFFFFFFF),
                                        borderRadius: BorderRadius.circular(14),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Color(0xFF828282)
                                                .withOpacity(0.2),
                                            blurRadius: 23,
                                            spreadRadius: -4,
                                            offset: Offset(0, 4.0),
                                          ),
                                        ]),
                                    child: Stack(
                                      children: [
                                        Positioned(
                                          top: 26,
                                          left: 27,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 14),
                                            child: Container(
                                              height: 14,
                                              width: 14,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(3),
                                                color: Color(0xFFF77F7C),
                                              ),
                                              /*child: Padding(
                                                padding:
                                                    const EdgeInsets.all(5.2),
                                                child: Image.asset(
                                                  'lib/images/veg.png',
                                                  height: 17,
                                                  width: 10,
                                                ),
                                              ),*/
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          top: 26,
                                          left: 58,
                                          bottom: 14,
                                          child: Text('Wasted items',
                                              style: TextStyle(
                                                  color: Color(0xFF4E4E4E),
                                                  fontSize: 12,
                                                  fontFamily: 'Montserat',
                                                  fontWeight: FontWeight.w700)),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 20,
                                              top: 40,
                                              right: 20,
                                              bottom: 18),
                                          child: SfCartesianChart(
                                              primaryYAxis: NumericAxis(
                                                  labelFormat: '{value} %',
                                                  labelStyle: TextStyle(
                                                      color: Color(0xFFB1B1B1),
                                                      fontFamily: 'Montserrat',
                                                      fontSize: 10,
                                                      //fontStyle: FontStyle.italic,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                  axisLine: AxisLine(
                                                    color: Color(0xFFB1B1B1)
                                                        .withOpacity(0.2),
                                                    width: 0.6,
                                                  ),
                                                  majorGridLines:
                                                      MajorGridLines(
                                                    width: 0.6,
                                                    color: Color(0xFFB1B1B1)
                                                        .withOpacity(0.2),
                                                  ),
                                                  //dashArray: <double>[5, 5]),
                                                  minorGridLines:
                                                      MinorGridLines(
                                                    width: 0.6,
                                                    color: Color(0xFFB1B1B1)
                                                        .withOpacity(0.2),
                                                  ),
                                                  minimum: 0,
                                                  maximum: 100),
                                              title: ChartTitle(
                                                  //text: "AAAAA",
                                                  alignment:
                                                      ChartAlignment.near),
                                              primaryXAxis: CategoryAxis(
                                                labelStyle: TextStyle(
                                                    color: Color(0xFFB1B1B1),
                                                    fontFamily: 'Montserrat',
                                                    fontSize: 10,
                                                    //fontStyle: FontStyle.italic,
                                                    fontWeight:
                                                        FontWeight.w500),
                                                axisLine: AxisLine(
                                                  color: Color(0xFFB1B1B1)
                                                      .withOpacity(0.2),
                                                  width: 0.6,
                                                ),
                                                majorGridLines: MajorGridLines(
                                                  width: 0.1,
                                                  color: Color(0xFFB1B1B1)
                                                      .withOpacity(0.2),
                                                ),
                                                //dashArray: <double>[5, 5]),
                                                minorGridLines: MinorGridLines(
                                                  width: 0.1,
                                                  color: Color(0xFFB1B1B1)
                                                      .withOpacity(0.2),
                                                ),
                                                // dashArray: <double>[5, 5]),
                                                //minorTicksPerInterval: 1),
                                              ),
                                              legend: Legend(
                                                  isVisible: true,
                                                  position: LegendPosition.top),
                                              series: <CartesianSeries>[
                                                ColumnSeries<ChartData, String>(
                                                    dataSource: (foodWasteAvo),
                                                    // onPointTap: (ChartPointDetails details) {
                                                    //   print(details.pointIndex);
                                                    //   print(details.seriesIndex);
                                                    // },
                                                    // selectionBehavior: SelectionBehavior(enable: true),
                                                    // dataLabelSettings: DataLabelSettings(isVisible: true),
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            topLeft: Radius
                                                                .circular(5),
                                                            topRight:
                                                                Radius.circular(
                                                                    5)),
                                                    xValueMapper:
                                                        (ChartData data, _) =>
                                                            data.x,
                                                    yValueMapper:
                                                        (ChartData data, _) =>
                                                            data.y,
                                                    color: Color(0xFFFF4121),
                                                    name: "Percentage"),
                                              ]),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            if (!wasteChart) //HEREEEEEEEEEEEEEEEEEEEEEEE

                              Container(
                                height: 200,
                                width: 312,
                                decoration: BoxDecoration(
                                    color: Color(0xFFFFFFFF),
                                    borderRadius: BorderRadius.circular(14),
                                    boxShadow: [
                                      BoxShadow(
                                        color:
                                            Color(0xFF828282).withOpacity(0.2),
                                        blurRadius: 23,
                                        spreadRadius: -4,
                                        offset: Offset(0, 4.0),
                                      ),
                                    ]),
                                child: Stack(
                                  children: [
                                    Positioned(
                                      top: 26,
                                      left: 27,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 14),
                                        child: Container(
                                          height: 14,
                                          width: 14,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(3),
                                            color: Color(0xFF44ACA1),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 26,
                                      left: 58,
                                      bottom: 14,
                                      child: Text('Eaten items',
                                          style: TextStyle(
                                              color: Color(0xFF4E4E4E),
                                              fontSize: 12,
                                              fontFamily: 'Montserat',
                                              fontWeight: FontWeight.w700)),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 40, left: 20),
                                      child: SfCircularChart(
                                          // title: ChartTitle(
                                          //   text: "Food usage"
                                          // ),
                                          legend: Legend(isVisible: true),
                                          // onChartTouchInteractionUp:(ChartTouchInteractionArgs args){
                                          //   print("AAAAAAAA am i touching this now???");
                                          //   // print(args);
                                          //   // print(args.position.dx.toString());
                                          //   // print(args.position.dy.toString());
                                          //   setVisibility();
                                          //   print(detailsChart);
                                          // },
                                          tooltipBehavior:
                                              TooltipBehavior(enable: true),
                                          series: <CircularSeries>[
                                            DoughnutSeries<ChartData, String>(
                                                dataSource: foodEatenLeftAvo,
                                                explode: true,
                                                onPointTap: (ChartPointDetails
                                                    details) {
                                                  print("WTFFFF");
                                                  print("Point index");
                                                  print(details.pointIndex);
                                                  detailsChart =
                                                      details.pointIndex!;
                                                  print("series index");
                                                  print(details.seriesIndex);
                                                  // setVisibility();
                                                  // TextDis(context);
                                                  // setState(() {
                                                  //   _visible = !_visible;
                                                  //   print("Changing visible");
                                                  //   print(_visible);
                                                  // });
                                                },
                                                selectionBehavior:
                                                    SelectionBehavior(
                                                        enable: true),
                                                pointColorMapper:
                                                    (ChartData data, _) =>
                                                        data.color,
                                                xValueMapper:
                                                    (ChartData data, _) =>
                                                        data.x,
                                                yValueMapper:
                                                    (ChartData data, _) =>
                                                        data.y,
                                                // name: ((ChartData data, _) => data.x) as String,
                                                dataLabelMapper:
                                                    (ChartData data, _) =>
                                                        data.x,
                                                dataLabelSettings:
                                                    DataLabelSettings(
                                                        isVisible: true,
                                                        labelPosition:
                                                            ChartDataLabelPosition
                                                                .outside))
                                          ]),
                                    ),
                                  ],
                                ),
                              )
                            // ChartDetails(pageType: "avocado",),
                          ],
                        ),
                      ),
                    ),
                  if (!_visible)
                    AnimatedOpacity(
                        opacity: !_visible ? 1.0 : 0.0,
                        duration: const Duration(milliseconds: 500),
                        child: Column(children: [
                          Container(
                              height: 328,
                              width: 312,
                              decoration: BoxDecoration(
                                  color: Color(0xFFFFFFFF),
                                  borderRadius: BorderRadius.circular(14),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color(0xFF828282).withOpacity(0.2),
                                      blurRadius: 23,
                                      spreadRadius: -4,
                                      offset: Offset(0, 4.0),
                                    ),
                                  ]),
                              child: Stack(
                                children: [
                                  Positioned(
                                    top: 18,
                                    left: 20,
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 14),
                                      child: Container(
                                        height: 29,
                                        width: 29,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(3),
                                          color: Color(0xFFF77F7C)
                                              .withOpacity(0.2),
                                        ),
                                        child: Image.asset(
                                          'lib/images/money.png',
                                          height: 17,
                                          width: 10,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    child: Positioned(
                                      top: 26,
                                      left: 58,
                                      bottom: 14,
                                      child: Text('Spendings',
                                          style: TextStyle(
                                              color: Color(0xFF4E4E4E),
                                              fontSize: 12,
                                              fontFamily: 'Montserat',
                                              fontWeight: FontWeight.w700)),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20,
                                        top: 40,
                                        right: 20,
                                        bottom: 18),
                                    child: SfCartesianChart(
                                        /* title: ChartTitle(
                                    text: "Spendings",
                                    
                                    textStyle: TextStyle(
                                        color: Color(0xFF4E4E4E),
                                        fontSize: 12,
                                        fontFamily: 'Montserat',
                                        fontWeight: FontWeight.w700),
                                    alignment: ChartAlignment.near),*/
                                        /*primaryYAxis: CategoryAxis(
                                  title: AxisTitle(
                                      text: 'DKK',
                                      textStyle: TextStyle(
                                          color: Color(0xFF4E4E4E),
                                          fontFamily: 'Montserrat',
                                          fontSize: 10,
                                          //fontStyle: FontStyle.italic,
                                          fontWeight: FontWeight.w500)),
                                    ),*/
                                        primaryYAxis: NumericAxis(
                                          // '°C' will be append to all the labels in Y axis
                                          labelFormat: '{value} DKK',
                                          labelStyle: TextStyle(
                                              color: Color(0xFFB1B1B1),
                                              fontFamily: 'Montserrat',
                                              fontSize: 10,
                                              //fontStyle: FontStyle.italic,
                                              fontWeight: FontWeight.w500),
                                          axisLine: AxisLine(
                                            color: Color(0xFFB1B1B1)
                                                .withOpacity(0.2),
                                            width: 0.6,
                                          ),
                                          majorGridLines: MajorGridLines(
                                            width: 0.6,
                                            color: Color(0xFFB1B1B1)
                                                .withOpacity(0.2),
                                          ),
                                          //dashArray: <double>[5, 5]),
                                          minorGridLines: MinorGridLines(
                                            width: 0.6,
                                            color: Color(0xFFB1B1B1)
                                                .withOpacity(0.2),
                                          ),
                                        ),
                                        primaryXAxis: CategoryAxis(
                                          labelStyle: TextStyle(
                                              color: Color(0xFFB1B1B1),
                                              fontFamily: 'Montserrat',
                                              fontSize: 10,
                                              //fontStyle: FontStyle.italic,
                                              fontWeight: FontWeight.w500),
                                          axisLine: AxisLine(
                                            color: Color(0xFFB1B1B1)
                                                .withOpacity(0.2),
                                            width: 0.6,
                                          ),
                                          majorGridLines: MajorGridLines(
                                            width: 0.1,
                                            color: Color(0xFFB1B1B1)
                                                .withOpacity(0.2),
                                          ),
                                          //dashArray: <double>[5, 5]),
                                          minorGridLines: MinorGridLines(
                                            width: 0.1,
                                            color: Color(0xFFB1B1B1)
                                                .withOpacity(0.2),
                                          ),
                                          // dashArray: <double>[5, 5]),
                                          //minorTicksPerInterval: 1),
                                        ),
                                        legend: Legend(
                                          isVisible: true,
                                          //image: AssetImage('images/truck_legend.png'),
                                          // offset: Offset(2, 2)),
                                          position: LegendPosition.top,
                                          //offset: Offset(2, 2),
                                        ),
                                        series: <CartesianSeries>[
                                          ColumnSeries<Spending, String>(
                                              dataSource: saledata,
                                              // onPointTap: (ChartPointDetails details) {
                                              //   print(details.pointIndex);
                                              //   print(details.seriesIndex);
                                              // },
                                              // selectionBehavior: SelectionBehavior(enable: true),
                                              // dataLabelSettings: DataLabelSettings(isVisible: true),
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(3),
                                                  topRight: Radius.circular(3)),
                                              xValueMapper:
                                                  (Spending data, _) =>
                                                      data.date,
                                              yValueMapper:
                                                  (Spending data, _) =>
                                                      data.price,
                                              color: Color(0xFFF7B24A),
                                              name: "Monthly"),
                                          ColumnSeries<Spending, String>(
                                              dataSource: saledata,
                                              // onPointTap: (ChartPointDetails details) {
                                              //   print(details.pointIndex);
                                              //   print(details.seriesIndex);
                                              // },
                                              // selectionBehavior: SelectionBehavior(enable: true),
                                              // dataLabelSettings: DataLabelSettings(isVisible: true),
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(3),
                                                  topRight: Radius.circular(3)),
                                              xValueMapper:
                                                  (Spending data, _) =>
                                                      data.date,
                                              yValueMapper:
                                                  (Spending data, _) =>
                                                      data.waste,
                                              color: Color(0xFFF77F7C),
                                              name: "Expired item expense")
                                        ]),
                                  ),
                                ],
                              )),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 28, left: 39, bottom: 40),
                                child: Container(
                                    height: 125,
                                    width: 145,
                                    decoration: BoxDecoration(
                                        color: Color(0xFFFFFFFF),
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Color(0xFF828282)
                                                .withOpacity(0.2),
                                            blurRadius: 23,
                                            spreadRadius: -4,
                                            offset: Offset(0, 4.0),
                                          ),
                                        ]),
                                    child: Stack(children: [
                                      Positioned(
                                        top: 18,
                                        left: 20,
                                        child: Container(
                                          height: 29,
                                          width: 29,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(3),
                                            color: Color(0xFF6192DA)
                                                .withOpacity(0.2),
                                          ),
                                          child: Image.asset(
                                            'lib/images/water.png',
                                            height: 15,
                                            width: 10,
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        top: 19,
                                        left: 58,
                                        child: Text('Water',
                                            style: TextStyle(
                                                color: Color(0xFF4E4E4E),
                                                fontSize: 12,
                                                fontFamily: 'Montserat',
                                                fontWeight: FontWeight.w700)),
                                      ),
                                      Positioned(
                                        top: 34,
                                        left: 58,
                                        child: Text('use',
                                            style: TextStyle(
                                                color: Color(0xFF4E4E4E),
                                                fontSize: 12,
                                                fontFamily: 'Montserat',
                                                fontWeight: FontWeight.w700)),
                                      ),
                                      Positioned(
                                        top: 61,
                                        left: 20,
                                        child: Text('Average',
                                            style: TextStyle(
                                                color: Color(0xFFABABAB),
                                                fontSize: 12,
                                                fontFamily: 'Montserat',
                                                fontWeight: FontWeight.w500)),
                                      ),
                                      Positioned(
                                        top: 84,
                                        left: 20,
                                        child: Text('320 l',
                                            style: TextStyle(
                                                color: Color(0xFF4E4E4E),
                                                fontSize: 22,
                                                fontFamily: 'Montserat',
                                                fontWeight: FontWeight.w500)),
                                      ),
                                      /*Icon(
                                    Icons.water_drop,
                                    color: Colors.blue,
                                    size: 30.0,
                                  ),*/
                                      /* Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text('Water Use',
                                          style: TextStyle(
                                              color: Color(0xFF4E4E4E),
                                              fontSize: 12,
                                              fontFamily: 'Montserat',
                                              fontWeight: FontWeight.w700)),
                                      Text(
                                          '320 L'), // 320 liters per avocado https://greenly.earth/en-us/blog/ecology-news/what-is-the-avocados-environmental-impact
                                    ],
                                  )*/
                                    ])),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 28, left: 22, right: 39),
                                child: Container(
                                    height: 125,
                                    width: 145,
                                    decoration: BoxDecoration(
                                        color: Color(0xFFFFFFFF),
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Color(0xFF828282)
                                                .withOpacity(0.2),
                                            blurRadius: 23,
                                            spreadRadius: -4,
                                            offset: Offset(0, 4.0),
                                          ),
                                        ]),
                                    child: Stack(
                                        //crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Positioned(
                                            top: 18,
                                            left: 20,
                                            child: Container(
                                              height: 29,
                                              width: 29,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(3),
                                                color: Color(0xFF44ACA1)
                                                    .withOpacity(0.2),
                                              ),
                                              child: Image.asset(
                                                'lib/images/cloud.png',
                                                height: 11,
                                                width: 20,
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            top: 19,
                                            left: 58,
                                            child: Text('CO2',
                                                style: TextStyle(
                                                    color: Color(0xFF4E4E4E),
                                                    fontSize: 12,
                                                    fontFamily: 'Montserat',
                                                    fontWeight:
                                                        FontWeight.w700)),
                                          ),
                                          Positioned(
                                            top: 34,
                                            left: 58,
                                            child: Text('emissions',
                                                style: TextStyle(
                                                    color: Color(0xFF4E4E4E),
                                                    fontSize: 12,
                                                    fontFamily: 'Montserat',
                                                    fontWeight:
                                                        FontWeight.w700)),
                                          ),
                                          Positioned(
                                            top: 61,
                                            left: 20,
                                            child: Text('Average',
                                                style: TextStyle(
                                                    color: Color(0xFFABABAB),
                                                    fontSize: 12,
                                                    fontFamily: 'Montserat',
                                                    fontWeight:
                                                        FontWeight.w500)),
                                          ),
                                          Positioned(
                                            top: 84,
                                            left: 20,
                                            child: Text('425 g',
                                                style: TextStyle(
                                                    color: Color(0xFF4E4E4E),
                                                    fontSize: 22,
                                                    fontFamily: 'Montserat',
                                                    fontWeight:
                                                        FontWeight.w500)),
                                          ),

                                          /*Icon(
                                    Icons.cloud,
                                    color: Colors.black,
                                    size: 30.0,
                                  ),*/
                                          /* Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text('CO2 Emissions',
                                            style: TextStyle(
                                                color: Color(0xFF4E4E4E),
                                                fontSize: 12,
                                                fontFamily: 'Montserat',
                                                fontWeight: FontWeight.w700)),
                                        Text(
                                            '425 g'), // 850 g for 2 avocados https://8billiontrees.com/carbon-offsets-credits/carbon-ecological-footprint-calculators/carbon-footprint-of-avocado/#:~:text=The%20carbon%20footprint%20of%20two%20avocados%20is%20rated%20at%20850%20grams
                                      ])*/
                                        ])),
                              )
                            ],
                          )
                        ]))
                ])),
              )),
            ),
          ],
        ));
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
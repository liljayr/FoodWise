import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

// Import the firebase_core plugin
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
//Import firestore database
import 'package:cloud_firestore/cloud_firestore.dart';
import '../firebase_options.dart';
import 'package:meta/meta.dart';
import 'package:intl/intl.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FoodWise',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      // home: FutureBuilder<QuerySnapshot>(
      //   future: FirebaseFirestore.instance.collection('Food').get(),
      //   builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
      //     if (snapshot.connectionState == ConnectionState.done) {
      //       // if (snapshot.hasError) {
      //       //   return Text('Error: ${snapshot.error}');
      //       // } else {
      //       //   var names = snapshot.data?.docs.map((doc) => doc['name'] as String).join(', ') ?? '';
      //       //   final b_timestamp = snapshot.data?.docs.first['Bought'] as Timestamp;
      //       //   final b_date = b_timestamp.toDate(); // Convert the timestamp to a DateTime object
      //       //   final b_formattedDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(b_date); // Format the date as a string
      //       //   final e_timestamp = snapshot.data?.docs.first['Expires'] as Timestamp;
      //       //   final e_date = e_timestamp.toDate(); // Convert the timestamp to a DateTime object
      //       //   final e_formattedDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(e_date); // Format the date as a string
      //       //   return Home(key: ValueKey('my_home_page'), title: names, boughtTime: b_formattedDate, expireTime: e_formattedDate);
      //       // }
      //     } else {
      //       return CircularProgressIndicator();
      //     }
      //   },
      // ),
    );
  }
}

class Home extends StatefulWidget {
  const Home(
      {Key? key,
      required this.title,
      required this.boughtTime,
      required this.expireTime})
      : super(key: key);

  final String boughtTime;
  final String expireTime;
  final String title;

  @override
  _HState createState() => _HState();
}

class _HState extends State<Home> with TickerProviderStateMixin {
  //List<String> labels = ['Fresh', 'Expired'];
  //int counter = 0;

  final List products = [
    {"image": "lib/images/avocado.png"},
    {"image": "lib/images/avocado.png"},
  ];

  var productName = "";
  var boughtTime = "";
  var expireTime = "";

  @override
  void initState() {
    super.initState();
    onLoad();
  }

  Future<void> onLoad() async {
    var collection = FirebaseFirestore.instance.collection('Food');
    var snapshot1 = collection.snapshots();
    var snapshot = await collection.get();
    print("AAAAAAAA");
    print(snapshot.docs.first.data());
    print(snapshot.docs[0]);
    var data = snapshot.docs.first.data();
    if (data != null && data['name'] != null) {
      setState(() {
        this.productName = data['name'] as String;
      });
    }
    //this.productName = snapshot.docs.first.data()['name'] as String;
    print("product name:");
    print(this.productName);
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
  Widget build(BuildContext context) {
    TabController tabController = TabController(length: 2, vsync: this);

    return Scaffold(
      //appBar: AppBar(
      //title: Text(
      //'My Items',
      //style: TextStyle(fontSize: 25),
      //),
      //),
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
          Widget>[
        Container(
          margin: EdgeInsets.only(left: 39, top: 38),
          child: Row(
              //mainAxisAlignment: MainAxisAlignment.start,

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
          child: Text('Hi, Emma!',
              style: TextStyle(
                  fontSize: 24,
                  color: Color(0xFF4E4E4E),
                  fontFamily: 'Montserat',
                  fontWeight: FontWeight.w900)),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 39, top: 21),
          child: Container(
            height: 109,
            width: 312,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color(0xFF44ACA1).withOpacity(0.2),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFF929292).withOpacity(0.2),
                    blurRadius: 23,
                    spreadRadius: -4,
                    offset: Offset(0, 4.0),
                  ),
                ]),
            child: Stack(children: [
              Positioned(
                top: 17.25,
                left: 22,
                child: Text(
                  "Your avocado is about",
                  style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFF4E4E4E),
                      fontFamily: 'Montserat',
                      fontWeight: FontWeight.w800),
                ),
              ),
              Positioned(
                top: 32,
                left: 22,
                child: Text(
                  "to expire soon!",
                  style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFF4E4E4E),
                      fontFamily: 'Montserat',
                      fontWeight: FontWeight.w800),
                ),
              ),
              Positioned(
                  top: 56.5,
                  left: 22,
                  child: Container(
                    height: 35,
                    width: 164,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Color(0xFF44ACA1),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xFF929292).withOpacity(0.2),
                            blurRadius: 23,
                            spreadRadius: -4,
                            offset: Offset(0, 4.0),
                          ),
                        ]),
                    child: Center(
                      child: Text(
                        "Check out the recipes here",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 10,
                            color: Color(0xFFFFFFFF),
                            fontFamily: 'Montserat',
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  )),
              Positioned(
                top: 30,
                right: 54,
                child: Image.asset("lib/images/avocado.png"),
              ),
              Positioned(
                top: 12,
                right: 12,
                child: Image.asset("lib/images/close.png"),
              ),
            ]),
          ),
        ),
        SizedBox(
          height: 30,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 39),
          child: Text("Your inventory",
              style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF4E4E4E),
                  fontFamily: 'Montserat',
                  fontWeight: FontWeight.w700)),
        ),
        SizedBox(
          height: 25,
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 21),
            child: Container(
              height: 42,
              width: 312,
              decoration: BoxDecoration(
                  color: Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.circular(9),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFF828282).withOpacity(0.2),
                      blurRadius: 23,
                      spreadRadius: -4,
                      offset: Offset(0, 4.0),
                    ),
                  ]),
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6)),
                elevation: 0,
                child: Container(
                  height: 42,
                  width: 312,
                  child: TabBar(
                    indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: Color(0xFF44ACA1),
                    ),
                    controller: tabController,
                    isScrollable: true,
                    labelPadding:
                        EdgeInsets.symmetric(horizontal: 60.5, vertical: 10.5),
                    indicatorColor: Colors.transparent,
                    labelColor: Color(0xFFFFFFFF),
                    unselectedLabelColor: Color(0xFF969595),
                    tabs: [
                      Tab(
                        child: Text("Fresh",
                            style: TextStyle(
                                fontSize: 12,
                                //color: Color(0xFF4E4E4E),
                                fontFamily: 'Montserat',
                                fontWeight: FontWeight.w700)),
                      ),
                      Tab(
                        child: Text("Expired",
                            style: TextStyle(
                                fontSize: 12,
                                //color: Color(0xFF4E4E4E),
                                fontFamily: 'Montserat',
                                fontWeight: FontWeight.w700)),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        Expanded(
            child: TabBarView(
          controller: tabController,
          children: [
            ListView.builder(
              physics: BouncingScrollPhysics(),
              shrinkWrap: true,
              itemCount: 5,
              itemBuilder: (context, index) {
                return Padding(
                  padding:
                      const EdgeInsets.only(bottom: 12, left: 39, right: 39),
                  child: Container(
                      height: 87,
                      width: 312,
                      decoration: BoxDecoration(
                          color: Color(0xFFFFFFFF),
                          borderRadius: BorderRadius.circular(6),
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
                            top: 19,
                            left: 15,
                            //right: 12,
                            child: Image.asset("lib/images/avocado.png"),
                          ),
                          Positioned(
                            top: 26,
                            left: 77,
                            //right: 12,
                            child: Text(
                              this.productName,
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: 'Montserrat',
                                  color: Color(0XFF4E4E4E)),
                            ),
                          ),
                          Positioned(
                            top: 45,
                            left: 77,
                            //right: 12,
                            child: Text(
                              boughtTime,
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: 'Montserrat',
                                  color: Color(0XFFFF4121)),
                            ),
                          ),
                          Positioned(
                              top: 25,
                              right: 15,
                              //right: 12,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.all(12),
                                  fixedSize: Size(74, 37),
                                  textStyle: TextStyle(
                                      fontSize: 10,
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xFFFFFFFF)),
                                  backgroundColor:
                                      Color(0xFF44ACA1), // background color
                                  elevation: 0, // elevation of button
                                  //shadowColor: Colors.
                                ),
                                onPressed: () {},
                                child: const Text("Eaten"),
                              )),
                        ],
                      )),
                );
              },
            ),
            ListView.builder(
              physics: BouncingScrollPhysics(),
              shrinkWrap: true,
              itemCount: 5,
              itemBuilder: (context, index) {
                return Padding(
                  padding:
                      const EdgeInsets.only(bottom: 12, left: 39, right: 39),
                  child: Container(
                      height: 87,
                      width: 312,
                      decoration: BoxDecoration(
                          color: Color(0xFFFFFFFF),
                          borderRadius: BorderRadius.circular(6),
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
                            top: 19,
                            left: 15,
                            //right: 12,
                            child: Image.asset("lib/images/avocado.png"),
                          ),
                          Positioned(
                            top: 26,
                            left: 77,
                            //right: 12,
                            child: Text(
                              this.productName,
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: 'Montserrat',
                                  color: Color(0XFF4E4E4E)),
                            ),
                          ),
                          Positioned(
                            top: 45,
                            left: 77,
                            //right: 12,
                            child: Text(
                              boughtTime,
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: 'Montserrat',
                                  color: Color(0XFFFF4121)),
                            ),
                          ),
                          Positioned(
                              top: 25,
                              right: 15,
                              //right: 12,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.all(12),
                                  fixedSize: Size(74, 37),
                                  textStyle: TextStyle(
                                      fontSize: 10,
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xFFFFFFFF)),
                                  backgroundColor:
                                      Color(0xFFFF4121), // background color
                                  elevation: 0, // elevation of button
                                  //shadowColor: Colors.
                                ),
                                onPressed: () {},
                                child: const Text("Trash"),
                              )),
                        ],
                      )),
                );
              },
            )
          ],
        )),
        Text(
          'Bought Time:',
          style: TextStyle(fontSize: 25),
        ),
        SizedBox(height: 10),
        Text(
          boughtTime,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Text(
          'Expiration Time:',
          style: TextStyle(fontSize: 25),
        ),
        SizedBox(height: 10),
        Text(
          expireTime,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        ElevatedButton(
          child: const Text('Open route'),
          onPressed: () {
            onLoad();
          },
        )
      ]),
    );
  }
}

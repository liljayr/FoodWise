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
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  // runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FoodWise',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: const  Color(0xFF44ACA1)),
      ),
      // home: FutureBuilder<QuerySnapshot>(
      //   future: FirebaseFirestore.instance.collection('Food').get(),
      //   builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
      //     if (snapshot.connectionState == ConnectionState.done) {
      //       if (snapshot.hasError) {
      //         return Text('Error: ${snapshot.error}');
      //       } else {
      //         var names = snapshot.data?.docs.map((doc) => doc['name'] as String).join(', ') ?? '';
      //         final b_timestamp = snapshot.data?.docs.first['Bought'] as Timestamp;
      //         final b_date = b_timestamp.toDate(); // Convert the timestamp to a DateTime object
      //         final b_formattedDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(b_date); // Format the date as a string
      //         final e_timestamp = snapshot.data?.docs.first['Expires'] as Timestamp;
      //         final e_date = e_timestamp.toDate(); // Convert the timestamp to a DateTime object
      //         final e_formattedDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(e_date); // Format the date as a string
      //         return Home(key: ValueKey('my_home_page'), title: names, boughtTime: b_formattedDate, expireTime: e_formattedDate);
      //       }
      //     } else {
      //       return CircularProgressIndicator();
      //     }
      //   },
      // ),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key, required this.title, required this.boughtTime, required this.expireTime}) : super(key: key);

  final String boughtTime;
  final String expireTime;
  final String title;

  @override
  _HState createState() => _HState();
}

class _HState extends State<Home> {
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
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text(
              'My Items',
              style: TextStyle(fontSize: 25),
            ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Item:',
              style: TextStyle(fontSize: 25),
            ),
            SizedBox(height: 10),
            Text(
              widget.title,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              'Bought Time:',
              style: TextStyle(fontSize: 25),
            ),
            SizedBox(height: 10),
            Text(
              widget.boughtTime,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              'Expiration Time:',
              style: TextStyle(fontSize: 25),
            ),
            SizedBox(height: 10),
            Text(
              widget.expireTime,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            ElevatedButton(
              child: const Text('Open route'),
              onPressed: () {
            },
            )
          ]
          ),
        )
    );
  }
}
import 'package:flutter/material.dart';

// Import the firebase_core plugin
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
//Import firestore database
import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase_options.dart';
import 'package:meta/meta.dart';
import 'package:intl/intl.dart';

import 'pages/main_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

/*class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var names = "fail";
    names = FirebaseFirestore.instance
    .collection('users')
    .get()
    .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
            print(doc["user_name"]);
        });
    }).toString();
    return MaterialApp(
      title: names,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: names),
    );
  }
  Widget _fireSearch(){

  }*/

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My App',
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSwatch().copyWith(primary: const Color(0xFF44ACA1)),
      ),
      home: FutureBuilder<QuerySnapshot>(
        future: FirebaseFirestore.instance.collection('Food').get(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              var names = snapshot.data?.docs
                      .map((doc) => doc['name'] as String)
                      .join(', ') ??
                  '';
              final b_timestamp =
                  snapshot.data?.docs?.first['Bought'] as Timestamp;
              final b_date = b_timestamp
                  .toDate(); // Convert the timestamp to a DateTime object
              final b_formattedDate = DateFormat('yyyy-MM-dd HH:mm:ss')
                  .format(b_date); // Format the date as a string
              final e_timestamp =
                  snapshot.data?.docs?.first['Expires'] as Timestamp;
              final e_date = e_timestamp
                  .toDate(); // Convert the timestamp to a DateTime object
              final e_formattedDate = DateFormat('yyyy-MM-dd HH:mm:ss')
                  .format(e_date); // Format the date as a string
              return MyHomePage(
                  key: ValueKey('my_home_page'),
                  title: names,
                  boughtTime: b_formattedDate,
                  expireTime: e_formattedDate);
            }
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage(
      {required Key key,
      required this.title,
      required this.boughtTime,
      required this.expireTime})
      : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;
  final String boughtTime;
  final String expireTime;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // int _counter = 0;

  // void _incrementCounter() {
  //   setState(() {
  //     // This call to setState tells the Flutter framework that something has
  //     // changed in this State, which causes it to rerun the build method below
  //     // so that the display can reflect the updated values. If we changed
  //     // _counter without calling setState(), then the build method would not be
  //     // called again, and so nothing would appear to happen.
  //     _counter++;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      backgroundColor: Colors.white,
      //appBar: AppBar(
      // Here we take the value from the MyHomePage object that was created by
      // the App.build method, and use it to set our appbar title.
      //title: Text("FoodWise"),
      // ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(left: 39, top: 120),
            child: Text('What do you want to',
                style: TextStyle(
                    fontSize: 24,
                    color: Color(0xFF4E4E4E),
                    fontFamily: 'Montserat',
                    fontWeight: FontWeight.w900)),
          ),
          SizedBox(
            height: 2,
          ),
          Container(
            margin: EdgeInsets.only(left: 39),
            child: Text('track?',
                style: TextStyle(
                    fontSize: 24,
                    color: Color(0xFF4E4E4E),
                    fontFamily: 'Montserat',
                    fontWeight: FontWeight.w900)),
          ),
          SizedBox(
            height: 60.5,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 39, right: 39),
            child: Container(
              height: 78,
              width: 312,
              // color: Colors.white,
              decoration: BoxDecoration(
                  //borderRadius: BorderRadius.circular(14),
                  //color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFF929292).withOpacity(0.2),
                      blurRadius: 23,
                      spreadRadius: -4,
                      offset: Offset(0, 4.0),
                    ),
                  ]),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14), // <-- Radius
                  ),
                  //padding: EdgeInsets.all(12),

                  //fixedSize: Size(312, 54),
                  /*textStyle: TextStyle(
                                fontSize: 17,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w700,
                                color: Color(0xFFFFFFFF)),*/
                  backgroundColor: Color(0xFFFFFFFF), // background color
                  elevation: 0, // elevation of button
                  //shadowColor: Colors.
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Main(
                              pageType: "Veggie",
                            )),
                  );
                },
                child: Row(children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: Container(
                      height: 39,
                      width: 39,
                      decoration: BoxDecoration(
                        color: Color(0xFFF7B24A).withOpacity(0.2),
                        borderRadius: BorderRadius.circular(3),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(7),
                        child: Image.asset(
                          'lib/images/veg.png',
                          height: 22.86,
                          width: 24.92,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 24),
                    child: Text('Fruits & vegetables',
                        style: TextStyle(
                            fontSize: 16,
                            color: Color(0xFF4E4E4E),
                            fontFamily: 'Montserat',
                            fontWeight: FontWeight.w700)),
                  ),
                  /*RadioListTile(
                value: 2,
                groupValue: null,
                onChanged: null,
              ),*/
                ]),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 39, right: 39),
            child: Container(
              height: 78,
              width: 312,
              // color: Colors.white,
              decoration: BoxDecoration(
                  //borderRadius: BorderRadius.circular(14),
                  //color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFF929292).withOpacity(0.2),
                      blurRadius: 23,
                      spreadRadius: -4,
                      offset: Offset(0, 4.0),
                    ),
                  ]),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14), // <-- Radius
                  ),
                  //padding: EdgeInsets.all(12),

                  //fixedSize: Size(312, 54),
                  /*textStyle: TextStyle(
                                fontSize: 17,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w700,
                                color: Color(0xFFFFFFFF)),*/
                  backgroundColor: Color(0xFFFFFFFF), // background color
                  elevation: 0, // elevation of button
                  //shadowColor: Colors.
                ),
                onPressed: () {},
                child: Row(children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: Container(
                      height: 39,
                      width: 39,
                      decoration: BoxDecoration(
                        color: Color(0xFFF77F7C).withOpacity(0.2),
                        borderRadius: BorderRadius.circular(3),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(7),
                        child: Image.asset(
                          'lib/images/meat.png',
                          height: 22.86,
                          width: 24.92,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 24),
                    child: Text('Meat',
                        style: TextStyle(
                            fontSize: 16,
                            color: Color(0xFF4E4E4E),
                            fontFamily: 'Montserat',
                            fontWeight: FontWeight.w700)),
                  ),
                  /*RadioListTile(
                value: 2,
                groupValue: null,
                onChanged: null,
              ),*/
                ]),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 39, right: 39),
            child: Container(
              height: 78,
              width: 312,
              // color: Colors.white,
              decoration: BoxDecoration(
                  //borderRadius: BorderRadius.circular(14),
                  //color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFF929292).withOpacity(0.2),
                      blurRadius: 23,
                      spreadRadius: -4,
                      offset: Offset(0, 4.0),
                    ),
                  ]),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14), // <-- Radius
                  ),
                  //padding: EdgeInsets.all(12),

                  //fixedSize: Size(312, 54),
                  /*textStyle: TextStyle(
                                fontSize: 17,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w700,
                                color: Color(0xFFFFFFFF)),*/
                  backgroundColor: Color(0xFFFFFFFF), // background color
                  elevation: 0, // elevation of button
                  //shadowColor: Colors.
                ),
                onPressed: () {},
                child: Row(children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: Container(
                      height: 39,
                      width: 39,
                      decoration: BoxDecoration(
                        color: Color(0xFF6192DA).withOpacity(0.2),
                        borderRadius: BorderRadius.circular(3),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(7),
                        child: Image.asset(
                          'lib/images/diary.png',
                          height: 22.86,
                          width: 24.92,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 24),
                    child: Text('Dairy products',
                        style: TextStyle(
                            fontSize: 16,
                            color: Color(0xFF4E4E4E),
                            fontFamily: 'Montserat',
                            fontWeight: FontWeight.w700)),
                  ),
                  /*RadioListTile(
                value: 2,
                groupValue: null,
                onChanged: null,
              ),*/
                ]),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 39, right: 39),
            child: Container(
              height: 78,
              width: 312,
              // color: Colors.white,
              decoration: BoxDecoration(
                  //borderRadius: BorderRadius.circular(14),
                  //color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFF929292).withOpacity(0.2),
                      blurRadius: 23,
                      spreadRadius: -4,
                      offset: Offset(0, 4.0),
                    ),
                  ]),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14), // <-- Radius
                  ),
                  //padding: EdgeInsets.all(12),

                  //fixedSize: Size(312, 54),
                  /*textStyle: TextStyle(
                                fontSize: 17,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w700,
                                color: Color(0xFFFFFFFF)),*/
                  backgroundColor: Color(0xFFFFFFFF), // background color
                  elevation: 0, // elevation of button
                  //shadowColor: Colors.
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Main(
                              pageType: "Avocado",
                            )),
                  );
                },
                child: Row(children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: Container(
                      height: 39,
                      width: 39,
                      decoration: BoxDecoration(
                        color: Color(0xFF44ACA1).withOpacity(0.2),
                        borderRadius: BorderRadius.circular(3),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(7),
                        child: Image.asset(
                          'lib/images/avo.png',
                          height: 22.86,
                          width: 24.92,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 24),
                    child: Text('Avocado',
                        style: TextStyle(
                            fontSize: 16,
                            color: Color(0xFF4E4E4E),
                            fontFamily: 'Montserat',
                            fontWeight: FontWeight.w700)),
                  ),
                  /*RadioListTile(
                value: 2,
                groupValue: null,
                onChanged: null,
              ),*/
                ]),
              ),
            ),
          ),

          /* ElevatedButton(
            child: const Text('Avocado'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Main(
                          pageType: "Avocado",
                        )),
              );
            },
          ),
          ElevatedButton(
            child: const Text('Veggies'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Main(
                          pageType: "Veggie",
                        )),
              );
            },
          ),*/
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

// Future<Widget> _fireSearch() async {
//   var collection = FirebaseFirestore.instance.collection('users');
//   var querySnapshot = await collection.get();
//   var name = "";
//   for (var queryDocumentSnapshot in querySnapshot.docs) {
//     Map<String, dynamic> data = queryDocumentSnapshot.data();
//     name = data['user_name'];
//   }
//   print(name);
//   return Scaffold(
//   body: Center(
//         child: Column(
//   children: <Widget>[
//             Text(
//               querySnapshot as String,
//             ),
//           ],
//         )
//         ) 
//    ); // return new StreamBuilder(
//   //   stream: FirebaseFirestore.instance
//   //   .collection('users')
//   //   .where('title', isEqualTo: queryText)
//   //   .snapshots(),
//   //   builder: (context, snapshot) {
//   //     if (!snapshot.hasData) return new Text('Loading...');
//   //     return new ListView.builder(
//   //       itemCount: snapshot.data.documents.length,
//   //       itemBuilder: (context, index) =>
//   //           _buildListItem(snapshot.data.documents[index]),
//   //     );
//   //   },
//   // );
// }


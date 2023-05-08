import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class ChartData {
        ChartData(this.x, this.y, this.color);
        final String x;
        double? y;
        final Color color;
        // final double? y2;
      }

class _HomePageState extends State<HomePage> {

  // Future<void> Waste(id, productName, boughtDate, category, expirationDate, price, quantity, unit, color) async{
  //   // Add in data to wasted database
  //   var collectionWaste = FirebaseFirestore.instance.collection("AvocadoWasted");
  //   var snapshotWaste = await collectionWaste.get();
  //   var newindex = int.parse(snapshotWaste.docs.last.id) + 1;

  //   Map<String, dynamic> newData = {
  //     "name": productName,
  //     "boughtDate": boughtDate,
  //     "category": category,
  //     "expirationDate": expirationDate,
  //     "price": price,
  //     "quantity": quantity,
  //     "unit": unit,
  //     "color": color
  //   };
  //   await collectionWaste.doc('$newindex').set(newData);

  //   // Delete from food database
  //   var collectionFood = FirebaseFirestore.instance.collection("AvocadoFood").doc(id);
  //   await collectionFood.delete();
  //   print("DONE!");
  // }

  void Delete(id, productName, boughtDate, category, expirationDate, price, quantity, unit, color, newDB) async{
    // Add in data to wasted database
    var collectionWaste = FirebaseFirestore.instance.collection("$newDB");
    var snapshotWaste = await collectionWaste.get();
    var newindex = int.parse(snapshotWaste.docs.last.id) + 1;

    Map<String, dynamic> newData = {
      "name": productName,
      "boughtDate": boughtDate,
      "category": category,
      "expirationDate": expirationDate,
      "price": price,
      "quantity": quantity,
      "unit": unit,
      "color": color
    };
    await collectionWaste.doc('$newindex').set(newData);

    // Delete from food database
    var collectionFood = FirebaseFirestore.instance.collection("AvocadoFood").doc(id);
    await collectionFood.delete();
    print("DONE!");}

  @override
  Widget build(BuildContext context) {
    CollectionReference foodCollection =
        FirebaseFirestore.instance.collection('AvocadoFood');

    return Scaffold(
        /* appBar: AppBar(
          backgroundColor: Color(0xFF44ACA1),
          title: const Text('Home'),
        ),*/
        backgroundColor: Color(0xFFFFFFFF),
        body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            margin: EdgeInsets.only(left: 39, top: 38),
            child: Row(children: [
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
            child: Text('Your inventory',
                style: TextStyle(
                    fontSize: 24,
                    color: Color(0xFF4E4E4E),
                    fontFamily: 'Montserat',
                    fontWeight: FontWeight.w900)),
          ),
          SizedBox(
            height: 21,
          ),
          /*Padding(
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
          ),*/
          Container(
            child: StreamBuilder<QuerySnapshot>(
              stream: foodCollection.snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return const Text('Something went wrong');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Text('Loading...');
                }

                final data = snapshot.requireData;

                return ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: data.size,
                  itemBuilder: (BuildContext context, int index) {
                    final doc = data.docs[index];
                    final id = doc.id;
                    final name = doc['name'] as String;
                    final boughtDate = DateFormat('yyyy-MM-dd')
                        .format((doc['boughtDate'] as Timestamp).toDate());
                    final category = doc['category'] as String;
                    var today = new Timestamp.now();
                    var todayDate = DateTime.parse(today.toDate().toString());
                    var expDate = DateTime.parse(
                        (doc['expirationDate'] as Timestamp)
                            .toDate()
                            .toString());
                    final expiryDate = expDate.difference(todayDate).inDays;
                    final price = doc['price'] as int;
                    final quantity = doc['quantity'] as int;
                    final storage = doc['storage'] as String;
                    final unit = doc['unit'] as String;
                    final color = doc['color'] as String;

                    String imageAssetPath;
                    if (name == 'Mushrooms') {
                      imageAssetPath = 'lib/images/mushroom.png';
                    } else if (name == 'Mushroom') {
                      imageAssetPath = 'lib/images/mushroom.png';
                    } else if (name == 'Avocado') {
                      imageAssetPath = 'lib/images/avocado.png';
                    } else if (name == 'Grapes') {
                      imageAssetPath = 'lib/images/grapes.png';
                    } else {
                      imageAssetPath = 'lib/images/avocado.png';
                    }

                    return Padding(
                      padding: const EdgeInsets.only(
                          left: 39, right: 39, bottom: 21),
                      child: Container(
                        height: 87,
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
                          elevation: 0, // add a box shadow
                          child: Container(
                            //padding: EdgeInsets.all(16), // add some padding
                            child: Stack(
                              children: [
                                Positioned(
                                  top: 19,
                                  left: 15,
                                  child: Image.asset(
                                    imageAssetPath,
                                    width: 49,
                                    height: 49,
                                  ),
                                ),
                                //SizedBox(width: 16), // add some spacing
                                Positioned(
                                  top: 14,
                                  left: 77,
                                  child: Text(
                                    '$name ($quantity $unit)',
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700,
                                        fontFamily: 'Montserrat',
                                        color: Color(0XFF4E4E4E)),
                                  ),
                                ),
                                Positioned(
                                  top: 36,
                                  left: 77,
                                  child: Text(
                                    '$storage',
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700,
                                        fontFamily: 'Montserrat',
                                        color: Color(0XFF4E4E4E)),
                                  ),
                                ),
                                Positioned(
                                  top: 53,
                                  left: 77,
                                  child: Text(
                                    'Expires: $expiryDate day(s)',
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700,
                                        fontFamily: 'Montserrat',
                                        color: Color(0XFFFF4121)),
                                  ),
                                ),
                                Positioned(
                                    top: 27,
                                    left: 216,
                                    //right: 12,
                                    child: Container(
                                      height: 33,
                                      width: 33,
                                      child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            padding: EdgeInsets.all(9.5),
                                            fixedSize: Size(33, 33),
                                            /*textStyle: TextStyle(
                                              fontSize: 10,
                                              fontFamily: 'Montserrat',
                                              fontWeight: FontWeight.w700,
                                              color: Color(0xFFFFFFFF)),*/
                                            backgroundColor: Color(
                                                0xFF44ACA1), // background color
                                            elevation: 0, // elevation of button
                                            //shadowColor: Colors.
                                          ),
                                          onPressed: () {
                                            Delete(id, name, boughtDate, category, expDate, price, quantity, unit, color, "AvocadoEaten");
                                          },
                                          child: Image.asset(
                                              'lib/images/check2.png',
                                              height: 14,
                                              width: 14)
                                          // label: Text("Elevated Button with Icon") ,
                                          //child: const Text("Eaten"),
                                          ),
                                    )),
                                Positioned(
                                    top: 27,
                                    left: 264,
                                    //right: 12,
                                    child: Container(
                                      height: 33,
                                      width: 33,
                                      child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            padding: EdgeInsets.all(10.5),
                                            fixedSize: Size(33, 33),
                                            /*textStyle: TextStyle(
                                              fontSize: 10,
                                              fontFamily: 'Montserrat',
                                              fontWeight: FontWeight.w700,
                                              color: Color(0xFFFFFFFF)),*/
                                            backgroundColor: Color(
                                                0xFFFF4121), // background color
                                            elevation: 0, // elevation of button
                                            //shadowColor: Colors.
                                          ),
                                          onPressed: () {
                                            Delete(id, name, boughtDate, category, expDate, price, quantity, unit, color, "AvocadoWasted");
                                          },
                                          child: Image.asset(
                                              'lib/images/cross.png',
                                              height: 11,
                                              width: 12)
                                          // label: Text("Elevated Button with Icon") ,
                                          //child: const Text("Eaten"),
                                          ),
                                    )),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          )
        ])));
  }
}




/*class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    CollectionReference foodCollection =
        FirebaseFirestore.instance.collection('AvocadoFood');

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF44ACA1),
        title: const Text('Home'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: foodCollection.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text('Loading...');
          }

          final data = snapshot.requireData;

          return ListView.builder(
            itemCount: data.size,
            itemBuilder: (BuildContext context, int index) {
              final doc = data.docs[index];
              final name = doc['name'] as String;
              final boughtDate = DateFormat('yyyy-MM-dd').format((doc['boughtDate'] as Timestamp).toDate());
              final expiryDate = DateFormat('yyyy-MM-dd').format((doc['expirationDate'] as Timestamp).toDate());

              return ListTile(
                title: Text(name),
                subtitle: Text('Bought Date: $boughtDate\nExpiry Date: $expiryDate'),
              );
            },
          );
        },
      ),
    );
  }
}*/

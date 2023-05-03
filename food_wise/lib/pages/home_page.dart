import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
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
              final quantity = doc['quantity'] as int;
              final storage = doc['storage'] as String;

              String imageAssetPath;
              if (name == 'mushrooms') {
                imageAssetPath = 'lib/images/mushroom.png';
              } else if (name == 'avocado') {
                imageAssetPath = 'lib/images/avocado.png';
              } else if (name == 'grapes') {
                imageAssetPath = 'lib/images/grapes.png';
              } else {
                imageAssetPath = 'lib/images/avocado.png';
              }

              return Card(
                elevation: 4, // add a box shadow
                child: Container(
                  padding: EdgeInsets.all(16), // add some padding
                  child: Row(
                    children: [
                      Image.asset(
                        imageAssetPath,
                        width: 64,
                        height: 64,
                      ),
                      SizedBox(width: 16), // add some spacing
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('$name ($quantity)'),
                          SizedBox(height: 8), // add some spacing
                          Text('Storage place: $storage'),
                          Text('Bought: $boughtDate'),
                          Text('Expires: $expiryDate'),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
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

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
}

import 'package:flutter/material.dart';

// Import the firebase_core plugin
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
//Import firestore database
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_wise/pages/chart_page.dart';
import 'package:food_wise/pages/home_page.dart';
import 'package:food_wise/pages/profile_page.dart';
import 'package:food_wise/pages/recipes_page.dart';
import '../firebase_options.dart';
import 'package:meta/meta.dart';
import 'package:intl/intl.dart';

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
//   runApp(Main());
// }


class Main extends StatefulWidget {
  const Main({Key? key}) : super(key: key);
  
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<Main> {
  var productName = "";
  List pages = [
    Home(productName: "aaaa",),
    Chart(),
    Recipes(),
    Profile()
  ];
  int currentIndex = 0;

  Future<String> onLoad() async {
    // var productName = "";
    var collection = FirebaseFirestore.instance.collection('Food');
    var snapshot1 = collection.snapshots();
    var snapshot = await collection.get();
    print("BBBBBBB");
    print(snapshot.docs.first.data());
    print(snapshot.docs[0]);
    productName = snapshot.docs.first.data()['name'] as String;
    print(productName);
    return productName;
  }

  void onTap(int index) {
    setState(() {
      currentIndex = index;
      this.onLoad();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      floatingActionButton: Container(
        decoration: const BoxDecoration(shape: BoxShape.circle, boxShadow: [
          BoxShadow(color: Colors.white, spreadRadius: 7, blurRadius: 1)
        ]),
        child: FloatingActionButton(
          onPressed: () {},
          child: const Icon(Icons.qr_code_2_rounded),
          backgroundColor: Colors.green,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        unselectedFontSize: 0,
        selectedFontSize: 0,
        onTap: onTap,
        currentIndex: currentIndex,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.lightGreen.withOpacity(0.5),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart_rounded), label: "Charts"),
          BottomNavigationBarItem(icon: Icon(Icons.food_bank_rounded), label: "Recipes"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile")
        ]
        ),
    );
  }
}

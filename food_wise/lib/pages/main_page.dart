import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../firebase_options.dart';
import 'chart_page.dart';
import 'home_page.dart';
import 'profile_page.dart';
import 'recipe_page.dart';

late String _pageType = "";

class Main extends StatefulWidget {
  const Main({Key? key, required this.pageType}) : super(key: key);

  final String pageType;
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<Main> {
    @override
  void initState() {
    _pageType = widget.pageType;
    print("PLEASE WORK PLEEEAAASSEEE");
    print(_pageType);
    super.initState();
  }

  var productName = "";
  List pages = [
    HomePage(),
    Charts(pageType: _pageType),
    Recipes(),
    Profile(),
  ];

  int currentIndex = 0;

  void onTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      floatingActionButton: Container(
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(color: Colors.white, spreadRadius: 7, blurRadius: 1)
          ],
        ),
        child: FloatingActionButton(
          onPressed: () {},
          child: const Icon(Icons.qr_code_2_rounded),
          backgroundColor: Color(0xFF44ACA1),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        unselectedFontSize: 0,
        selectedFontSize: 0,
        onTap: onTap,
        currentIndex: currentIndex,
        selectedItemColor: Color(0xFF44ACA1),
        //unselectedItemColor: Colors.lightGreen.withOpacity(0.5),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.bar_chart_rounded), label: "Charts"),
          BottomNavigationBarItem(
              icon: Icon(Icons.food_bank_rounded), label: "Recipes"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile")
        ],
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:food_wise/pages/add_item_page.dart';
import '../firebase_options.dart';
import 'chart_page.dart';
import 'home_page.dart';
import 'news_page.dart';
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
    NewsScreen(),
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
        height: 63,
        width: 63,
        //padding: EdgeInsets.fromLTRB(163.5, 0, 163.5, 25),
        decoration: const BoxDecoration(shape: BoxShape.circle, boxShadow: [
          BoxShadow(
              color: Color(0xFFD3D3D3),
              spreadRadius: 0,
              blurRadius: 36,
              offset: const Offset(0, 4))
        ]),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddItem()),
            );
          },
          child: Image.asset('lib/icons/plus.png',
              height: 27, width: 27, color: Colors.white),
          backgroundColor: Color(0xFF44ACA1),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Container(
        height: 75,
        width: 390,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(17), topRight: Radius.circular(17)),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Color(0xFF737373).withOpacity(0.1),
                blurRadius: 61,
                spreadRadius: -2,
                offset: Offset(0, -7),
              )
            ]),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          unselectedFontSize: 0,
          selectedFontSize: 0,
          onTap: onTap,
          currentIndex: currentIndex,
          selectedItemColor: Color(0xFF44ACA1),
          unselectedItemColor: Color(0xFFCBCBCB),
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: [
            BottomNavigationBarItem(
                icon: Image.asset('lib/icons/home.png', height: 24, width: 28),
                label: "Home"),
            BottomNavigationBarItem(
                icon: Image.asset('lib/icons/stats.png',
                    height: 26.2, width: 17.3),
                label: "Charts"),
            BottomNavigationBarItem(
                icon: Image.asset('lib/icons/recipes.png', height: 25, width: 27),
                label: "Recipes"),
            BottomNavigationBarItem(
                icon: Image.asset('lib/icons/insights.png',
                    height: 25, width: 16.42),
                label: "Profile")
          ],
        ),
      ),
    );
  }
}
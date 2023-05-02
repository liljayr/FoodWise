import 'package:flutter/material.dart';

// Import the firebase_core plugin
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
//Import firestore database
import 'package:cloud_firestore/cloud_firestore.dart';
import '../firebase_options.dart';
import 'package:meta/meta.dart';
import 'package:intl/intl.dart';

class Profile extends StatelessWidget {
  final List articles = [
    {
      "image": "lib/images/article1.png",
      "name": "How to organize your storage"
    },
    {"image": "lib/images/article2.png", "name": "Wasting less, saving more"},
    {"image": "lib/images/article3.png", "name": "Finding better alternatives"},
  ];

  final List alternatives = [
    {
      "image": "lib/images/chia.png",
      "name": "Chia seeds",
      "subtitle": "High in protein and rich in fibre"
    },
    /*{
      "image": "lib/images/nuts.png",
      "name": "Tree nuts",
      "subtitle": "Dietary fiber, protein and fatty acids"
    },*/
  ];

  //const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
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
              child: Text('For you!',
                  style: TextStyle(
                      fontSize: 24,
                      color: Color(0xFF4E4E4E),
                      fontFamily: 'Montserat',
                      fontWeight: FontWeight.w900)),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 39, top: 21),
              child: Container(
                height: 126,
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
                    top: 19,
                    left: 20,
                    child: Text(
                      "You are wasting 25%",
                      style: TextStyle(
                          fontSize: 12.8,
                          color: Color(0xFF44ACA1),
                          fontFamily: 'Montserat',
                          fontWeight: FontWeight.w800),
                    ),
                  ),
                  Positioned(
                    top: 35,
                    left: 22,
                    child: Text(
                      "of your food!",
                      style: TextStyle(
                          fontSize: 12.8,
                          color: Color(0xFF44ACA1),
                          fontFamily: 'Montserat',
                          fontWeight: FontWeight.w800),
                    ),
                  ),
                  Positioned(
                    top: 57,
                    left: 22,
                    child: Text(
                      "Here is the article that tells you",
                      style: TextStyle(
                          fontSize: 10,
                          color: Color(0xFF4E4E4E),
                          fontFamily: 'Montserat',
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  Positioned(
                    top: 69,
                    left: 22,
                    child: Text(
                      "how to stop it",
                      style: TextStyle(
                          fontSize: 10,
                          color: Color(0xFF4E4E4E),
                          fontFamily: 'Montserat',
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  Positioned(
                      top: 92,
                      left: 22,
                      child: Container(
                        height: 23,
                        width: 85,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
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
                            "Read more",
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
                    top: 23,
                    right: 20,
                    child: Image.asset(
                      "lib/images/shopping.png",
                      height: 80,
                      width: 96,
                    ),
                  ),
                  Positioned(
                    top: 12,
                    right: 12,
                    child: Image.asset("lib/images/close.png"),
                  ),
                ]),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 39, top: 30),
              child: Text('Articles you may find helpful',
                  style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF4E4E4E),
                      fontFamily: 'Montserat',
                      fontWeight: FontWeight.w700)),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 39),
              child: Container(
                height: 200,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: articles.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 21),
                      child: Container(
                        height: 177,
                        width: 132,
                        margin: EdgeInsets.only(right: 12),
                        decoration: BoxDecoration(
                            //borderRadius: BorderRadius.circular(11),
                            ),
                        child: Stack(
                          children: [
                            Positioned(
                              child: Image.asset(articles[index]["image"],
                                  height: 143, width: 132),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 145),
                              child: Positioned(
                                height: 145,
                                child: Flexible(
                                    child: Text(articles[index]["name"],
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: Color(0xFF4E4E4E),
                                            fontFamily: 'Montserat',
                                            fontWeight: FontWeight.w700))),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 166),
                              child: Positioned(
                                height: 166,
                                child: Flexible(
                                    child: Text("4 minutes read",
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 11,
                                            color: Color(0xFFACACAC),
                                            fontFamily: 'Montserat',
                                            fontWeight: FontWeight.w500))),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            //SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.only(left: 39, top: 30),
              child: Text('Sustainable substitutes',
                  style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF4E4E4E),
                      fontFamily: 'Montserat',
                      fontWeight: FontWeight.w700)),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 39, right: 39),
              child: Container(
                //height: 79,
                child: Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: alternatives.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 21, bottom: 21),
                        child: Container(
                          height: 79,
                          width: 312,
                          //margin: EdgeInsets.only(bottom: 12),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(11),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0xFF929292).withOpacity(0.2),
                                  blurRadius: 23,
                                  spreadRadius: -4,
                                  offset: Offset(0, 4.0),
                                )
                              ]),
                          child: Stack(
                            children: [
                              Positioned(
                                top: 12,
                                left: 12,
                                child: Image.asset(alternatives[index]["image"],
                                    height: 55, width: 58),
                              ),
                              Positioned(
                                top: 16,
                                left: 82,
                                child: Text("Instead of avocado",
                                    style: TextStyle(
                                        fontSize: 10,
                                        color: Color(0xFF44ACA1),
                                        fontFamily: 'Montserat',
                                        fontWeight: FontWeight.w500)),
                              ),
                              Positioned(
                                top: 30,
                                left: 82,
                                child: Text(alternatives[index]["name"],
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Color(0xFF4E4E4E),
                                        fontFamily: 'Montserat',
                                        fontWeight: FontWeight.w700)),
                              ),
                              Positioned(
                                top: 53,
                                left: 82,
                                child: Text(alternatives[index]["subtitle"],
                                    style: TextStyle(
                                        fontSize: 10,
                                        color: Color(0xFFACACAC),
                                        fontFamily: 'Montserat',
                                        fontWeight: FontWeight.w500)),
                              ),

                              /*Padding(
                                padding: const EdgeInsets.only(top: 145),
                                child: Positioned(
                                  height: 145,
                                  child: Flexible(
                                      child: Text(articles[index]["name"],
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Color(0xFF4E4E4E),
                                              fontFamily: 'Montserat',
                                              fontWeight: FontWeight.w700))),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 166),
                                child: Positioned(
                                  height: 166,
                                  child: Flexible(
                                      child: Text("4 minutes read",
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontSize: 11,
                                              color: Color(0xFFACACAC),
                                              fontFamily: 'Montserat',
                                              fontWeight: FontWeight.w500))),
                                ),
                              ),*/
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ]),
    );
  }
}

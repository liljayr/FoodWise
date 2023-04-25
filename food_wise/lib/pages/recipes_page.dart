import 'package:flutter/material.dart';
//import 'package:gabip1_s_application/core/app_export.dart';

// Import the firebase_core plugin
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
//Import firestore database
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_wise/pages/recipe_list.dart';
import '../firebase_options.dart';
import 'package:meta/meta.dart';
import 'package:intl/intl.dart';

class Recipes extends StatelessWidget {
  //const Recipes({Key? key}) : super(key: key);
  /*final List recipes = [
    'Avocado salad',
    'Avocado toast',
    'Stuffed avocado',
    'Guacamole',
    'Avocado salad 2',
    'Avocado salad 3'
  ];*/

  final List recipes2 = [
    {"image": "lib/images/avocadoSalad.png", "name": "Avocado salad"},
    {"image": "lib/images/avocadoToast.png", "name": "Avocado toast"},
    {"image": "lib/images/stuffedAvocado.png", "name": "Stuffed avocado"},
    {"image": "lib/images/guacamole.png", "name": "Guacamole"},
    {"image": "lib/images/avocadoSalad.png", "name": "Avocado salad 2"},
    {"image": "lib/images/avocadoSalad.png", "name": "Avocado salad 3"},
  ];

  /* var widgets = [
    ListTile(
      leading: Image.asset('lib/images/avocadoSalad.png', fit: BoxFit.contain),
      title: Text('Avocado Salad'),
      subtitle: Text('You have 1/4 ingredients'),
      trailing: Text('like'),
    ),
  ];
  */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(left: 39, top: 38),
              child: Row(
                  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
              child: Text('Find recipes',
                  style: TextStyle(
                      fontSize: 24,
                      color: Color(0xFF4E4E4E),
                      fontFamily: 'Montserat',
                      fontWeight: FontWeight.w900)),
            ),
            /* Container(
              height: 42,
              width: 262,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFF929292).withOpacity(0.2),
                      blurRadius: 23,
                      spreadRadius: -4,
                      offset: Offset(0, 4.0),
                    ),
                  ]),
              child: TextField(
                cursorColor: Color(0xFFC7C7C7),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Icon(
                      Icons.search,
                      color: Color(0xFFC7C7C7),
                      size: 21,
                    ),
                    hintText: "Search for a recipe",
                    hintStyle: TextStyle(
                        color: Color(0xFFC7C7C7),
                        fontSize: 13,
                        fontFamily: 'Montserat',
                        fontWeight: FontWeight.w500)),
              ),
            ),*/
            Padding(
              padding:
                  EdgeInsets.only(left: 39.0, top: 21, right: 0, bottom: 21),
              child: Row(
                children: [
                  Container(
                    height: 42,
                    width: 262,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xFF929292).withOpacity(0.2),
                            blurRadius: 23,
                            spreadRadius: -4,
                            offset: Offset(0, 4.0),
                          ),
                        ]),
                    child: Row(children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 19, right: 9),
                        child: Image.asset('lib/icons/search.png'),
                      ),
                      Text("Search for a recipe",
                          style: TextStyle(
                              fontSize: 13,
                              color: Color(0xFFC7C7C7),
                              fontFamily: 'Montserat',
                              fontWeight: FontWeight.w300))
                    ]),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 8),
                    height: 42,
                    width: 42,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xFF929292).withOpacity(0.2),
                            blurRadius: 23,
                            spreadRadius: -4,
                            offset: Offset(0, 4.0),
                          )
                        ]),
                    child: Image.asset(
                      'lib/icons/filter.png',
                      height: 20.46,
                      width: 16,
                      //fit: BoxFit.contain,
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                  padding:
                      EdgeInsets.only(left: 0, top: 0, right: 0, bottom: 21.0),
                  itemCount: recipes2.length,
                  itemBuilder: (context, index) {
                    return Padding(
                        padding: const EdgeInsets.only(
                            left: 39, top: 0, right: 39, bottom: 21),
                        //padding: const EdgeInsets.symmetric(vertical: 21),
                        child: Container(
                            //padding: EdgeInsets.only(
                            //left: 119.0, top: 17.0, right: 86.0, bottom: 80.0),
                            height: 114,
                            width: 312,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0xFF929292).withOpacity(0.2),
                                    blurRadius: 23,
                                    spreadRadius: -4,
                                    offset: Offset(0, 4.0),
                                  )
                                ]),
                            //child: Image.asset('lib/images/avocadoSalad')
                            child: Stack(children: [
                              //Image.asset('lib/icons/heart.png'),
                              /*Image.asset(
                'lib/images/avocadoSalad',
                height: 9,
                width: 9.5,
              ),*/
                              Positioned(
                                top: 12,
                                left: 12,
                                //right: 12,
                                child: Image.asset(recipes2[index]["image"]),
                              ),
                              Positioned(
                                top: 22,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 119),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        recipes2[index]["name"],
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontFamily: 'Montserat',
                                            fontWeight: FontWeight.w700,
                                            color: Color(0xFF4E4E4E)),
                                        //Image.asset('lib/images/avocadoSalad.png')),
                                      ),
                                      SizedBox(
                                        height: 6,
                                      ),
                                      Text('You have 1/4 ingredients',
                                          style: TextStyle(
                                              fontSize: 11,
                                              fontFamily: 'Montserat',
                                              fontWeight: FontWeight.w600,
                                              color: Color(0xFF44ACA1))),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Row(children: [
                                        Icon(
                                          Icons.access_time,
                                          color: Color(0xFFACACAC),
                                          size: 14,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text('10 min',
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontFamily: 'Montserat',
                                                fontWeight: FontWeight.w500,
                                                color: Color(0xFFACACAC))),
                                        SizedBox(
                                          width: 16,
                                        ),
                                        Image.asset(
                                          'lib/images/weight.png',
                                          height: 12,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text('350 kcal',
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontFamily: 'Montserat',
                                                fontWeight: FontWeight.w500,
                                                color: Color(0xFFACACAC))),
                                      ])
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 15,
                                right: 15,
                                child: Image.asset('lib/icons/heart.png'),
                              ),
                              //child: Text(child, style: TextStyle(fontSize: 14))),
                            ])));
                  }),
            ),
          ],
        ));
  }

/*
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      //onTap: onPressed,
      child: Container(
        width: 312,
        height: 114,
        padding:
            //const EdgeInsets.only(left: 39, top: 50, right: 39, bottom: 233),
            const EdgeInsets.all(39),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
                offset: const Offset(0, 4),
                blurRadius: 23,
                spreadRadius: -4,
                color: Color(0xFF929292).withOpacity(.08)),
          ],
        ),
        child: Row(
          children: [
            Image.asset('lib/icons/plus.png',
                height: 27, width: 27, color: Colors.black),
            const SizedBox(
              width: 15,
            ),
            Text("Avocado toast",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                )),
            const Spacer(),
            Text(
              "1/6",
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.normal,
                  fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
  */
}

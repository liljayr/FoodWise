import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

// Import the firebase_core plugin
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
//Import firestore database
import 'package:cloud_firestore/cloud_firestore.dart';
import '../firebase_options.dart';
import 'package:meta/meta.dart';
import 'package:intl/intl.dart';

class Add extends StatelessWidget {
  const Add({Key? key}) : super(key: key);

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
            child: Text('Add product',
                style: TextStyle(
                    fontSize: 24,
                    color: Color(0xFF4E4E4E),
                    fontFamily: 'Montserat',
                    fontWeight: FontWeight.w900)),
          ),
        ],
      ),
    );
  }
}

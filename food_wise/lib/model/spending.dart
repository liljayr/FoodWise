import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';

class Spending {
  final int waste;
  final int price;
  final Timestamp date;
  final Color colorP;
  final Color colorW;

  Spending(this.waste, this.price, this.date, this.colorP, this.colorW);

  Spending.fromMap(Map<String, dynamic> map, param1)
      : assert(map['waste'] != null),
        assert(map['price'] != null),
        assert(map['date'] != null),
        assert(map['colorP'] != null),
        assert(map['colorW'] != null),
        waste = map['waste'],
        price = map['price'],
        date = map['date'],
        colorP = map['colorP'],
        colorW = map['colorW'];
}
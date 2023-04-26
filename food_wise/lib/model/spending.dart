import 'package:cloud_firestore/cloud_firestore.dart';

class Spending {
  final int price;
  final Timestamp date;

  Spending(this.price, this.date);

  Spending.fromMap(Map<String, dynamic> map, param1)
      : assert(map['price'] != null),
        assert(map['date'] != null),
        price = map['price'],
        date = map['date'];
}
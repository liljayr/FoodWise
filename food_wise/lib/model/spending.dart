import 'package:cloud_firestore/cloud_firestore.dart';

class Spending {
  final int price;
  final Timestamp date;

  Spending(this.price, this.date);
}
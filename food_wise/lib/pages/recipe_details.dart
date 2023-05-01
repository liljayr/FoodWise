import 'package:flutter/material.dart';

class DetailsScreen extends StatefulWidget {
  DetailsScreen();

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: GestureDetector(
        onTap: () => Navigator.of(context).pop(),
        child: Container(
            height: 37,
            width: 37,
            //margin: EdgeInsets.only(left: 39, top: 53),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: Colors.white.withOpacity(0.7)),
            child: Icon(
              Icons.arrow_back,
              color: Color(0xFF4E4E4E),
              size: 24,
            )),
      ),
    );
  }
}

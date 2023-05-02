import 'package:flutter/material.dart';

class RecipeList extends StatelessWidget {
  final String child;

  RecipeList({required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 39, top: 0, right: 39, bottom: 21),
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
                child: Image.asset("h"),
              ),
              Positioned(
                top: 22,
                child: Padding(
                  padding: const EdgeInsets.only(left: 119),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        child,
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
  }
}

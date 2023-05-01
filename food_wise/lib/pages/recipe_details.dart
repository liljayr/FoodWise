import 'package:flutter/material.dart';

class DetailsScreen extends StatefulWidget {
  DetailsScreen();

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(length: 2, vsync: this);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              SizedBox(
                width: double.infinity,
                child: Image.asset('lib/images/avocadoToast2.png'),
              ),
              buttonArrow(context),
            ],
          ),
          Stack(
            children: [
              Positioned(
                child: Padding(
                  padding: const EdgeInsets.only(top: 36, left: 39),
                  child: Text(
                    "Avocado toast",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 22,
                        fontFamily: 'Montserat',
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF4E4E4E)),
                    //Image.asset('lib/images/avocadoSalad.png')),
                  ),
                ),
              ),
              Positioned(
                child: Padding(
                  padding: const EdgeInsets.only(top: 70, left: 39),
                  child: Text(
                    "You have 1/8 ingredients",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 15,
                        fontFamily: 'Montserat',
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF44ACA1)),
                    //Image.asset('lib/images/avocadoSalad.png')),
                  ),
                ),
              ),
              Positioned(
                  child: Padding(
                padding: const EdgeInsets.only(top: 94, left: 39, bottom: 29),
                child: Row(children: [
                  Icon(
                    Icons.access_time,
                    color: Color(0xFFACACAC),
                    size: 15.56,
                  ),
                  SizedBox(
                    width: 6.67,
                  ),
                  Text('10 min',
                      style: TextStyle(
                          fontSize: 15,
                          fontFamily: 'Montserat',
                          fontWeight: FontWeight.w500,
                          color: Color(0xFFACACAC))),
                  SizedBox(
                    width: 26,
                  ),
                  Image.asset(
                    'lib/images/weight.png',
                    height: 18.67,
                  ),
                  SizedBox(
                    width: 9,
                  ),
                  Text('350 kcal',
                      style: TextStyle(
                          fontSize: 15,
                          fontFamily: 'Montserat',
                          fontWeight: FontWeight.w500,
                          color: Color(0xFFACACAC))),
                ]),
              )),
              Positioned(
                top: 35,
                right: 39,
                child: Image.asset('lib/icons/heart.png',
                    height: 30, width: 30, color: Color(0xFF4E4E4E)),
              )
            ],
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 21),
              child: Container(
                height: 42,
                width: 312,
                decoration: BoxDecoration(
                    color: Color(0xFFFFFFFF),
                    borderRadius: BorderRadius.circular(6),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xFF828282).withOpacity(0.2),
                        blurRadius: 23,
                        spreadRadius: -4,
                        offset: Offset(0, 4.0),
                      ),
                    ]),
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6)),
                  elevation: 0,
                  child: Container(
                    height: 42,
                    width: 312,
                    child: TabBar(
                      indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: Color(0xFF44ACA1),
                      ),
                      controller: tabController,
                      isScrollable: true,
                      labelPadding:
                          EdgeInsets.symmetric(horizontal: 39, vertical: 8.5),
                      indicatorColor: Colors.transparent,
                      labelColor: Color(0xFFFFFFFF),
                      unselectedLabelColor: Color(0xFF969595),
                      tabs: [
                        Tab(
                          child: Text("Ingredients",
                              style: TextStyle(
                                  fontSize: 12,
                                  //color: Color(0xFF4E4E4E),
                                  fontFamily: 'Montserat',
                                  fontWeight: FontWeight.w700)),
                        ),
                        Tab(
                          child: Text("How to prepare",
                              style: TextStyle(
                                  fontSize: 12,
                                  //color: Color(0xFF4E4E4E),
                                  fontFamily: 'Montserat',
                                  fontWeight: FontWeight.w700)),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
              child: TabBarView(
            controller: tabController,
            children: [
              ListView.builder(
                physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: 1,
                itemBuilder: (context, index) {
                  return Padding(
                    padding:
                        const EdgeInsets.only(bottom: 12, left: 39, right: 39),
                    child: Text("1 mashed avocado"),
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.only(left: 39, right: 39, bottom: 6),
                child: Text("Recipe instructions"),
              ),
            ],
          )),
        ],
      ),
    );
  }

  buttonArrow(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 38, left: 39),
      child: InkWell(
        onTap: () => Navigator.of(context).pop(),
        child: Container(
          height: 37,
          width: 37,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6), color: Color(0xFFFFFFFF)),
          child: Image.asset(
            'lib/images/back.png',
            height: 12.14,
            width: 17,
          ),
        ),
      ),
    );
  }
}

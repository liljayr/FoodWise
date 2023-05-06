import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

// Import the firebase_core plugin
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
//Import firestore database
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import '../firebase_options.dart';
import 'package:meta/meta.dart';
import 'package:intl/intl.dart';

// class AddItem extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'FoodWise',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSwatch().copyWith(
//           primary: const  Color(0xFF44ACA1)),
//       ),
//     );
//   }
// }

class AddItem extends StatefulWidget {
  const AddItem({Key? key}) : super(key: key);

  @override
  _AddItemState createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  var productName = "";
  var quantity = 0;
  var price = 0;
  var color = "";
  Timestamp expirationDate = new Timestamp.now();
  Timestamp boughtDate = new Timestamp.now();
  // var expirationDate = "";

  List<String> searchTerms = [
    "Apple",
    "Banana",
    "Mango",
    "Pear",
    "Watermelons",
    "Blueberries",
    "Pineapples",
    "Strawberries"
  ];

  List<String> units = [
    "items",
    "kg",
    "lbs",
  ];
  String unitSelection = "items";

  bool fridgeCheckbox = false;
  bool freezeCheckbox = false;
  bool pantryCheckbox = false;

  bool fruitVeggieCheckbox = false;
  bool meatCheckbox = false;
  bool dairyCheckbox = false;

  @override
  void initState() {
    dateinput.text = ""; //set the initial value of text field

    super.initState();
    onLoad();
  }

  Future<void> onLoad() async {
    var collection = FirebaseFirestore.instance.collection('Food');
    var snapshot1 = collection.snapshots();
    var snapshot = await collection.get();
    print("AAAAAAAA");
    print(snapshot.docs.first.data());
    print(snapshot.docs[0]);
    var data = snapshot.docs.first.data();
    if (data != null && data['name'] != null) {
      setState(() {
        this.productName = data['name'] as String;
      });
    }
  }

  String catPicker() {
    if (fruitVeggieCheckbox) {
      color = "0xFF1BA209";
      return "Fruit/Veggie";
    } else if (meatCheckbox) {
      color = "0xFF832205";
      return "Meat";
    } else if (dairyCheckbox) {
      color = "0xFF0B75D8";
      return "Dairy";
    } else {
      return "No Category";
    }
  }

  String storagePicker() {
    if (fridgeCheckbox) {
      return "Fridge";
    } else if (pantryCheckbox) {
      return "Pantry";
    } else if (freezeCheckbox) {
      return "Freezer";
    } else {
      return "No Storage";
    }
  }

  Future<void> addToDB() async {
    Map<String, dynamic> newData = {
      "name": productName,
      "boughtDate": boughtDate,
      "category": catPicker(),
      "storage": storagePicker(),
      "expirationDate": expirationDate,
      "price": price,
      "quantity": quantity,
      "unit": unitSelection,
      "color": color
    };
    var collection = FirebaseFirestore.instance.collection('AvocadoFood');
    var snapshot = await collection.get();
    var index = int.parse(snapshot.docs.last.id) + 1;
    // var index = collection.orderBy("createdAt", descending: true).limit(1);
    print("IS this the right index for adding");
    print(index);

    var ref = FirebaseFirestore.instance.collection("AvocadoFood");

    await ref.doc('$index').set(newData);
    print("added");
  }

  TextEditingController dateinput = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // var query = "";
    // List<String> matchQuery = [];
    // for (var fruit in searchTerms) {
    //   if (fruit.toLowerCase().contains(query.toLowerCase())) {
    //     matchQuery.add(fruit);
    //   }
    // }
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            'Add Product',
            style: TextStyle(fontSize: 25),
          ),
        ),
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
            Center(
                child: Form(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 21, left: 39, bottom: 6),
                      child: Text("Product",
                          style: TextStyle(
                              fontSize: 12,
                              color: Color(0xFF343434),
                              fontFamily: 'Montserat',
                              fontWeight: FontWeight.w500)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 39, right: 39),
                      child: Container(
                        height: 40,
                        width: 312,
                        child: TextFormField(
                          textAlign: TextAlign.left,
                          // initialValue: "Enter or select a product",
                          decoration: new InputDecoration(
                              hintText: 'Enter a name of product',
                              contentPadding: EdgeInsets.all(12.0),
                              hintStyle: TextStyle(
                                  fontSize: 12,
                                  color: Color(0xFFA9A9A9),
                                  fontFamily: 'Montserat',
                                  fontWeight: FontWeight.w500),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      width: 1, color: Color(0xFFDEDEDE)),
                                  borderRadius: BorderRadius.circular(9)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    width: 2,
                                    color: Color(0xFF44ACA1),
                                  ),
                                  borderRadius: BorderRadius.circular(9))

                              //enabled: OutlineInputBorder(borderSide: BorderSide(width: 312, color: Color(0xFFA9A9A9))),
                              ),
                          // The validator receives the text that the user has entered.
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            productName = value;
                            print("This is the value");
                            print(productName);
                          },
                        ),
                      ),
                    ),
                    // ListView.builder(
                    //   itemCount: searchTerms.length,
                    //   itemBuilder: (context, index) {
                    //     var result = searchTerms[index];
                    //     return ListTile(
                    //       title: Text(result),
                    //     );
                    //   },
                    // ),
                    Row(
                      children: [
                        Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 18, left: 39, bottom: 6),
                              child: Text("Quantity",
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Color(0xFF343434),
                                      fontFamily: 'Montserat',
                                      fontWeight: FontWeight.w500)),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 39),
                              child: Container(
                                height: 40,
                                width: 312,
                                child: TextFormField(
                                  textAlign: TextAlign.left,
                                  // initialValue: "Enter quantity",
                                  decoration: new InputDecoration(
                                      hintText: 'Enter quantity',
                                      contentPadding: EdgeInsets.all(12.0),
                                      hintStyle: TextStyle(
                                          fontSize: 12,
                                          color: Color(0xFFA9A9A9),
                                          fontFamily: 'Montserat',
                                          fontWeight: FontWeight.w500),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              width: 1,
                                              color: Color(0xFFDEDEDE)),
                                          borderRadius:
                                              BorderRadius.circular(9)),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            width: 2,
                                            color: Color(0xFF44ACA1),
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(9))),
                                  // The validator receives the text that the user has entered.
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter some text';
                                    }
                                    return null;
                                  },
                                  onChanged: (value) {
                                    quantity = int.parse(value);
                                  },
                                ),
                              ),
                            ),
                            // ListView.builder(
                            //   itemCount: searchTerms.length,
                            //   itemBuilder: (context, index) {
                            //     var result = searchTerms[index];
                            //     return ListTile(
                            //       title: Text(result),
                            //     );
                            //   },
                            // ),
                          ],
                        )),
                        Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 12, top: 18, bottom: 6),
                              child: Text("Unit",
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Color(0xFF343434),
                                      fontFamily: 'Montserat',
                                      fontWeight: FontWeight.w500)),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 12, right: 39),
                              child: Container(
                                padding: const EdgeInsets.all(12),
                                height: 40,
                                width: 150,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(9),
                                  border: Border.all(color: Color(0XFFDEDEDE)),
                                  color: Color(0xFFFFFFFF),
                                ),
                                child: DropdownButton<String>(
                                  value: unitSelection,
                                  borderRadius: BorderRadius.circular(9),
                                  icon: Padding(
                                    padding:
                                        const EdgeInsets.only(left: 70, top: 1),
                                    child: const Icon(
                                      Icons.arrow_downward,
                                      size: 16,
                                      color: Color(0xFF8B8B8B),
                                    ),
                                  ),
                                  elevation: 0,
                                  style: const TextStyle(
                                      fontSize: 12,
                                      color: Color(0xFFA9A9A9),
                                      fontFamily: 'Montserat',
                                      fontWeight: FontWeight.w500),
                                  underline: Container(),
                                  onChanged: (String? value) {
                                    // This is called when the user selects an item.
                                    setState(() {
                                      unitSelection = value!;
                                    });
                                  },
                                  items: units.map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
                              ),
                            )
                            // TextFormField(
                            //   // initialValue: "Select unit",
                            //   decoration: new InputDecoration.collapsed(
                            //     hintText: 'Select unit'
                            //   ),
                            //   // The validator receives the text that the user has entered.
                            //   validator: (value) {
                            //     if (value == null || value.isEmpty) {
                            //       return 'Please enter some text';
                            //     }
                            //     return null;
                            //   },
                            // ),
                            // ListView.builder(
                            //   itemCount: searchTerms.length,
                            //   itemBuilder: (context, index) {
                            //     var result = searchTerms[index];
                            //     return ListTile(
                            //       title: Text(result),
                            //     );
                            //   },
                            // ),
                          ],
                        ))
                      ],
                    ),

                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 39, top: 18, bottom: 6),
                                child: Text("Price",
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Color(0xFF343434),
                                        fontFamily: 'Montserat',
                                        fontWeight: FontWeight.w500)),
                              ),

                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 39,
                                ),
                                child: Container(
                                  height: 40,
                                  width: 312,
                                  child: TextFormField(
                                    textAlign: TextAlign.left,
                                    // initialValue: "Enter price",
                                    decoration: new InputDecoration(
                                        hintText: 'Enter price',
                                        contentPadding: EdgeInsets.only(
                                            bottom: 16, left: 12),
                                        hintStyle: TextStyle(
                                            fontSize: 12,
                                            color: Color(0xFFA9A9A9),
                                            fontFamily: 'Montserat',
                                            fontWeight: FontWeight.w500),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                width: 1,
                                                color: Color(0xFFDEDEDE)),
                                            borderRadius:
                                                BorderRadius.circular(9)),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                              width: 2,
                                              color: Color(0xFF44ACA1),
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(9))),
                                    // The validator receives the text that the user has entered.
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter some text';
                                      }
                                      return null;
                                    },
                                    onChanged: (value) {
                                      price = int.parse(value);
                                    },
                                  ),
                                ),
                              ),
                              // ListView.builder(
                              //   itemCount: searchTerms.length,
                              //   itemBuilder: (context, index) {
                              //     var result = searchTerms[index];
                              //     return ListTile(
                              //       title: Text(result),
                              //     );
                              //   },
                              // ),
                            ],
                          ),
                        ),
                        Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 12, top: 18, bottom: 6),
                              child: Text("Expiry date",
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Color(0xFF343434),
                                      fontFamily: 'Montserat',
                                      fontWeight: FontWeight.w500)),
                            ),
                            SfDateRangePicker(
                              view: DateRangePickerView.month,
                              selectionMode:
                                  DateRangePickerSelectionMode.single,
                              monthViewSettings:
                                  DateRangePickerMonthViewSettings(
                                      firstDayOfWeek: 1),
                              onSelectionChanged: (value) {
                                var timestamp =
                                    DateTime.parse(value.value.toString());
                                expirationDate = Timestamp.fromDate(timestamp);
                              },
                            ),
                            /* Padding(
                              padding:
                                  const EdgeInsets.only(left: 12, right: 39),
                              child: Container(
                                padding: const EdgeInsets.all(12),
                                height: 40,
                                width: 312,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(9),
                                  border: Border.all(color: Color(0XFFDEDEDE)),
                                  color: Color(0xFFFFFFFF),
                                ),
                                child: TextField(
                                  controller: dateinput,
                                  decoration: const InputDecoration(
                                    labelText: 'Select date',
                                    contentPadding: EdgeInsets.all(12),
                                   // suffixIcon: Icon(Icons.calendar_today),
                                    hintStyle: TextStyle(
                                        fontSize: 12,
                                        color: Color(0xFFA9A9A9),
                                        fontFamily: 'Montserat',
                                        fontWeight: FontWeight.w500),

                                    //icon: Icon(Icons.calendar_today_rounded),

                                    /*enabledBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                width: 1,
                                                color: Color(0xFFDEDEDE)),
                                            borderRadius:
                                                BorderRadius.circular(9)),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                              width: 2,
                                              color: Color(0xFF44ACA1),
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(9)),*/
                                    //labelText: "Select date",
                                  ),
                                  readOnly: true,
                                  onTap: () async {
                                    SfDateRangePicker(
                                      view: DateRangePickerView.month,
                                      selectionMode:
                                          DateRangePickerSelectionMode.single,
                                      monthViewSettings:
                                          DateRangePickerMonthViewSettings(
                                              firstDayOfWeek: 1),
                                      onSelectionChanged: (value) {
                                        var timestamp = DateTime.parse(
                                            value.value.toString());
                                        expirationDate =
                                            Timestamp.fromDate(timestamp);
                                      },
                                      // onSelectionChanged: _onSelectionChanged,
                                      // selectionMode: DateRangePickerSelectionMode.range,
                                    );
                                  },
                                  /* child: SfDateRangePicker(
                                    view: DateRangePickerView.month,
                                    selectionMode:
                                        DateRangePickerSelectionMode.single,
                                    monthViewSettings:
                                        DateRangePickerMonthViewSettings(
                                            firstDayOfWeek: 1),
                                    onSelectionChanged: (value) {
                                      var timestamp =
                                          DateTime.parse(value.value.toString());
                                      expirationDate =
                                          Timestamp.fromDate(timestamp);
                                    },
                                    // onSelectionChanged: _onSelectionChanged,
                                    // selectionMode: DateRangePickerSelectionMode.range,
                                  ),*/
                                ),
                              ),
                            ),*/
                            // TextFormField(
                            //   // initialValue: "Expiry date",
                            //   decoration: new InputDecoration.collapsed(
                            //     hintText: 'Expiry date'
                            //   ),
                            //   // The validator receives the text that the user has entered.
                            //   validator: (value) {
                            //     if (value == null || value.isEmpty) {
                            //       return 'Please enter some text';
                            //     }
                            //     return null;
                            //   },
                            // ),
                            // ListView.builder(
                            //   itemCount: searchTerms.length,
                            //   itemBuilder: (context, index) {
                            //     var result = searchTerms[index];
                            //     return ListTile(
                            //       title: Text(result),
                            //     );
                            //   },
                            // ),
                          ],
                        ))
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            child: Row(children: [
                          Expanded(
                            child: CheckboxListTile(
                              title: Text("Fruit/Veggie",
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: Color(0xFF343434),
                                      fontFamily: 'Montserat',
                                      fontWeight: FontWeight.w500)),
                              value: fruitVeggieCheckbox,
                              onChanged: (value) {
                                setState(() {
                                  fridgeCheckbox = !fridgeCheckbox;
                                });
                              },
                            ),
                          ),
                          Expanded(
                            child: CheckboxListTile(
                              title: Text("Meat",
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: Color(0xFF343434),
                                      fontFamily: 'Montserat',
                                      fontWeight: FontWeight.w500)),
                              value: meatCheckbox,
                              onChanged: (value) {
                                setState(() {
                                  freezeCheckbox = !freezeCheckbox;
                                });
                              },
                            ),
                          ),
                          Expanded(
                            child: CheckboxListTile(
                              title: Text("Dairy",
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: Color(0xFF343434),
                                      fontFamily: 'Montserat',
                                      fontWeight: FontWeight.w500)),
                              value: dairyCheckbox,
                              onChanged: (value) {
                                setState(() {
                                  pantryCheckbox = !pantryCheckbox;
                                });
                              },
                            ),
                          )
                        ]))
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: Row(children: [
                          Expanded(
                            child: CheckboxListTile(
                              title: Text("Fridge",
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: Color(0xFF343434),
                                      fontFamily: 'Montserat',
                                      fontWeight: FontWeight.w500)),
                              value: fridgeCheckbox,
                              onChanged: (value) {
                                setState(() {
                                  fridgeCheckbox = !fridgeCheckbox;
                                });
                              },
                            ),
                          ),
                          Expanded(
                            child: CheckboxListTile(
                              title: Text("Freezer",
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: Color(0xFF343434),
                                      fontFamily: 'Montserat',
                                      fontWeight: FontWeight.w500)),
                              value: freezeCheckbox,
                              onChanged: (value) {
                                setState(() {
                                  freezeCheckbox = !freezeCheckbox;
                                });
                              },
                            ),
                          ),
                          Expanded(
                            child: CheckboxListTile(
                              title: Text("Pantry",
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: Color(0xFF343434),
                                      fontFamily: 'Montserat',
                                      fontWeight: FontWeight.w500)),
                              value: pantryCheckbox,
                              onChanged: (value) {
                                setState(() {
                                  pantryCheckbox = !pantryCheckbox;
                                });
                              },
                            ),
                          )
                        ]))
                      ],
                    ),
                    // ListView.builder(
                    //   itemCount: searchTerms.length,
                    //   itemBuilder: (context, index) {
                    //     var result = searchTerms[index];
                    //     return ListTile(
                    //       title: Text(result),
                    //     );
                    //   },
                    // ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 39, top: 30),
                        child: Container(
                          decoration: BoxDecoration(
                              //borderRadius: BorderRadius.circular(14),
                              //color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0xFF929292).withOpacity(0.2),
                                  blurRadius: 23,
                                  spreadRadius: -4,
                                  offset: Offset(0, 4.0),
                                ),
                              ]),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(14), // <-- Radius
                              ),

                              //padding: EdgeInsets.all(12),

                              fixedSize: Size(312, 54),
                              textStyle: TextStyle(
                                  fontSize: 17,
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFFFFFFFF)),
                              backgroundColor:
                                  Color(0xFF44ACA1), // background color
                              elevation: 0, // elevation of button
                              //shadowColor: Colors.
                            ),
                            child: const Text('Add product'),
                            onPressed: () {
                              print("Here are all the values");
                              print(productName);
                              print(quantity);
                              print(price);
                              print(expirationDate);
                              print(unitSelection);
                              print(fridgeCheckbox);
                              print(freezeCheckbox);
                              print(pantryCheckbox);
                              addToDB();
                              print("AADDEDDD to DB");
                              Navigator.pop(context);
                            },
                          ),
                        ),
                      ),
                    )
                  ]),
            )),
          ],
        ));
  }
}

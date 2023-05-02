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
  var quantity = "";
  var price = "";
  Timestamp expirationDate = new Timestamp.now();
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

  @override
  void initState() {
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

  
  @override
  Widget build(BuildContext context){
    // var query = "";
    // List<String> matchQuery = [];
    // for (var fruit in searchTerms) {
    //   if (fruit.toLowerCase().contains(query.toLowerCase())) {
    //     matchQuery.add(fruit);
    //   }
    // }
    return Scaffold(
      appBar: AppBar(
        title: Text(
              'Add Product',
              style: TextStyle(fontSize: 25),
            ),
      ),
      body: Center(
        child: Form(
          child:Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Product"),
              TextFormField(
                // initialValue: "Enter or select a product",
                decoration: new InputDecoration.collapsed(
                  hintText: 'Enter or select a product'
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
                    children: [
                      Text("Quantity"),
                      TextFormField(
                        // initialValue: "Enter quantity",
                        decoration: new InputDecoration.collapsed(
                          hintText: 'Enter quantity'
                        ),
                        // The validator receives the text that the user has entered.
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          quantity = value;
                        },
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
                    )
                  ),
                  Expanded(
                    child: Column(
                    children: [
                      Text("Unit"),
                      DropdownButton<String>(
                        value: unitSelection,
                        icon: const Icon(Icons.arrow_downward),
                        elevation: 16,
                        style: const TextStyle(color: Colors.deepPurple),
                        underline: Container(
                          height: 2,
                          color: Colors.deepPurpleAccent,
                        ),
                        onChanged: (String? value) {
                          // This is called when the user selects an item.
                          setState(() {
                            unitSelection = value!;
                          });
                        },
                        items: units.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
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
                  )
                  )
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Text("Price"),
                        TextFormField(
                          // initialValue: "Enter price",
                          decoration: new InputDecoration.collapsed(
                            hintText: 'Enter price'
                          ),
                          // The validator receives the text that the user has entered.
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            price = value;
                          },
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
                      children: [
                        Text("Experiation Date"),
                        SfDateRangePicker(
                          view: DateRangePickerView.month,
                          selectionMode: DateRangePickerSelectionMode.single,
                          monthViewSettings: DateRangePickerMonthViewSettings(firstDayOfWeek: 1),
                          onSelectionChanged: (value) {
                            var timestamp = DateTime.parse(value.value.toString());
                            expirationDate = Timestamp.fromDate(timestamp);
                          },
                          // onSelectionChanged: _onSelectionChanged,
                          // selectionMode: DateRangePickerSelectionMode.range,
                        ),
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
                    )
                  )
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: CheckboxListTile(
                            title:Text("Fridge"),
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
                            title:Text("Freezer"),
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
                            title:Text("Pantry"),
                            value: pantryCheckbox,
                            onChanged: (value) {
                              setState(() {
                                pantryCheckbox = !pantryCheckbox;
                              });
                            },
                          ),
                        )
                      ]
                    )
                  )
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
              ElevatedButton(
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
                  Navigator.pop(context);
              },
              )
            ]
            ),
          )
        )
    );
  }
}
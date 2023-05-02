import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
// Import the firebase_core plugin
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
//Import firestore database
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_wise/pages/recipe_details.dart';
import 'package:food_wise/pages/recipe_list.dart';
import 'package:food_wise/pages/recipe_instruction.dart';
import '../firebase_options.dart';
import 'package:meta/meta.dart';
import 'package:intl/intl.dart';

class Recipes extends StatefulWidget {
  @override
  _RecipesState createState() => _RecipesState();
}

class _RecipesState extends State<Recipes> {
  late Future<List<dynamic>> _recipes = Future.value([]); 

  Future<void> updateRecipes(List<dynamic> recipeData) async {
    setState(() {
      _recipes = Future.value(recipeData);
    });
  }
Future<List<String>> loadProductName() async {
  var collection = FirebaseFirestore.instance.collection('Food');
  var snapshot = await collection.get();
  List<String> productNames = [];
  for (var doc in snapshot.docs) {
    String productName = doc.data()['name'] as String;
    productNames.add(productName);
  }
  print(productNames);
  return productNames;
}

  /*Future<String> loadProductName() async {
    var collection = FirebaseFirestore.instance.collection('Food');
    var snapshot = await collection.get();
    print("BBBBBBB");
    print(snapshot.docs.first.data());
    print(snapshot.docs[0]);
    String productName = snapshot.docs.first.data()['name'] as String;
    print(productName);
    return productName;
  }*/

  Future<List<dynamic>> fetchRecipes(String productName) async {
    final response = await http.get(Uri.parse(
        'https://api.spoonacular.com/recipes/findByIngredients?ingredients=$productName&number=10&apiKey=4872b1e2b7b14272b28d763ea9f3654a'));

    if (response.statusCode == 200) {
      List<dynamic> recipes = json.decode(response.body);
      List<Future<Map<String, dynamic>>> recipeFutures = [];
      for (var recipe in recipes) {
        recipeFutures.add(fetchRecipe(recipe['id']));
      }
      List<Map<String, dynamic>> recipeData = await Future.wait(recipeFutures);
      updateRecipes(recipeData);
      return recipeData;
    } else {
      throw Exception('Failed to load data');
    }
  }

Future<Map<String, dynamic>> fetchRecipe(int recipeId) async {
  final response = await http.get(Uri.parse(
      'https://api.spoonacular.com/recipes/$recipeId/information?includeNutrition=true&apiKey=4872b1e2b7b14272b28d763ea9f3654a'));

  if (response.statusCode == 200) {
    Map<String, dynamic> recipeData = json.decode(response.body);
    String pictureUrl = recipeData['image'];
    recipeData['picture'] = pictureUrl;

    // Get time required to make recipe
    int prepTime = recipeData['preparationMinutes'] ?? 0;
    int cookTime = recipeData['cookingMinutes'] ?? 0;
    int totalTime = prepTime + cookTime;
    recipeData['totalTime'] = totalTime;

    // Get number of calories in recipe
    var nutrients = recipeData['nutrition']['nutrients'];
    var nutrient = nutrients.firstWhere((nutrient) => nutrient['name'] == 'Calories', orElse: () => null);
    int calories = nutrient != null ? nutrient['amount']?.round() ?? 0 : 0;

    recipeData['calories'] = calories;

    // Get recipe instructions
    final instructionResponse = await http.get(Uri.parse(
        'https://api.spoonacular.com/recipes/$recipeId/analyzedInstructions?apiKey=4872b1e2b7b14272b28d763ea9f3654a'));

    if (instructionResponse.statusCode == 200) {
      List<dynamic> instructions = json.decode(instructionResponse.body);
      recipeData['instructions'] = instructions;
    } else {
      throw Exception('Failed to load recipe instructions');
    }

    return recipeData;
  } else {
    throw Exception('Failed to load recipe data');
  }
}



 @override
void initState() {
  super.initState();
  loadProductName().then((productNames) {
    for (var productName in productNames) {
      fetchRecipes(productName);
    }
  });
}


@override
Widget build(BuildContext context) {
  return FutureBuilder<List<dynamic>>(
    future: _recipes,
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        final recipes = snapshot.data!;
        return Column(
          children: [
            Padding(
                  padding: const EdgeInsets.only(right: 85, left: 10),
                    child: Image.asset(
                      'lib/images/logo.png',
                      height: 23,
                      width: 110,
                    ),
                  ),
            SizedBox(
              height: MediaQuery.of(context).size.height - 150,
              child: ListView.builder(
                itemCount: recipes.length,
                itemBuilder: (context, index) {
                  final recipe = recipes[index];
                  return Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Color(0xFF929292).withOpacity(0.2),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xFF929292).withOpacity(0.2),
                          blurRadius: 23,
                          spreadRadius: 0,
                          offset: Offset(0, 4.0),
                        ),
                      ],
                    ),
                    margin:
                        EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: GestureDetector(
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>
                              RecipeInstructionsScreen(recipe: recipe),
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Left child with image in a rounded box
                          Container(
                            width: 55,
                            height: 70,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Color(0xFF929292).withOpacity(0.2),
                            ),
                            padding: EdgeInsets.all(7),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                recipe['picture'],
                                fit: BoxFit.cover, 
                              ),
                            ),
                          ),
                          // Right child with title, time required, and calories
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Recipe title
                                  Padding(
                                    padding: EdgeInsets.only(left: 5),
                                    child:Text(
                                      recipe['title'],
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Color.fromRGBO(77, 77, 77, 1),
                                          fontFamily: 'Montserrat',
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                  ),
                                 Row(
                                      children: [
                                        Image.asset(
                                          'lib/images/weight.png',
                                          width: 12,
                                          height: 12,
                                        ),
                                        SizedBox(width: 5),
                                        Text(
                                          ' ${recipe['readyInMinutes']} minutes',
                                          style: TextStyle(
                                            fontSize: 6,
                                            color: Color.fromRGBO(143, 143, 143, 1),
                                            fontFamily: 'Montserrat',
                                          ),
                                        ),
                                      ],
                                    ),
                                  SizedBox(height: 5),
                                  // Calories
                                
                                  ///
                                Row(
                                      children: [
                                        Image.asset(
                                          'lib/images/weight.png',
                                          width: 12,
                                          height: 12,
                                        ),
                                        SizedBox(width: 5),
                                        Text(
                                          ' ${recipe['calories']} kCal',
                                          style: TextStyle(
                                            fontSize: 6,
                                            color: Color.fromRGBO(143, 143, 143, 1),
                                            fontFamily: 'Montserrat',
                                          ),
                                        ),
                                      ],
                                    ),
                                  //
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      } else if (snapshot.hasError) {
        return Text('${snapshot.error}');
      }
      return Center(
        child: CircularProgressIndicator(),
      );
    },
  );
}



}

//import 'package:flutter/material.dart';
//import 'package:gabip1_s_application/core/app_export.dart';

/*

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
*/
/*
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
                    return GestureDetector(
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => DetailsScreen(),
                        ),
                      ),
                      child: Padding(
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
                                          overflow: TextOverflow.ellipsis,
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
                              ]))),
                    );
                  }),
            ),
          ],
        ));
  }

}*/

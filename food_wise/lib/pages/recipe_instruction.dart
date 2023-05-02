
import 'package:flutter/material.dart';

class RecipeInstructionsScreen extends StatelessWidget {
  final dynamic recipe;

  const RecipeInstructionsScreen({Key? key, required this.recipe})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<dynamic> analyzedInstructions = recipe['analyzedInstructions'];
    final String instructions = analyzedInstructions.isEmpty
        ? ''
        : analyzedInstructions
            .map((instruction) =>
                (instruction['steps'] as List<dynamic>)
                    .map((step) => step['step'].toString().trim())
                    .join('\n'))
            .join('\n\n');

    return Scaffold(
      appBar: AppBar(
        title: Text(recipe['title']),
        backgroundColor: Color(0xFF44ACA1),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            if (recipe['image'] != null)
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(6),
                    topRight: Radius.circular(6),
                    bottomRight: Radius.circular(26),
                    bottomLeft: Radius.circular(26),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(6),
                    topRight: Radius.circular(6),
                    bottomRight: Radius.circular(26),
                    bottomLeft: Radius.circular(26),
                  ),
                  child: Image.network(
                    recipe['image'],
                    width: 390,
                    height: 355,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Instructions',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    instructions,
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/*class RecipeInstructionsScreen extends StatelessWidget {
  final dynamic recipe;

  const RecipeInstructionsScreen({Key? key, required this.recipe})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<dynamic> analyzedInstructions = recipe['analyzedInstructions'];
    final String instructions = analyzedInstructions.isEmpty
        ? ''
        : analyzedInstructions
            .map((instruction) =>
                (instruction['steps'] as List<dynamic>)
                    .map((step) => step['step'].toString().trim())
                    .join('\n'))
            .join('\n\n');

    return Scaffold(
      appBar: AppBar(
        title: Text(recipe['title']),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            if (recipe['image'] != null)
              Image.network(
                recipe['image'],
                height: MediaQuery.of(context).size.height / 2,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
              ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Instructions',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    instructions,
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

*/
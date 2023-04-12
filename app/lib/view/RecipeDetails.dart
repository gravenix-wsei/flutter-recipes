import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:recipes/model/Meal.dart';

class RecipeDetails extends StatelessWidget {
  final Meal meal;

  const RecipeDetails(this.meal);
  
  @override
  Widget build(BuildContext context) {
    Widget recipeInformationWithPicture = Row(
      children: <Column>[
        Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(right: 16, top: 8),
              alignment: Alignment.centerRight,
              width: MediaQuery.of(context).size.width,
              child: Text("Category: ${meal.category}",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 12,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(16),
              width: MediaQuery.of(context).size.width,
              child: Image.network(meal.thumbnail, fit: BoxFit.contain)
            ),
          ]
        ),
      ],
    );
    Widget ingredients = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Column>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: meal.measures.map(
            (String measure) => Text(measure)
          ).toList(),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: meal.ingredients.map(
            (String ingredient) => Container(
              margin: EdgeInsets.only(left: 32),
              child: Text(ingredient)
            )
          ).toList(),
        )
      ]
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(meal.name),
      ),
      body: ListView(
        children: <Widget>[
          recipeInformationWithPicture,
          Center(
            child: Text('Ingredients'.toUpperCase(),
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                letterSpacing: 4,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(width: 1.0, color: const Color(0xcccccccc)),
            ),
            margin: EdgeInsets.all(16),
            padding: EdgeInsets.all(8),
            child: ingredients,
          ),
          Container(
            padding: EdgeInsets.all(16),
            child: Text(meal.instructions, 
              textAlign: TextAlign.justify,
            ),
          ),
        ]
      ),
    );
  }
}
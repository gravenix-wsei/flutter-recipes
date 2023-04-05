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
              padding: EdgeInsets.all(16),
              height: MediaQuery.of(context).size.width * 0.6,
              child: Image.network(meal.thumbnail, fit: BoxFit.contain)
            ),
          ]
        ),
        Column(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 16),
              child: Text("Name: ${meal.name}")
            ),
            Container(
              padding: const EdgeInsets.only(top: 16),
              child: Text("Category: ${meal.category}")
            )
          ]
        )
      ],
    );
    Widget ingredients = Row(
      children: <Column>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: meal.measures.map(
            (String measure) => Container(
              margin: EdgeInsets.only(left: 32),
              child: Text(measure)
            )
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
          ingredients,
          Container(
            padding: EdgeInsets.all(16),
            child: Text(meal.instructions),
          ),
        ]
      ),
    );
  }
}
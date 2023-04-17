import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:recipes/model/Meal.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RecipeDetails extends StatefulWidget {
  final Meal meal;
  final SharedPreferences preferences;

  RecipeDetails(this.meal, this.preferences);

  @override
  State<RecipeDetails> createState() => RecipeDetailsState();
}

class RecipeDetailsState extends State<RecipeDetails> {
  late bool isFavorite;

  @override
  void initState() {
    super.initState();
    isFavorite = checkIfMealIsInFavourites(widget.meal);
  }

  void addToFavorites(Meal meal) {
    List<String> favourites = widget.preferences.getStringList('favourites') ?? [];
    String mealId = meal.id.toString();
    if (favourites.contains(mealId)) {
      favourites.remove(mealId);
    } else {
      favourites.add(mealId);
    }

    widget.preferences.setStringList('favourites', favourites);
    setState(() {
      isFavorite = !isFavorite;
    });
  }

  bool checkIfMealIsInFavourites(Meal meal) {
    List<String> favourites =  widget.preferences.getStringList('favourites') ?? [];

    return favourites.contains(meal.id.toString());
  }
  
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
              child: Text("Category: ${widget.meal.category}",
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
              child: Image.network(widget.meal.thumbnail, fit: BoxFit.contain)
            ),
          ]
        ),
      ],
    );
    Widget addToFavouritesButton = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Theme.of(context).primaryColor),
            borderRadius: BorderRadius.all(Radius.circular(32)),
          ),
          child: TextButton(
            onPressed: () => {addToFavorites(widget.meal)},
            child: Row(
              children: <Widget>[
                Icon(isFavorite ? Icons.favorite : Icons.favorite_outline), // TODO: potential for animation
                Text('Add to favourites'),
              ],
            ),
          ),
        ),
      ],
    );
    Widget ingredients = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Column>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: widget.meal.measures.map(
            (String measure) => Text(measure)
          ).toList(),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: widget.meal.ingredients.map(
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
        title: Text(widget.meal.name),
      ),
      body: ListView(
        children: <Widget>[
          recipeInformationWithPicture,
          addToFavouritesButton,
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
            child: Text(widget.meal.instructions, 
              textAlign: TextAlign.justify,
            ),
          ),
        ]
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:recipes/api/Urls.dart';
import 'package:recipes/model/Meal.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:recipes/view/RecipeDetails.dart';
import 'package:recipes/widget/MainMenu.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Favourites extends StatefulWidget
{
  late Future<List<Meal>> favouriteMeals;

  @override
  State<Favourites> createState() => FavouritesState();
}

class FavouritesState extends State<Favourites> {
  late SharedPreferences preferences;

  Future<List<Meal>> fetchMeals() async {
    final response = await http.get(Uri.parse(Urls.getRecipesUrl()));
    final preferences = await SharedPreferences.getInstance();
    List<String> favourites = preferences.getStringList('favourites') ?? [];

    if (response.statusCode == 200) {
      List<Meal> list = [];
      var meals = jsonDecode(response.body)["meals"]; 
      for (var meal in meals) {
        Meal objMeal = Meal.fromJson(meal);
        if (favourites.contains(objMeal.id.toString())) {
          list.add(objMeal);
        }
      }
      return list;
    } else {
      throw Exception('Failed to load recipies');
    }
  }

  ListView generateListView(BuildContext context, AsyncSnapshot<List<Meal>> snapshot) {
    return ListView(
      children: snapshot.data!.map((meal) {
        return ListTile(
          leading: Image.network(meal.thumbnail),
          title: Text(meal.name),
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => RecipeDetails(meal, preferences))),
        );
      }).toList(),
    );
  }

  @override
  void initState() {
    super.initState();
    widget.favouriteMeals = fetchMeals();
    loadPreferences();
  }

  void loadPreferences() async {
    preferences = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favourites'),
      ),
      drawer: MainMenu(),
      body: FutureBuilder<List<Meal>>(
              future: widget.favouriteMeals,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return generateListView(context, snapshot);
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }

                return Container(
                  alignment: Alignment.center,
                  child: Center(child: CircularProgressIndicator()),
                );
              },
            )
    );
  }
}
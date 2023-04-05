import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:recipes/model/Meal.dart';
import 'package:recipes/api/Urls.dart';
import 'package:http/http.dart' as http;
import 'package:recipes/view/RecipeDetails.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recipes',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Recipes'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<List<Meal>> meals;

  Future<List<Meal>> fetchMeals() async {
    final response = await http.get(Uri.parse(Urls.getRecipesUrl()));

    if (response.statusCode == 200) {
      List<Meal> list = [];
      var meals = jsonDecode(response.body)["meals"]; // TODO: better handling errors
      for (var meal in meals) {
        list.add(Meal.fromJson(meal));
      }
      return list;
    } else {
      throw Exception('Failed to load recipies');
    }
  }
  
  @override
  void initState() {
    super.initState();
    meals = fetchMeals();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: FutureBuilder<List<Meal>>(
              future: meals,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView(
                    children: snapshot.data!.map((meal) {
                      return ListTile(
                        leading: Image.network(meal.thumbnail),
                        title: Text(meal.name),
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => RecipeDetails(meal))),
                      );
                    }).toList(),
                  );
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }

                return const CircularProgressIndicator();
              },
            )
    );
  }
}

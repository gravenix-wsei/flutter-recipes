import 'package:flutter/material.dart';
import 'package:recipes/main.dart';
import 'package:recipes/view/Favourites.dart';
import 'package:recipes/view/RecipeDetails.dart';

class MainMenu extends StatelessWidget {
  final State<dynamic> from;

  MainMenu(this.from);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.width * 0.5,
      child: Column(
        children: <Widget>[
          DrawerHeader(
            child: Container(
              alignment: Alignment.topLeft,
              margin: EdgeInsets.only(top: 16, bottom: 16),
              child: GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: Icon(Icons.close),
              ),
            )
          ),
          Expanded(
            child: ListView(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.home),
                  title: Text('All Recipes'),
                  onTap: () => {
                    if (from is State<MyHomePage>) {
                      Navigator.of(context).pop(),
                    } else {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MyHomePage()))
                    }
                  }
                ),
                ListTile(
                  leading: Icon(Icons.favorite),
                  title: Text('Favourites'),
                  onTap: () => {
                    if (from is State<RecipeDetails>) {
                      Navigator.of(context).pop()
                    } else {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Favourites()))
                    }
                  },
                ),
              ],
            ),
          ),
        ]
      ),
    );
  }
}
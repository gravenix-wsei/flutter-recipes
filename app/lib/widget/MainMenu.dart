import 'package:flutter/material.dart';
import 'package:recipes/view/Favourites.dart';

class MainMenu extends StatelessWidget {
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
                  onTap: () => Navigator.of(context).pop(),
                ),
                ListTile(
                  leading: Icon(Icons.favorite),
                  title: Text('Favourites'),
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Favourites())),
                ),
              ],
            ),
          ),
        ]
      ),
    );
  }
}
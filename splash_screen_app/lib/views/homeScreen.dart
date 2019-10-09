import 'package:flutter/material.dart';
import 'package:splash_screen_app/models/global_translations.dart';
import 'package:splash_screen_app/views/languageSelector.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => new _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('HomeScreen'),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.settings,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return LanguageSelector();
                  },
                ),
              );
            },
          ),
        ],
      ),
      body: new Center(
        child: new Text(allTranslations.text('welcome_text')),
      ),
    );
  }
}

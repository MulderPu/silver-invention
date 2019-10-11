import 'package:flutter/material.dart';
import 'package:splash_screen_app/models/global_translations.dart';
import 'package:splash_screen_app/views/detail_screen.dart';
import 'package:splash_screen_app/views/languageSelector.dart';
import 'package:splash_screen_app/views/websocket_screen.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/HomeScreen';

  @override
  _HomeScreenState createState() => new _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(allTranslations.text('app_title')),
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
      body: ListView(
        padding: EdgeInsets.all(20),
        children: <Widget>[
          Center(
            child: Text(allTranslations.text('welcome_text')),
          ),
          const SizedBox(height: 20),
          Text(allTranslations.text('New row sentences.')),
          const SizedBox(height: 20),
          RaisedButton(
            child: Text('Go To Detail Screen'),
            onPressed: () {
              // go to detail screen
              Navigator.pushNamed(
                context,
                DetailScreen.routeName,
                arguments: DetailArguments(
                  'From Home Screen',
                  'This message is extracted in the build method.',
                ),
              );
            },
          ),
          RaisedButton(
            child: Text('Go to Websocket'),
            onPressed: () {
              // go to websocket screen
              Navigator.pushNamed(context, WebSocketScreen.routeName);
            },
          )
        ],
      ) 
    );
  }
}

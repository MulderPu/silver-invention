import 'package:flutter/material.dart';
import 'package:splash_screen_app/homeScreen.dart';
import 'package:splash_screen_app/widgets/splash_screen.dart';

void main() {
   runApp(new MaterialApp(
    home: new SplashScreen(),
    routes: <String, WidgetBuilder>{
      '/HomeScreen': (BuildContext context) => new HomeScreen()
    },
  ));
}


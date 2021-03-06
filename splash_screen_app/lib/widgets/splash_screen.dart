import 'dart:async';

import 'package:flutter/material.dart';
import 'package:splash_screen_app/views/homeScreen.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = '/';

  @override
  _SplashScreenState createState() => new _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  startTime() async {
    var _duration = new Duration(seconds: 2);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() {
    Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
  }

  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
  return new Scaffold(
    body: new Center(
      child: new Image.asset('assets/images/mike.PNG'),
    ),
  );
  }
}
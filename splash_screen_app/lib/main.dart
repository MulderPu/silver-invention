import 'package:flutter/material.dart';
import 'package:splash_screen_app/supplemental/cut_corners_border.dart';
import 'package:splash_screen_app/views/detail_screen.dart';
import 'package:splash_screen_app/views/homeScreen.dart';
import 'package:splash_screen_app/views/websocket_screen.dart';
import 'package:splash_screen_app/views/websocket_screen_2.dart';
import 'package:splash_screen_app/widgets/splash_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:splash_screen_app/common/colors.dart';
import 'package:splash_screen_app/models/global_translations.dart';

void main() async {
  // init translation module
  await allTranslations.init();
  runApp(AppInit());
}

class AppInit extends StatefulWidget {
  @override
  _AppInitState createState() => _AppInitState();
}

class _AppInitState extends State<AppInit> {
  @override
  void initState() {
    super.initState();

    // init callback
    allTranslations.onLocaleChangedCallback = _onLocaleChanged;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: SplashScreen.routeName,
      routes: <String, WidgetBuilder>{
        SplashScreen.routeName : (BuildContext context) => new SplashScreen(),
        HomeScreen.routeName: (BuildContext context) => new HomeScreen(),
        DetailScreen.routeName: (BuildContext context) => new DetailScreen(),
        WebSocketScreen.routeName: (BuildContext context) => new WebSocketScreen(),
        WebSocketScreen2.routeName: (BuildContext context) => new WebSocketScreen2()
      },
      theme: _kShrineTheme,
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        //provides localised strings
        GlobalMaterialLocalizations.delegate,
        //provides RTL support
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: allTranslations.supportedLocales(),
    );
  }

  _onLocaleChanged() async {
    // do things if language changed
    print('language changed: ${allTranslations.currentLanguage}');
  }
}

final ThemeData _kShrineTheme = _buildShrineTheme();

ThemeData _buildShrineTheme() {
  final ThemeData base = ThemeData.light();
  return base.copyWith(
    accentColor: kShrineBrown900,
    primaryColor: kShrinePink100,
    buttonColor: kShrinePink100,
    scaffoldBackgroundColor: kShrineBackgroundWhite,
    cardColor: kShrineBackgroundWhite,
    textSelectionColor: kShrinePink100,
    errorColor: kShrineErrorRed,
    buttonTheme: base.buttonTheme.copyWith(
      buttonColor: kShrinePink100,
      textTheme: ButtonTextTheme.normal,
    ),
    primaryIconTheme: base.iconTheme.copyWith(color: kShrineBrown900),
    inputDecorationTheme: InputDecorationTheme(
      border: CutCornersBorder(),
    ),
    textTheme: _buildShrineTextTheme(base.textTheme),
    primaryTextTheme: _buildShrineTextTheme(base.primaryTextTheme),
    accentTextTheme: _buildShrineTextTheme(base.accentTextTheme),
  );
}

TextTheme _buildShrineTextTheme(TextTheme base) {
  return base
      .copyWith(
        headline: base.headline.copyWith(
          fontWeight: FontWeight.w500,
        ),
        title: base.title.copyWith(fontSize: 18.0),
        caption: base.caption.copyWith(
          fontWeight: FontWeight.w400,
          fontSize: 14.0,
        ),
        body2: base.body2.copyWith(
          fontWeight: FontWeight.w500,
          fontSize: 16.0,
        ),
      )
      .apply(
        fontFamily: 'Alice',
        displayColor: kShrineBrown900,
        bodyColor: kShrineBrown900,
      );
}

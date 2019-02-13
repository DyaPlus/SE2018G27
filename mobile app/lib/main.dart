import 'package:flutter/material.dart';

import 'pages/homePage_first.dart';
import 'pages/loginPage.dart';
import 'pages/registerPage.dart';
import 'pages/mainHomePage.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'globals.dart' as globals;

void main() async {
  globals.prefs = await SharedPreferences.getInstance();
  runApp(HMSApp());
}

class HMSApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HMSAppState();
}

class _HMSAppState extends State<HMSApp> {
  @override
  void initState() {
    globals.getToken();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(globals.token.length);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: (globals.token.length == 0) ? HomePageFirst() : MainHomePage(),
      theme: theme(),
      initialRoute: '/',
      routes: {
        '/firstHome': (context) => HomePageFirst(),
        '/login': (context) => LoginPage(),
        '/register': (context) => RegisterPage(),
        '/home': (context) => MainHomePage(),
      },
    );
  }
}

ThemeData theme() {
  return ThemeData(
    fontFamily: 'ProductSans',
    brightness: Brightness.light,
    primarySwatch: Colors.lightBlue,
    accentColor: Colors.lightBlueAccent,
  );
}

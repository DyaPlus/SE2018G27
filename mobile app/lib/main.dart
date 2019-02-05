
import 'package:flutter/material.dart';

import 'pages/homePage_first.dart';
import 'pages/loginPage.dart';
import 'pages/registerPage.dart';
//import 'pages/myReservationsPage.dart';
//import 'pages/newReservationPage.dart';
import 'pages/mainHomePage.dart';

void main() => runApp(HMSApp());

class HMSApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HMSAppState();
}

class _HMSAppState extends State<HMSApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: home(),
      theme: theme(),
      initialRoute: '/',
      routes: {
        '/firstHome': (context) => HomePageFirst(),
        '/login': (context) => LoginPage(),
        '/register': (context) => RegisterPage(),
        '/home': (context) => MainHomePage(/*name: "Omar"*/),
      },
    );
  }
}

Widget home() {
  return HomePageFirst();
}

ThemeData theme() {
  return ThemeData(
    fontFamily: 'ProductSans',
    brightness: Brightness.light,
    primarySwatch: Colors.lightBlue,
    accentColor: Colors.lightBlueAccent,
  );
}

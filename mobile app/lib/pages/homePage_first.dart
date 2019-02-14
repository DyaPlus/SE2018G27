import 'package:flutter/material.dart';

import '../myWidgets.dart';
import 'mainHomePage.dart';
import 'package:hms/globals.dart' as globals;

class HomePageFirst extends StatefulWidget {
  @override
  HomePageFirstState createState() {
    return HomePageFirstState();
  }
}

class HomePageFirstState extends State<HomePageFirst> {
  // void initState() {
  //   super.initState();
  //   globals.getToken();
  //   if (globals.token != "" && globals.token != null) {
  //     Navigator.pushReplacement(
  //       context,
  //       MaterialPageRoute(builder: (context) => MainHomePage()),
  //     );
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Page(
      title: "Health Management System",
      hasDrawer: false,
      centerTitle: true,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            MyButton(
              text: "REGISTER",
              route: '/register',
              padding: 3.0,
              splashColor: Colors.lightBlue[800],
            ),
            MyButton(
              text: "LOGIN",
              route: '/login',
              padding: 3.0,
              splashColor: Colors.lightBlue[800],
            ),
          ],
        ),
      ),
    );
  }
}

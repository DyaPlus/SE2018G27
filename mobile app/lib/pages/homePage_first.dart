import 'package:flutter/material.dart';

import '../myWidgets.dart';

class HomePageFirst extends StatelessWidget {
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

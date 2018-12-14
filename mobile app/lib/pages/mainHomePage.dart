import 'package:flutter/material.dart';

import '../myWidgets.dart';

class MainHomePage extends StatelessWidget {
  final String name;
  MainHomePage({@required this.name});

  @override
  Widget build(BuildContext context) {
    return Page(
      userName: name,
      title: "Home Page",
      centerTitle: true,
      hasDrawer: true,
      body: Center(
        child: Text(
          "Welcome " + name,
          style: TextStyle(fontSize: 30.0),
        ),
      ),
    );
  }
}

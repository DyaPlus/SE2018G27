import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

import 'package:hms/myWidgets.dart';
import 'mainHomePage.dart';

class LoginPage extends StatefulWidget {
  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  Map<String, String> enteredUserInfo = {
    'email': '',
    'password': '',
  };

  void _login() {
    var url = '';
    var enteredUserInfoJSON = json.encode(enteredUserInfo);
    http.post(url, body: enteredUserInfoJSON);
    //TODO: wait for confirmation from server

    //Navigator.pushNamedAndRemoveUntil(context, '/home/' + enteredUserInfo['email'], (Route<dynamic> route) => false);

    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) => MainHomePage(name: enteredUserInfo['email'])),
        (Route<dynamic> route) => false);
    //Navigator.of(context).push(MaterialPageRoute(builder: (context) => MainHomePage()));
  }

  @override
  Widget build(BuildContext context) {
    return Page(
      title: "Login",
      body: Center(
        child: ListView(
          children: <Widget>[
            Container(
              height: 50.0,
            ),
            Input(
              text: "Email",
              onChanged: (value) => enteredUserInfo['email'] = value,
              padding: 3.0,
              icon: Icons.email,
              label: "Enter your email",
              type: TextInputType.emailAddress,
            ),
            Container(
              height: 50.0,
            ),
            Input(
              text: "Password",
              onChanged: (value) => enteredUserInfo['password'] = value,
              padding: 3.0,
              icon: Icons.lock,
              label: "Enter your password",
              password: true,
            ),
            Container(
              height: 50.0,
            ),
            Container(
              padding: EdgeInsets.all(10.0),
              child: MyRoundedButton(
                text: "LOGIN",
                onPressed: () {
                  _login();
                  print(enteredUserInfo);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

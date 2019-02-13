import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:convert';

import 'package:hms/myWidgets.dart';
import 'mainHomePage.dart';
import 'package:hms/globals.dart' as globals;

class LoginPage extends StatefulWidget {
  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  Map<String, String> enteredUserInfo = {
    'username': '',
    'password': '',
  };

  void _login() async {
    //var url = 'https://secret-lowlands-85631.herokuapp.com/users/signin/';
    var url = globals.domain + "users/signin/";
    var enteredUserInfoJSON = json.encode(enteredUserInfo);
    final http.Response response = await http.post(url,
        body: enteredUserInfoJSON,
        headers: {"Content-Type": "application/json"});
    final Map<String, dynamic> responseData = json.decode(response.body);

    if (response.statusCode == 200) {
      globals.setToken(responseData['token']);

      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => MainHomePage()),
          (Route<dynamic> route) => false);
    } else if (response.statusCode == 400) {
      return showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
                title: Text("Error"),
                content: Text("Wrong Credentials"),
              ));
    } else {
      return showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: Text("Failed"),
              content: Text(response.body),
            ),
      );
    }
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
              onChanged: (value) => enteredUserInfo['username'] = value,
              padding: 3.0,
              icon: Icons.account_circle,
              label: "Enter your username",
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
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

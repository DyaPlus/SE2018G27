import 'package:flutter/material.dart';
import 'package:hms/myWidgets.dart';
//import 'package:http/http.dart' as http;
//import 'dart:convert';

class RegisterPage extends StatefulWidget {
  @override
  RegisterPageState createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> {
  Map<String, dynamic> userInfo = {
    'fullName': '',
    'nationalID': '',
    'email': '',
    'password': '',
  };
  String _confirmPassword = '';

  ColorSwatch _fullNameColor = Colors.blue;
  ColorSwatch _nationalIDColor = Colors.blue;
  ColorSwatch _emailColor = Colors.blue;
  ColorSwatch _passwordColor = Colors.blue;
  ColorSwatch _confirmPasswordColor = Colors.blue;
  ColorSwatch _buttonColor = Colors.blue;

  bool _infoReady() {
    if (userInfo['fullName'] == '' ||
        userInfo['nationalID'] == '' ||
        userInfo['email'] == '' ||
        userInfo['password'] == '' ||
        _confirmPassword == '' ||
        _confirmPassword != userInfo['password']) return false;
    // if (!userInfo['email'].contains('@')) {
    //   setState(() {
    //     _emailColor = Colors.red;
    //   });
    //   return false;
    // }
    setState(() {
      _buttonColor = Colors.blue;
    });
    return true;
  }

  void _getInfo() {
    print(userInfo);
    //var url = '';
    //var userInfoJSON = json.encode(userInfo);
    //http
    //    .post(url, body: userInfoJSON)
    //    .then((http.Response response) => print(response));
  }

  void _infoNotReady() {
    setState(() {
      _buttonColor = Colors.grey;
    });
    if (userInfo['fullName'] == '') {
      setState(() {
        _fullNameColor = Colors.red;
      });
    }
    if (userInfo['nationalID'] == '') {
      setState(() {
        _nationalIDColor = Colors.red;
      });
    } else {
      setState(() {
        _nationalIDColor = Colors.blue;
      });
    }
    if (userInfo['email'] == '') {
      setState(() {
        _emailColor = Colors.red;
      });
    } else {
      setState(() {
        _emailColor = Colors.blue;
      });
    }
    if (userInfo['password'] == '') {
      setState(() {
        _passwordColor = Colors.red;
      });
    } else {
      setState(() {
        _passwordColor = Colors.blue;
      });
    }
    if (_confirmPassword != userInfo['password'] || _confirmPassword == '') {
      _confirmPasswordColor = Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Page(
      title: "Registeration",
      body: ListView(
        children: <Widget>[
          Input(
            text: "Full Name",
            icon: Icons.account_circle,
            padding: 10.0,
            onChanged: (value) {
              userInfo['fullName'] = value;
              setState(() {
                _fullNameColor = Colors.green;
              });
            },
            label: "Enter your full name",
            color: _fullNameColor,
          ),
          Input(
            type: TextInputType.number,
            text: "National ID",
            maxLength: 14,
            icon: Icons.credit_card,
            padding: 10.0,
            onChanged: (value) {
              userInfo['nationalID'] = value;
              setState(() {
                _nationalIDColor = Colors.green;
              });
            },
            label: "Enter your national ID",
            color: _nationalIDColor,
          ),
          Input(
            type: TextInputType.emailAddress,
            text: "Email",
            icon: Icons.email,
            padding: 10.0,
            onChanged: (value) {
              userInfo['email'] = value;
              setState(() {
                _emailColor = Colors.green;
              });
            },
            label: "Enter your email address",
            color: _emailColor,
          ),
          Input(
              text: "Password",
              icon: Icons.lock,
              padding: 10.0,
              password: true,
              color: _passwordColor,
              onChanged: (value) {
                setState(() {
                  userInfo['password'] = value;
                  _passwordColor = Colors.green;
                });
              }),
          Input(
            text: "Confirm Password",
            icon: Icons.lock,
            padding: 10.0,
            password: true,
            onChanged: (value) {
              if (value == userInfo['password']) {
                setState(() {
                  _confirmPassword = value;
                  _confirmPasswordColor = Colors.green;
                });
              } else {
                setState(() {
                  _confirmPasswordColor = Colors.red;
                });
              }
            },
            label: "Confirm password",
            color: _confirmPasswordColor,
          ),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Container(
              child: MyRoundedButton(
                color: _infoReady() ? _buttonColor : Colors.grey,
                onPressed: () => _infoReady() ? _getInfo() : _infoNotReady(),
                text: "REGISTER",
              ),
            ),
          ),
        ],
      ),
    );
  }
}

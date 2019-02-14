import 'package:flutter/material.dart';
import 'package:hms/myWidgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:hms/globals.dart' as globals;

import 'package:hms/pages/mainHomePage.dart';

class RegisterPage extends StatefulWidget {
  @override
  RegisterPageState createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> {
  Map<String, dynamic> userInfo = {
    'username': '',
    'password': '',
    'password2': '',
    'full_name': '',
    'type': '',
    'national_id': '',
    'mobile': '',
  };

  String _confirmPassword = '';

  ColorSwatch _fullNameColor = Colors.blue;
  ColorSwatch _nationalIDColor = Colors.blue;
  ColorSwatch _usernameColor = Colors.blue;
  ColorSwatch _passwordColor = Colors.blue;
  ColorSwatch _mobileColor = Colors.blue;
  ColorSwatch _confirmPasswordColor = Colors.blue;
  ColorSwatch _buttonColor = Colors.blue;

  bool _infoReady() {
    //print(userInfo);

    if (userInfo['username'] == '' ||
        userInfo['password'] == '' ||
        userInfo['password2'] == '' ||
        userInfo['full_name'] == '' ||
        userInfo['type'] == '' ||
        userInfo['national_id'] == '' ||
        userInfo['mobile'] == '' ||
        _confirmPassword == '' ||
        _confirmPassword != userInfo['password']) return false;

    setState(() {
      _buttonColor = Colors.blue;
    });
    return true;
  }

  Future<String> _getInfo() async {
    //var url = 'https://secret-lowlands-85631.herokuapp.com/users/signup/';
    //print(userInfo);

    var url = globals.domain + "users/signup/";
    var userInfoJSON = json.encode(userInfo);
    final response = await http.post(url,
        body: userInfoJSON, headers: {"Content-Type": "application/json"});
    final Map<String, dynamic> responseData = json.decode(response.body);
    print(response.body);
    print(response.statusCode);
    print(url);
    if (response.statusCode == 200) {
      globals.setToken(responseData['token']);

      return showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: Text("Registered successfully"),
              content: Text(response.body),
              actions: <Widget>[
                FlatButton(
                  child: Text("OK"),
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => MainHomePage()),
                        (Route<dynamic> route) => false);
                  },
                ),
              ],
            ),
      );
    } else {
      print("FAIL");
      print(response.body);

    }
  }

  void _infoNotReady() {
    setState(() {
      _buttonColor = Colors.grey;
    });
    if (userInfo['full_name'] == '') {
      setState(() {
        _fullNameColor = Colors.red;
      });
    }
    if (userInfo['national_id'] == '') {
      setState(() {
        _nationalIDColor = Colors.red;
      });
    } else {
      setState(() {
        _nationalIDColor = Colors.blue;
      });
    }
    if (userInfo['username'] == '') {
      setState(() {
        _usernameColor = Colors.red;
      });
    } else {
      setState(() {
        _usernameColor = Colors.blue;
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
    if (userInfo['mobile'] == '') {
      setState(() {
        _mobileColor = Colors.red;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Page(
      title: "Registeration",
      body: ListView(
        children: <Widget>[
          Input(
              text: "Username",
              icon: Icons.account_circle,
              padding: 10.0,
              onChanged: (value) {
                userInfo['username'] = value;
                setState(() {
                  _usernameColor = Colors.green;
                });
              },
              label: "Enter your username",
              color: _usernameColor),
          Input(
            text: "Full Name",
            icon: Icons.account_circle,
            padding: 10.0,
            onChanged: (value) {
              userInfo['full_name'] = value;
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
              userInfo['national_id'] = value;
              setState(() {
                _nationalIDColor = Colors.green;
              });
            },
            label: "Enter your national ID",
            color: _nationalIDColor,
          ),
          MyDropDown(
            title: "Type",
            items: ["P", "D"],
            onChanged: (value) => setState(() => userInfo['type'] = value),
          ),
          Input(
              text: "Mobile number",
              padding: 10.0,
              label: "Enter your mobile number",
              icon: Icons.phone,
              color: _mobileColor,
              type: TextInputType.numberWithOptions(),
              onChanged: (value) {
                setState(() {
                  userInfo['mobile'] = value;
                  _mobileColor = Colors.green;
                });
              }),
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
                  userInfo['password2'] = value;
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
                // onPressed: () => _infoReady() ? _getInfo() : _infoNotReady(),
                onPressed: () {

                  if (_infoReady()) {
                    print(_getInfo());

                  } else {
                    _infoNotReady();
                  }
                },
                text: "REGISTER",
              ),
            ),
          ),
        ],
      ),
    );
  }
}

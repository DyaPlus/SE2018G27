library hms.globals;

import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

String domain = "http://192.168.1.104:8000/";

String token = "";
SharedPreferences prefs;
var tokenHeader = json.encode("'Authentication':'Token " + token);

Future setToken(String t) async {
  //prefs = await SharedPreferences.getInstance();
  token = t;
  await prefs.setString('token', token);
  print("setToken " + token);
  print(token.length);
}

Future getToken() async {
  token = prefs.getString('token');
  if (token == null) {
    token = "";
  }
  print("getToken $token");
  print(token.length);
}

Future deleteToken() async {
  //prefs = await SharedPreferences.getInstance();
  await prefs.remove('token');
  token = "";
  print("deleteToken " + token);
  print(token.length);
}

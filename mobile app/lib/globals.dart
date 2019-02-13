library hms.globals;

import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

String domain = "http://192.168.1.104:8000/";

String token = "";
var tokenHeader = json.encode("'Authentication':'Token " + token);

Future setToken(String t) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  token = t;
  await prefs.setString('token', token);
  print("setToken " + token);
  print(token.length);
}

Future getToken() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  token = prefs.getString('token');
  try {
    print("getToken $token");
    print(token.length);
  } catch (e) {
    print(e);
    token = "";
  }
  
}

Future deleteToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove('token');
  token = "";
  print("deleteToken " + token);
  print(token.length);
}

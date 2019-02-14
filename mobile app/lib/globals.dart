library hms.globals;

import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

String domain = "http://192.168.1.104:8000/";

String token = "";
SharedPreferences prefs;
Map<String, String> tokenHeader = {'Authorization': 'Token $token'};

Future setToken(String t) async {
  token = t;
  await prefs.setString('token', token);
}

Future getToken() async {
  token = prefs.getString('token');
  if (token == null) {
    token = "";
  }
}

Future deleteToken() async {
  await prefs.remove('token');
  token = "";
}

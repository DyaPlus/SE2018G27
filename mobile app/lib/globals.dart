library hms.globals;

import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

String domain = "https://secret-lowlands-85631.herokuapp.com/";

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

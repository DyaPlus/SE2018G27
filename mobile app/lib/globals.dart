library hms.globals;

import 'package:shared_preferences/shared_preferences.dart';

String domain = "https://secret-lowlands-85631.herokuapp.com/";

String token = "";
String fullName = " ";
String userName = " ";

SharedPreferences prefs;
Map<String, String> tokenHeader = {'Authorization': 'Token $token'};

Future setToken(String t) async {
  token = t;
  await prefs.setString('token', token);
  await prefs.setString('userName', userName);
  await prefs.setString('fullName', fullName);
}

Future getToken() async {
  token = prefs.getString('token');
  userName = prefs.getString('userName');
  fullName = prefs.getString('fullName');

  if (token == null) {
    token = "";
  }
  if (userName == null) {
    userName = " ";
  }
  if (fullName == null) {
    fullName = " ";
  }
}

Future deleteToken() async {
  await prefs.remove('token');
  await prefs.remove('userName');
  await prefs.remove('fullName');
  userName = " ";
  fullName = " ";
  token = "";
}

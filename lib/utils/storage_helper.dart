import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class StorageHelper {
  static void setLoggedIn(String email,String password) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('user', jsonEncode({"email": email, "password": password}));
  }

  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey('user');
  }
}

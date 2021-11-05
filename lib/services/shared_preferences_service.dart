import 'dart:async';
import 'dart:convert';

import 'package:app/models/User.dart';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  Future<void> saveUserToPrefs(User u) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var string = json.encode(u.toJson());
    await preferences.setString('user', string);
    print("[SharedPreferencesService]: user saved");
  }

  Future<void> removeUserFromPrefs() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.remove('user');
    if (loadUserFromPrefs() == null) {
      print("[SharedPreferencesService]: user removed");
    }
  }

  Future<User?> loadUserFromPrefs() async {
    print("[SharedPreferencesService]: loadUserFromPrefs() running");
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var string = preferences.getString('user');

    if (string != null) {
      Map map = json.decode(string);
      User u = User.fromJson(map);
      print("[SharedPreferencesService]: user loaded");
      return u;
    }
    print("[SharedPreferencesService]: user is null");
    return null;
  }
}

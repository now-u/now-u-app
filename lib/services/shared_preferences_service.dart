import 'dart:async';
import 'dart:convert';

import 'package:app/models/User.dart';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  Future<void> saveUserToPrefs(User u) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var string = json.encode(u.toJson());
    await preferences.setString('user', string);
    print("[SharedPreferencesService] - user saved");
  }

  Future<void> removeUserFromPrefs(User u) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var string = preferences.getString('user');
    print("Prefs user: " + string);
//    await preferences.remove('user');
  }

  Future<User> loadUserFromPrefs() async {
    print("loadUserFromPrefs() running");
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var string = preferences.getString('user');
    print("[SharedPreferencesService] - user string:  " + string.toString());

    if (string != null) {
      Map map = json.decode(string);
      User u = User.fromJson(map);
      return u;
    }
    return null;
  }
}

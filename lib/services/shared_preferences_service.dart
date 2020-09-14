import 'dart:async';
import 'dart:convert';

import 'package:app/models/User.dart';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {

  Future<void> saveUserToPrefs(User u) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var string = json.encode(u.toJson());
    await preferences.setString('user', string);
  }
  
  Future<User> loadUserFromPrefs() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var string = preferences.getString('user');
  
    if (string != null) {
      Map map = json.decode(string);
      User u = User.fromJson(map);
      return u;
    }
    return null;
  }
  
}

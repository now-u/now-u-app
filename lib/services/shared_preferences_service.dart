import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

const USER_TOKEN_KEY = "userToken";

class SharedPreferencesService {
  SharedPreferences? _instance;

  SharedPreferences _getInstance() {
    if (_instance == null) {
      throw Exception(
          "[SharedPreferencesService]: Instance accessed before initalized. Please ensure init is called before using the service.");
    }
    return _instance!;
  }

  Future<void> init() async {
    _instance = await SharedPreferences.getInstance();
  }

  Future<void> saveUserToken(String token) async {
    _getInstance().setString(USER_TOKEN_KEY, token);
    print("[SharedPreferencesService]: User token saved");
  }

  Future<void> clearUserToken() async {
    await _getInstance().remove(USER_TOKEN_KEY);
  }

  String? getUserToken() {
    print("[SharedPreferencesService]: Getting user token");
    return _getInstance().getString(USER_TOKEN_KEY);
  }
}

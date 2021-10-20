import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:app/models/User.dart';

class ApiError {
  static const UNAUTHORIZED = "unauthorized";
  static const INTERNAL = "internal";
  static const REQUEST = "request";
  static const UNKNOWN = "unknown";
  static const TOKEN_EXPIRED = "tokenExpired";
}

class ApiService {
  http.Client client = http.Client();

  String baseUrl = "api.now-u.com";
  String baseUrlPath = "api/v2/";
  
  User? _currentUser;
  User? get currentUser => _currentUser;
  bool get isAuthenticated => currentUser != null && currentUser!.token != null;
  
  Map<String, String> getRequestHeaders() {
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
    };
    if (isAuthenticated) {
      headers['token'] = currentUser!.token as String;
    }
    return headers;
  }

  Future<Map> getRequest(String path, {Map<String, dynamic>? params}) async {
    final uri = Uri.https(baseUrl, baseUrlPath + path, params ?? {});
    http.Response response = await client.get(
      uri,
      headers: getRequestHeaders(),
    );
      
    if (response.statusCode == 401) {
      throw ApiError.UNAUTHORIZED;
    }

    if (response.statusCode == 419) {
      throw ApiError.TOKEN_EXPIRED;
    }

    return await json.decode(response.body);
  }
}

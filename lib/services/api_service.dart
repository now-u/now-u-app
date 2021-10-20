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
  String baseUrl = "https://api.now-u.com/api/v2/";
  
  User? _currentUser;
  User? get currentUser => _currentUser;
  
  Map getRequestHeaders() {
    return <String, String?>{
      'Content-Type': 'application/json; charset=UTF-8',
      'token': currentUser!.getToken(),
    };
  }

  Future<Map?> getRequest(String path, {Map<String, dynamic>? params}) async {
    final uri = Uri.https(baseUrl, path, params);
    http.Response response = await http.get(
      uri,
      headers: getRequestHeaders() as Map<String, String>?
    );
      
    if (response.statusCode == 401) {
      throw ApiError.UNAUTHORIZED;
    }

    if (response.statusCode == 419) {
      throw ApiError.TOKEN_EXPIRED;
    }

    return json.decode(response.body);
  }
}

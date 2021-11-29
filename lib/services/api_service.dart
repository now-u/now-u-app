import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:app/models/User.dart';
import 'package:app/services/auth.dart';
import 'package:app/locator.dart';

/// Types of http errors
enum ApiExceptionType {
  UNAUTHORIZED,
  INTERNAL,
  REQUEST,
  UNKNOWN,
  TOKEN_EXPIRED
}

/// Exception for failed http requests
class ApiException implements Exception {
  ApiExceptionType type;
  int statusCode;

  ApiException({required this.type, required this.statusCode});
}

/// Map showing the translation from http response code to an
/// [ApiApiExceptionType]
Map<int, ApiExceptionType> responseCodeExceptionMapping = {
  401: ApiExceptionType.UNAUTHORIZED,
  419: ApiExceptionType.TOKEN_EXPIRED,
  500: ApiExceptionType.INTERNAL,
};

class ApiService {
  http.Client client = http.Client();

  /// Base of url (no slashes)
  String baseUrl = "api.now-u.com";

  /// The base path of the url (after the baseUrl)
  String baseUrlPath = "api/v2/";

  /// Generate appropriate [ApiException] from http response.
  ApiException getExceptionForResponse(http.Response response) {
    ApiExceptionType exceptionType =
        responseCodeExceptionMapping[response.statusCode] ??
            ApiExceptionType.UNKNOWN;
    return ApiException(type: exceptionType, statusCode: response.statusCode);
  }

  /// Get headers for standard API request
  ///
  /// If [AuthenticationService] says the user is authenticated the token will
  /// also be added to the headers.
  Map<String, String> getRequestHeaders() {
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
    };

    // If the user is logged in add their token to the request headers
    final AuthenticationService _authService = locator<AuthenticationService>();
    if (_authService.isAuthenticated) {
      // We know a token must exist as the user is authenticated
      headers['token'] = _authService.token!;
    }
    return headers;
  }

  /// Make get request to api
  ///
  /// Returns Map of the response. Throws an [ApiException] if the request is
  /// unsuccessful.
  Future<Map> getRequest(String path, {Map<String, dynamic>? params}) async {
    // Convert param values to strings
    Map<String, dynamic>? stringParams;
    if (params != null) {
      // Parse param values
      stringParams = Map.fromIterable(params.keys,
          key: (k) => k,
          value: (k) {
            dynamic value = params[k];
            // If the value is already iterable (this includes strings and lists)
            // return it
            if (value is List) {
              return "[" + value.map((item) => item.toString()).join(",") + "]";
            }
            if (value is Iterable) {
              return value;
            }
            // Otherwise cast it to a string
            return params[k].toString();
          });
    }

    final uri = Uri.https(baseUrl, baseUrlPath + path, stringParams);
    http.Response response = await client.get(
      uri,
      headers: getRequestHeaders(),
    );

    if (response.statusCode != 200) {
      throw getExceptionForResponse(response);
    }

    return await json.decode(response.body);
  }

  Future<List<Map<String, dynamic>>> getListRequest(String path, {Map<String, dynamic>? params}) async {
    Map response = await getRequest(path, params: params);
    List<Map<String, dynamic>> listData = new List<Map<String, dynamic>>.from(response["data"]);
    return listData;
  }

  /// Make post request to api
  ///
  /// Returns Map of the response. Throws an [ApiException] if the request is
  /// unsuccessful.
  Future<Map> postRequest(String path, {Map<String, dynamic>? body}) async {
    final uri = Uri.https(baseUrl, baseUrlPath + path);
    http.Response response = await client.post(
      uri,
      headers: getRequestHeaders(),
      body: body,
    );
     
    if (response.statusCode != 200) {
      throw getExceptionForResponse(response);
    }

    return await json.decode(response.body);
  }
}

import 'package:causeApiClient/causeApiClient.dart';
import 'package:dio/dio.dart';
import 'package:nowu/assets/constants.dart';
import 'package:sentry_dio/sentry_dio.dart';

// TODO Use causesApiClient generated auth interceptors
class AuthInterceptor extends Interceptor {
  String? token;

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    super.onRequest(options, handler);
  }
}

class ApiService {
  late AuthInterceptor _authInterceptor;

  CauseApiClient? _apiClient;

  CauseApiClient get apiClient {
    if (_apiClient == null) {
      throw Exception(
        'Cannot get api client before initalizing api service',
      );
    }
    return _apiClient!;
  }

  String get baseUrl => apiClient.dio.options.baseUrl;

  void init() {
    _authInterceptor = AuthInterceptor();

    final dio = Dio(
      BaseOptions(
        baseUrl: CAUSES_API_URL,
        headers: {
          'content-type': 'application/json',
          'Access-Control-Allow-Origin': 'true',
        },
      ),
    )
      ..addSentry
      ..interceptors.add(_authInterceptor)
      ..interceptors.add(LogInterceptor());
    _apiClient = CauseApiClient(
      dio: dio,
    );
  }

  void setToken(String? token) {
    _authInterceptor.token = token;
  }

  void setBaseUrl(String baseUrl) {
    apiClient.dio.options.baseUrl = baseUrl;
  }
}

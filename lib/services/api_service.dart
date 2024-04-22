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
  final AuthInterceptor _authInterceptor = AuthInterceptor();

  late final CauseApiClient _apiClient = _createClient();
  CauseApiClient _createClient() {
    final dio = Dio(
      BaseOptions(
        baseUrl: CAUSES_API_URL,
        headers: {
          'content-type': 'application/json',
          // 'Access-Control-Allow-Origin': 'true',
        },
      ),
    )
      ..addSentry
      ..interceptors.add(_authInterceptor)
      ..interceptors.add(LogInterceptor());

    return CauseApiClient(
      dio: dio,
    );
  }

  CauseApiClient get apiClient {
    return _apiClient;
  }

  String get baseUrl => apiClient.dio.options.baseUrl;

  void setToken(String? token) {
    _authInterceptor.token = token;
  }

  void setBaseUrl(String baseUrl) {
    apiClient.dio.options.baseUrl = baseUrl;
  }
}

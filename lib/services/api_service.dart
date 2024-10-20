import 'package:causeApiClient/causeApiClient.dart';
import 'package:dio/dio.dart';
import 'package:logging/logging.dart';
import 'package:nowu/assets/constants.dart';
import 'package:nowu/locator.dart';
import 'package:nowu/services/auth.dart';
import 'package:sentry_dio/sentry_dio.dart';

// TODO Use causesApiClient generated auth interceptors
class AuthInterceptor extends Interceptor {
  final _logger = Logger('AuthInterceptor');
  AuthInterceptor(this._authenticationService);
  AuthenticationService _authenticationService;

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = _authenticationService.token;
    if (token != null) {
      _logger.info('Bearer token: ${token}');
      options.headers['Authorization'] = 'Bearer $token';
    }
    _logger.info('Token is null');
    super.onRequest(options, handler);
  }
}

class ApiService {
  final _authenticationService = locator<AuthenticationService>();

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
      ..interceptors.add(AuthInterceptor(_authenticationService))
      ..interceptors.add(LogInterceptor())
      ..addSentry();

    return CauseApiClient(
      dio: dio,
    );
  }

  CauseApiClient get apiClient {
    return _apiClient;
  }

  String get baseUrl => apiClient.dio.options.baseUrl;

  void setBaseUrl(String baseUrl) {
    apiClient.dio.options.baseUrl = baseUrl;
  }
}

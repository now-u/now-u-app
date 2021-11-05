import 'package:http/http.dart' as http;

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import '../setup/test_helpers.mocks.dart';

import 'package:app/services/api_service.dart';
import 'package:app/services/auth.dart';
import '../setup/test_helpers.dart';
import 'api_service_test.mocks.dart';
import 'package:app/locator.dart';

// NOTE: this is how we can mock now

@GenerateMocks([AuthenticationService])
void main() {
  setupLocator();

  group('test getExceptionForResponse', () {
    void testExceptionForStatusCode(
        int statusCode, ApiExceptionType expectedType) {
      // getAndRegisterMockAnalyticsService();
      http.Response response = http.Response("", statusCode);
      ApiService apiService = ApiService();

      ApiException excpetion = apiService.getExceptionForResponse(response);
      expect(excpetion.type, expectedType);
      expect(excpetion.statusCode, statusCode);
    }

    test('UNAUTHORIZED when 401', () async {
      testExceptionForStatusCode(401, ApiExceptionType.UNAUTHORIZED);
    });

    test('TOKEN_EXPIRED when 419', () async {
      testExceptionForStatusCode(419, ApiExceptionType.TOKEN_EXPIRED);
    });
  });

  group('test getRequestHeaders', () {
    test('unauthenticated', () async {
      ApiService apiService = ApiService();
      expect(apiService.getRequestHeaders(), {
        'Content-Type': 'application/json; charset=UTF-8',
      });
    });

    test('authenticated', () async {
      // Mock auth service
      var mockAuthService = MockAuthenticationService();
      registerMock<AuthenticationService>(mockAuthService);

      // to show authenticated user
      when(mockAuthService.isAuthenticated).thenReturn(true);
      when(mockAuthService.token).thenReturn("abc");

      ApiService apiService = ApiService();

      // Expect token to be included in the response
      expect(apiService.getRequestHeaders(), {
        'Content-Type': 'application/json; charset=UTF-8',
        'token': 'abc',
      });
    });
  });

  group('test getRequest', () {
    test('without parameters', () async {
      ApiService apiService = ApiService();
      MockClient client = mockHttpClient(apiService);

      when(client.get(any, headers: anyNamed("headers"))).thenAnswer(
          (_) => Future.value(http.Response('{"abc": "def"}', 200)));

      Map response = await apiService.getRequest("causes/stuff");
      expect(response, {"abc": "def"});

      verify(client.get(Uri.parse("https://api.now-u.com/api/v2/causes/stuff"),
              headers: anyNamed("headers")))
          .called(1);
    });

    test('with parameters', () async {
      ApiService apiService = ApiService();
      MockClient client = mockHttpClient(apiService);

      when(client.get(any, headers: anyNamed("headers"))).thenAnswer(
          (_) => Future.value(http.Response('{"abc": "def"}', 200)));

      Map response = await apiService
          .getRequest("causes/stuff", params: {"limit": 10, "fav": true});
      expect(response, {"abc": "def"});

      verify(client.get(
              Uri.parse(
                  "https://api.now-u.com/api/v2/causes/stuff?limit=10&fav=true"),
              headers: anyNamed("headers")))
          .called(1);
    });

    test('with list parameters', () async {
      ApiService apiService = ApiService();
      MockClient client = mockHttpClient(apiService);

      when(client.get(any, headers: anyNamed("headers")))
          .thenAnswer((_) => Future.value(http.Response('{}', 200)));

      await apiService.getRequest("causes/stuff", params: {
        "causes": [1, 2]
      });
      verify(client.get(
              Uri.parse(
                  "https://api.now-u.com/api/v2/causes/stuff?causes=%5B1%2C2%5D"),
              headers: anyNamed("headers")))
          .called(1);
    });
  });
}

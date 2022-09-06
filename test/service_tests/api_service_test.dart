import 'package:http/http.dart' as http;
import 'dart:convert';

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
  ApiService apiService = ApiService();
  apiService.baseUrl = "example.com";
  apiService.baseUrlPath = "api/";

  group('test getExceptionForResponse', () {
    void testExceptionForStatusCode(
        int statusCode, ApiExceptionType expectedType) {
      // getAndRegisterMockAnalyticsService();
      http.Response response = http.Response("", statusCode);

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

      // Expect token to be included in the response
      expect(apiService.getRequestHeaders(), {
        'Content-Type': 'application/json; charset=UTF-8',
        'token': 'abc',
      });
    });
  });

  group('test getRequest', () {
    test('without parameters', () async {
      MockClient client = mockHttpClient(apiService);

      when(client.get(any, headers: anyNamed("headers"))).thenAnswer(
          (_) => Future.value(http.Response('{"abc": "def"}', 200)));

      Map response = await apiService.getRequest("causes/stuff");
      expect(response, {"abc": "def"});

      verify(client.get(Uri.parse("https://example.com/api/causes/stuff"),
              headers: anyNamed("headers")))
          .called(1);
    });

    test('with parameters', () async {
      MockClient client = mockHttpClient(apiService);

      when(client.get(any, headers: anyNamed("headers"))).thenAnswer(
          (_) => Future.value(http.Response('{"abc": "def"}', 200)));

      Map response = await apiService
          .getRequest("causes/stuff", params: {"limit": 10, "fav": true});
      expect(response, {"abc": "def"});

      verify(client.get(
              Uri.parse(
                  "https://example.com/api/causes/stuff?limit=10&fav=true"),
              headers: anyNamed("headers")))
          .called(1);
    });

    test('with list parameters', () async {
      MockClient client = mockHttpClient(apiService);

      when(client.get(any, headers: anyNamed("headers")))
          .thenAnswer((_) => Future.value(http.Response('{}', 200)));

      await apiService.getRequest("causes/stuff", params: {
        "causes": [1, 2]
      });
      verify(client.get(
              Uri.parse(
                  "https://example.com/api/causes/stuff?causes=%5B1%2C2%5D"),
              headers: anyNamed("headers")))
          .called(1);
    });
  });

  group('test postRequest', () {
    test('without parameters', () async {
      MockClient client = mockHttpClient(apiService);

      when(client.post(any,
              headers: anyNamed("headers"), body: anyNamed("body")))
          .thenAnswer(
              (_) => Future.value(http.Response('{"abc": "def"}', 200)));

      Map response =
          await apiService.postRequest("test", body: {"test": "payload"});
      expect(response, {"abc": "def"});
      verify(client.post(Uri.parse("https://example.com/api/test"),
              headers: anyNamed("headers"),
              body: json.encode({"test": "payload"}),
              encoding: null))
          .called(1);
    });
  });

  group('test getModelRequest', () {});

  group('test getModelListRequest', () {});
}

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:nowu/services/api_service.dart';
import 'package:nowu/services/auth.dart';
import '../setup/test_helpers.dart';
import 'package:nowu/app/app.locator.dart';

class MockAuthenticationService extends Mock implements AuthenticationService {}

class MockHttpClient extends Mock implements http.Client {}

class UriFake extends Fake implements Uri {}

void main() {
  late AuthenticationService mockAuthService;
  late http.Client mockHttpClient;
  late ApiService apiService;

  setUpAll(() {
    registerFallbackValue(UriFake());
  });

  setUp(() {
    locator.reset();
    setupLocator();
    mockAuthService = MockAuthenticationService();
    registerMock<AuthenticationService>(mockAuthService);

    mockHttpClient = MockHttpClient();
    apiService = ApiService(mockHttpClient);
  });

  group('test getExceptionForResponse', () {
    void testExceptionForStatusCode(
      int statusCode,
      ApiExceptionType expectedType,
    ) {
      // getAndRegisterMockAnalyticsService();
      http.Response response = http.Response('', statusCode);

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
      when(() => mockAuthService.isAuthenticated).thenReturn(false);
      expect(apiService.getRequestHeaders(), {
        'Content-Type': 'application/json; charset=UTF-8',
      });
    });

    test('authenticated', () async {
      // Mock auth service
      // to show authenticated user
      when(() => mockAuthService.isAuthenticated).thenReturn(true);
      when(() => mockAuthService.token).thenReturn('abc');

      // Expect token to be included in the response
      expect(apiService.getRequestHeaders(), {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'JWT abc',
      });
    });
  });

  group('test getRequest', () {
    test('without parameters', () async {
      when(() => mockAuthService.isAuthenticated).thenReturn(false);
      when(() => mockHttpClient.get(any(), headers: any(named: 'headers')))
          .thenAnswer(
        (_) => Future.value(http.Response('{"abc": "def"}', 200)),
      );

      Map response = await apiService.getRequest('causes/stuff');
      expect(response, {'abc': 'def'});

      verify(
        () => mockHttpClient.get(
          Uri.parse('https://staging.api.now-u.com/api/causes/stuff'),
          headers: any(named: 'headers'),
        ),
      ).called(1);
    });

    test('with parameters', () async {
      when(() => mockAuthService.isAuthenticated).thenReturn(false);
      when(() => mockHttpClient.get(any(), headers: any(named: 'headers')))
          .thenAnswer(
        (_) => Future.value(http.Response('{"abc": "def"}', 200)),
      );

      Map response = await apiService
          .getRequest('causes/stuff', params: {'limit': 10, 'fav': true});
      expect(response, {'abc': 'def'});

      verify(
        () => mockHttpClient.get(
          Uri.parse(
            'https://staging.api.now-u.com/api/causes/stuff?limit=10&fav=true',
          ),
          headers: any(named: 'headers'),
        ),
      ).called(1);
    });

    test('with list parameters', () async {
      when(() => mockAuthService.isAuthenticated).thenReturn(false);
      when(() => mockHttpClient.get(any(), headers: any(named: 'headers')))
          .thenAnswer((_) => Future.value(http.Response('{}', 200)));

      await apiService.getRequest(
        'causes/stuff',
        params: {
          'causes': [1, 2]
        },
      );
      verify(
        () => mockHttpClient.get(
          Uri.parse(
            'https://staging.api.now-u.com/api/causes/stuff?causes=%5B1%2C2%5D',
          ),
          headers: any(named: 'headers'),
        ),
      ).called(1);
    });
  });

  group('test postRequest', () {
    test('without parameters', () async {
      when(() => mockAuthService.isAuthenticated).thenReturn(false);
      when(
        () => mockHttpClient.post(
          any(),
          headers: any(named: 'headers'),
          body: any(named: 'body'),
        ),
      ).thenAnswer(
        (_) => Future.value(http.Response('{"abc": "def"}', 200)),
      );

      Map response =
          await apiService.postRequest('test', body: {'test': 'payload'});
      expect(response, {'abc': 'def'});
      verify(
        () => mockHttpClient.post(
          Uri.parse('https://staging.api.now-u.com/api/test'),
          headers: any(named: 'headers'),
          body: json.encode({'test': 'payload'}),
          encoding: null,
        ),
      ).called(1);
    });
  });

  group('test getModelRequest', () {});

  group('test getModelListRequest', () {});
}

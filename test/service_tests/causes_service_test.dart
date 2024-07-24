import 'package:built_collection/built_collection.dart';
import 'package:causeApiClient/causeApiClient.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nowu/services/analytics.dart';
import 'package:nowu/services/api_service.dart';
import 'package:nowu/services/auth.dart';
import 'package:nowu/services/causes_service.dart' hide Cause;
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:test/test.dart';

class MockAuthenticationService extends Mock implements AuthenticationService {
  @override
  bool get isAuthenticated => false;

  @override
  Stream<AuthState> get authState => const Stream.empty();
}

class MockAnalyticsService extends Mock implements AnalyticsService {}

class MockApiClientCausesApi extends Mock implements CausesApi {}

class MockApiClient extends Mock implements CauseApiClient {
  final mockCauesApi = MockApiClientCausesApi();

  @override
  MockApiClientCausesApi getCausesApi() {
    return mockCauesApi;
  }
}

class MockApiService extends Mock implements ApiService {
  final MockApiClient client;

  MockApiService(this.client);

  @override
  MockApiClient get apiClient => client;
}

class MockCause extends Mock implements Cause {
  @override
  int get id => 1;

  @override
  String get title => 'Test Cause';

  @override
  String get description => 'Test Description';

  @override
  Image get headerImage => Image(
        (b) => b
          ..id = 2
          ..url = 'https://example.com/image.jpg',
      );

  @override
  IconEnum get icon => IconEnum.economicOpportunity;
}

void main() {
  GetIt locator = GetIt.instance;
  late MockApiClient mockApiClient;

  group('CausesService', () {
    setUpAll(() async {
      mockApiClient = MockApiClient();

      locator.registerLazySingleton<AuthenticationService>(
        () => MockAuthenticationService(),
      );
      // TODO Mock to do nothing
      locator.registerLazySingleton<AnalyticsService>(
        () => MockAnalyticsService(),
      );
      // TODO Mock to return mocked causesApiClient
      locator.registerLazySingleton<ApiService>(
        () => MockApiService(mockApiClient),
      );
      locator.registerLazySingleton<CausesService>(() => CausesService());
    });

    test('Get causes', () async {
      when(() => mockApiClient.getCausesApi().causesList()).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: ''),
          data: BuiltList<Cause>(
            [
              MockCause(),
            ],
          ),
          statusCode: 200,
        ),
      );

      final causesService = locator<CausesService>();
      final causes = await causesService.listCauses();
      // verify(mockApiClient.getCausesApi().causesList());

      expect(causes.length, greaterThan(0));
    });
  });
}

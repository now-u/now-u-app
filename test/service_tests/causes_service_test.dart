import 'package:causeApiClient/causeApiClient.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nowu/services/analytics.dart';
import 'package:nowu/services/api_service.dart';
import 'package:nowu/services/auth.dart';
import 'package:nowu/services/causes_service.dart';
import 'package:test/test.dart';

class MockAuthenticationService extends Mock implements AuthenticationService {
  @override
  bool get isAuthenticated => false;
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
      final causesService = locator<CausesService>();
      final causes = await causesService.listCauses();

      verify(mockApiClient.getCausesApi().causesList());
      expect(causes.length, greaterThan(0));
    });
  });
}

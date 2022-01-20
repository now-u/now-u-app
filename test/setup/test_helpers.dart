import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'dart:io';

import 'package:app/locator.dart';
import 'package:app/services/navigation_service.dart';
import 'package:app/services/dialog_service.dart';
import 'package:app/services/api_service.dart';
import 'test_helpers.mocks.dart';

import 'package:app/services/analytics.dart';
import 'package:app/services/google_location_search_service.dart';

Map<String, String> unauthenticatedHeaders = {
  "Content-Type": "application/json; charset=UTF-8"
};

@GenerateMocks([http.Client])
MockClient mockHttpClient(ApiService service) {
  MockClient mockClient = MockClient();
  service.client = mockClient;
  return mockClient;
}

Future<String> readTestData(String fileName,
    {String filePath = "assets/json/"}) async {
  final file = File(filePath + fileName);
  return await file.readAsString();
}

class MockNavigationService extends Mock implements NavigationService {
  Future<dynamic> navigateTo(String route, {arguments}) async {
    return route;
  }
}

NavigationService getAndRegisterMockNavigationService() {
  _removeRegistrationIfExists<NavigationService>();
  var service = MockNavigationService();
  locator.registerSingleton<NavigationService>(service);
  return service;
}

class MockDialogService extends Mock implements DialogService {}

DialogService getAndRegisterMockDialogService() {
  _removeRegistrationIfExists<DialogService>();
  var service = MockDialogService();
  locator.registerSingleton<DialogService>(service);
  return service;
}

class MockGoogleLocationSearchService extends Mock
    implements GoogleLocationSearchService {}

GoogleLocationSearchService getAndRegisterMockGoogleLocationSearchService() {
  _removeRegistrationIfExists<GoogleLocationSearchService>();
  var service = MockGoogleLocationSearchService();
  locator.registerSingleton<GoogleLocationSearchService>(service);
  return service;
}

class MockAnalyticsService extends Mock implements AnalyticsService {}

AnalyticsService getAndRegisterMockAnalyticsService() {
  _removeRegistrationIfExists<AnalyticsService>();
  var service = MockAnalyticsService();
  locator.registerSingleton<AnalyticsService>(service);
  return service;
}

void _removeRegistrationIfExists<T extends Object>() {
  if (locator.isRegistered<T>()) {
    locator.unregister<T>();
  }
}

void registerMock<T extends Object>(T service) {
  _removeRegistrationIfExists<T>();
  locator.registerSingleton<T>(service);
}

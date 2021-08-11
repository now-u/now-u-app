import 'package:mockito/mockito.dart';

import 'package:app/locator.dart';
import 'package:app/services/navigation_service.dart';
import 'package:app/services/dialog_service.dart';

import 'package:app/services/analytics.dart';
import 'package:app/services/auth.dart';
import 'package:app/services/google_location_search_service.dart';

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

class MockAuthenticationService extends Mock implements AuthenticationService {}

AuthenticationService getAndRegisterMockAuthentiactionService() {
  _removeRegistrationIfExists<AuthenticationService>();
  var service = MockAuthenticationService();
  locator.registerSingleton<AuthenticationService>(service);
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

void _removeRegistrationIfExists<T>() {
  if (locator.isRegistered<T>()) {
    locator.unregister<T>();
  }
}

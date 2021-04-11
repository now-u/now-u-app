import 'package:mockito/mockito.dart';

import 'package:app/locator.dart';
import 'package:app/services/navigation_service.dart';
import 'package:app/services/dialog_service.dart';
import 'package:app/services/analytics.dart';
import 'package:app/services/auth.dart';

class MockNavigationService extends Mock implements NavigationService {
  Future<dynamic> navigateTo(String route, {arguments}) async {
    return route; 
  }
}
NavigationService getAndRegisterMockNavigationService() {
  _removeRegistrationIfExists<NavigationService>();
  var service = MockNavigationService();
  locator.registerSingleton<NavigationService>(service);
  locator.resetLazySingleton<NavigationService>();
  return service;
}

class MockAuthenticationService extends Mock implements AuthenticationService {}
AuthenticationService getAndRegisterMockAuthentiactionService() {
  _removeRegistrationIfExists<AuthenticationService>();
  var service = MockAuthenticationService();
  locator.registerSingleton<AuthenticationService>(service);
  locator.resetLazySingleton<AuthenticationService>();
  return service;
}

class MockDialogService extends Mock implements DialogService {}
DialogService getAndRegisterMockDialogService() {
  _removeRegistrationIfExists<DialogService>();
  var service = MockDialogService();
  locator.registerSingleton<DialogService>(service);
  locator.resetLazySingleton<DialogService>();
  return service;
}

class MockAnalyticsService extends Mock implements AnalyticsService {}
AnalyticsService getAndRegisterMockAnalyticsService() {
  _removeRegistrationIfExists<AnalyticsService>();
  var service = MockAnalyticsService();
  locator.registerSingleton<AnalyticsService>(service);
  locator.resetLazySingleton<AnalyticsService>();
  return service;
}

void _removeRegistrationIfExists<T>() {
  if (locator.isRegistered<T>()) {
    locator.unregister<T>();
  }
}

void setupTestLocator() {
  setupLocator();
  locator.allowReassignment = true;
  // By default we want the navigation_service to be mocked
  getAndRegisterMockNavigationService();
}

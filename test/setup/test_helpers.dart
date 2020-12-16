import 'package:mockito/mockito.dart';

import 'package:app/locator.dart';
import 'package:app/services/navigation_service.dart';
import 'package:app/services/auth.dart';

class NavigationServiceMock extends Mock implements NavigationService {
  Future<dynamic> navigateTo(String route, {arguments}) async {
    return route; 
  }
}

class MockAuthenticationService extends Mock implements AuthenticationService {}

NavigationService getAndRegisterNavigationServiceMock() {
  _removeRegistrationIfExists<NavigationService>();
  var service = NavigationServiceMock();
  locator.registerSingleton<NavigationService>(service);
  return service;
}

AuthenticationService mockAuthenticationService() {
  _removeRegistrationIfExists<AuthenticationService>();
  var service = MockAuthenticationService();
  locator.registerSingleton<AuthenticationService>(service);
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
}

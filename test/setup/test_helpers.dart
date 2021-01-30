import 'package:mockito/mockito.dart';

import 'package:app/locator.dart';
import 'package:app/services/navigation_service.dart';
import 'package:app/services/dialog_service.dart';
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

void _removeRegistrationIfExists<T>() {
  if (locator.isRegistered<T>()) {
    locator.unregister<T>();
  }
}

void setupTestLocator() {
  setupLocator();
  locator.allowReassignment = true;
}

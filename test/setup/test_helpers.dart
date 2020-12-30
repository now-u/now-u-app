import 'package:mockito/mockito.dart';

import 'package:app/locator.dart';
import 'package:app/services/navigation_service.dart';
import 'package:app/services/dialog_service.dart';
import 'package:app/services/auth.dart';

class NavigationServiceMock extends Mock implements NavigationService {
  Future<dynamic> navigateTo(String route, {arguments}) async {
    return route; 
  }
}
NavigationService setupMockNavigationService() {
  _removeRegistrationIfExists<NavigationService>();
  var service = NavigationServiceMock();
  locator.registerSingleton<NavigationService>(service);
  return service;
}

class MockAuthenticationService extends Mock implements AuthenticationService {}
AuthenticationService setupMockAuthenticationService() {
  _removeRegistrationIfExists<AuthenticationService>();
  var service = MockAuthenticationService();
  locator.registerSingleton<AuthenticationService>(service);
  return service;
}
        
class FakeDialogService extends Fake implements DialogService {
  @override
  Future showDialog({
    String title,
    String description,
    List buttons,
  }) {
    return Future.value(AlertResponse(response: true));
  }
}
DialogService setupFakeDialogService() {
  _removeRegistrationIfExists<DialogService>();
  var service = FakeDialogService();
  locator.registerSingleton<DialogService>(service);
  return service;
}

class MockDialogService extends Mock implements DialogService {}
DialogService setupMockDialogService() {
  _removeRegistrationIfExists<DialogService>();
  var service = MockDialogService();
  locator.registerSingleton<DialogService>(service);
 
  // Reset dependancies
  locator.resetLazySingleton<NavigationService>();
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

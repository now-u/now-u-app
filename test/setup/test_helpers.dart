import 'package:flutter/services.dart';
import 'package:mockito/mockito.dart';

import 'package:app/locator.dart';
import 'package:app/services/navigation_service.dart';
import 'package:app/services/dialog_service.dart';
import 'package:app/services/auth.dart';

class MockNavigationService extends Mock implements NavigationService {}

class FakeNavigationService extends Fake with NavigationService {
  @override
  Future<dynamic> navigateTo(String routeName, {arguments}) {
    return Future.value(routeName);
  }
}

NavigationService setupMockNavigationService({bool isFake}) {
  _removeRegistrationIfExists<NavigationService>();
  if (isFake) {
    var service = FakeNavigationService();
    locator.registerSingleton<NavigationService>(service);
    return service;
  } else {
    var service = MockNavigationService();
    locator.registerSingleton<NavigationService>(service);
    return service;
  }
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
  return service;
}

void _removeRegistrationIfExists<T>() {
  if (locator.isRegistered<T>()) {
    locator.unregister<T>();
  }
}

void _resetRegistractionIfExists<T>() {
  if (locator.isRegistered<T>()) {
    locator.resetLazySingleton<T>();
  }
}

void setupTestLocator() {
  setupLocator();
  locator.allowReassignment = true;
}

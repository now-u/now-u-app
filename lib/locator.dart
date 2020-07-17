import 'package:app/services/api.dart';
import 'package:app/services/httpApi.dart';
import 'package:app/services/jsonApi.dart';
import 'package:app/services/dynamicLinks.dart';
import 'package:app/services/auth.dart';
import 'package:app/services/storage.dart';
import 'package:app/services/analytics.dart';
import 'package:app/services/pushNotifications.dart';

import 'package:get_it/get_it.dart';

/* This allows us to create a fake api if we wish */

GetIt locator = GetIt.instance;

const bool USE_FAKE_API = false;

void setupLocator() {
  // Currently just return httpApi cause im too lazy but might come in handy
  locator.registerLazySingleton<Api>(() => USE_FAKE_API ? JsonApi() : HttpApi());
  locator.registerLazySingleton(() => DynamicLinkService());
  locator.registerLazySingleton<AuthenticationService>(() => AuthenticationService());
  locator.registerLazySingleton<SecureStorageService>(() => SecureStorageService());
  locator.registerLazySingleton<Analytics>(() => Analytics());
  locator.registerLazySingleton(() => PushNotificationsService());
}



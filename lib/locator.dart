import 'package:app/services/dynamicLinks.dart';
import 'package:app/services/auth.dart';
import 'package:app/services/fake/fake_news_service.dart';
import 'package:app/services/storage.dart';
import 'package:app/services/analytics.dart';
import 'package:app/services/pushNotifications.dart';
import 'package:app/services/navigation_service.dart';
import 'package:app/services/news_service.dart';
import 'package:app/services/faq_service.dart';
import 'package:app/services/shared_preferences_service.dart';
import 'package:app/services/internal_notification_service.dart';
import 'package:app/services/device_info_service.dart';
import 'package:app/services/dialog_service.dart';
import 'package:app/services/google_location_search_service.dart';
import 'package:app/services/remote_config_service.dart';
import 'package:app/services/organisation_service.dart';
import 'package:app/services/api_service.dart';
import 'package:app/services/causes_service.dart';

import 'package:app/assets/constants.dart' as constants;

import 'package:app/services/fake/fake_causes_service.dart';

import 'package:http/http.dart' as http;
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';

/* This allows us to create a fake api if we wish */
GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => NavigationService(
      new GlobalKey<NavigatorState>(),
      new UrlLauncher(),
      new CustomChromeSafariBrowser()));
  locator.registerLazySingleton(() => SecureStorageService());
  locator.registerLazySingleton(() => SharedPreferencesService());
  locator.registerLazySingleton(() => AuthenticationService());
  locator.registerLazySingleton(
      () => constants.devMode ? FakeNewsService() : NewsService());
  locator.registerLazySingleton(() => FAQService());
  locator.registerLazySingleton(() => InternalNotificationService());
  locator.registerLazySingleton(() => DeviceInfoService());
  locator.registerLazySingleton(() => DialogService());
  locator.registerLazySingleton(() => GoogleLocationSearchService());
  locator.registerLazySingleton(() => OrganisationService());
  locator.registerLazySingleton(() => AnalyticsService());
  // locator.registerLazySingleton(() => constants.devMode ? FakeCausesService() : CausesService());
  locator.registerLazySingleton(() => CausesService());
  locator.registerLazySingleton(() => ApiService(new http.Client()));
}

void registerFirebaseServicesToLocator() {
  locator.registerLazySingleton(() => PushNotificationService());
  locator.registerLazySingleton(() => DynamicLinkService());
  locator.registerLazySingleton(() => RemoteConfigService());
}

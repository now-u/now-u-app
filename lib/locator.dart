import 'package:nowu/router.dart';
import 'package:nowu/services/dynamicLinks.dart';
import 'package:nowu/services/auth.dart';
import 'package:nowu/services/navigation_service.dart';
import 'package:nowu/services/search_service.dart';
import 'package:nowu/services/storage.dart';
import 'package:nowu/services/analytics.dart';
import 'package:nowu/services/pushNotifications.dart';
import 'package:nowu/services/faq_service.dart';
import 'package:nowu/services/internal_notification_service.dart';
import 'package:nowu/services/device_info_service.dart';
import 'package:nowu/services/google_location_search_service.dart';
import 'package:nowu/services/remote_config_service.dart';
import 'package:nowu/services/api_service.dart';
import 'package:nowu/services/causes_service.dart';

import 'package:nowu/services/user_service.dart';

import 'package:get_it/get_it.dart';

/* This allows us to create a fake api if we wish */
GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => SecureStorageService());
  locator.registerLazySingleton(() => AuthenticationService());
  locator.registerLazySingleton(() => UserService());
  locator.registerLazySingleton(() => FAQService());
  locator.registerLazySingleton(() => InternalNotificationService());
  locator.registerLazySingleton(() => DeviceInfoService());
  locator.registerLazySingleton(() => GoogleLocationSearchService());
  locator.registerLazySingleton(() => AnalyticsService());
  locator.registerLazySingleton(() => CausesService());
  locator.registerLazySingleton(() => ApiService());
  locator.registerLazySingleton(() => SearchService());
  locator.registerLazySingleton(() => AppRouter());
  locator.registerLazySingleton(() => CustomChromeSafariBrowser());
  locator.registerLazySingleton(() => PushNotificationService());
  locator.registerLazySingleton(() => DynamicLinkService());
  locator.registerLazySingleton(() => RemoteConfigService());
}

import 'package:nowu/services/dynamicLinks.dart';
import 'package:nowu/services/auth.dart';
import 'package:nowu/services/search_service.dart';
import 'package:nowu/services/storage.dart';
import 'package:nowu/services/analytics.dart';
import 'package:nowu/services/pushNotifications.dart';
import 'package:nowu/services/faq_service.dart';
import 'package:nowu/services/shared_preferences_service.dart';
import 'package:nowu/services/internal_notification_service.dart';
import 'package:nowu/services/device_info_service.dart';
import 'package:nowu/services/dialog_service.dart';
import 'package:nowu/services/google_location_search_service.dart';
import 'package:nowu/services/remote_config_service.dart';
import 'package:nowu/services/api_service.dart';
import 'package:nowu/services/causes_service.dart';

import 'package:nowu/services/superbase.dart';
import 'package:nowu/services/user_service.dart';

import 'package:get_it/get_it.dart';

/* This allows us to create a fake api if we wish */
GetIt locator = GetIt.instance;

void setupLocator() {
  // locator.registerLazySingleton(() => NavigationService(
  //     GlobalKey<NavigatorState>(), UrlLauncher(), CustomChromeSafariBrowser()));
  locator.registerLazySingleton(() => SecureStorageService());
  locator.registerLazySingleton(() => SharedPreferencesService());
  locator.registerLazySingleton(() => AuthenticationService());
  locator.registerLazySingleton(() => UserService());
  locator.registerLazySingleton(() => FAQService());
  locator.registerLazySingleton(() => InternalNotificationService());
  locator.registerLazySingleton(() => DeviceInfoService());
  locator.registerLazySingleton(() => DialogService());
  locator.registerLazySingleton(() => GoogleLocationSearchService());
  locator.registerLazySingleton(() => AnalyticsService());
  locator.registerLazySingleton(() => CausesService());
  locator.registerLazySingleton(() => ApiService());
  locator.registerLazySingleton(() => SupabaseService());
  locator.registerLazySingleton(() => SearchService());
  // TODO This is super temporary, we should use the stacked auto generated router
}

void registerFirebaseServicesToLocator() {
  locator.registerLazySingleton(() => PushNotificationService());
  locator.registerLazySingleton(() => DynamicLinkService());
  locator.registerLazySingleton(() => RemoteConfigService());
}

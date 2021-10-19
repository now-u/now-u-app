import 'package:app/services/dynamicLinks.dart';
import 'package:app/services/auth.dart';
import 'package:app/services/storage.dart';
import 'package:app/services/analytics.dart';
import 'package:app/services/pushNotifications.dart';
import 'package:app/services/navigation_service.dart';
import 'package:app/services/news_service.dart';
import 'package:app/services/campaign_service.dart';
import 'package:app/services/faq_service.dart';
import 'package:app/services/shared_preferences_service.dart';
import 'package:app/services/internal_notification_service.dart';
import 'package:app/services/device_info_service.dart';
import 'package:app/services/dialog_service.dart';
import 'package:app/services/google_location_search_service.dart';
import 'package:app/services/remote_config_service.dart';
import 'package:app/services/organisation_service.dart';
import 'package:app/services/causes_service.dart';

import 'package:get_it/get_it.dart';

/* This allows us to create a fake api if we wish */

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => CampaignService());
  locator.registerLazySingleton(() => SecureStorageService());
  locator.registerLazySingleton(() => SharedPreferencesService());
  locator.registerLazySingleton(() => AuthenticationService());
  locator.registerLazySingleton(() => NewsService());
  locator.registerLazySingleton(() => FAQService());
  locator.registerLazySingleton(() => InternalNotificationService());
  locator.registerLazySingleton(() => DeviceInfoService());
  locator.registerLazySingleton(() => DialogService());
  locator.registerLazySingleton(() => GoogleLocationSearchService());
  locator.registerLazySingleton(() => OrganisationService());
  locator.registerLazySingleton(() => AnalyticsService());
  locator.registerLazySingleton(() => CausesService());
}

void registerFirebaseServicesToLocator() {
  locator.registerLazySingleton(() => PushNotificationService());
  locator.registerLazySingleton(() => DynamicLinkService());
  locator.registerLazySingleton(() => RemoteConfigService());
}

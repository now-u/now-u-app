// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedLocatorGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs, implementation_imports, depend_on_referenced_packages

import 'package:stacked_services/src/bottom_sheet/bottom_sheet_service.dart';
import 'package:stacked_services/src/dialog/dialog_service.dart';
import 'package:stacked_services/src/navigation/router_service.dart';
import 'package:stacked_shared/stacked_shared.dart';

import '../services/analytics.dart';
import '../services/api_service.dart';
import '../services/auth.dart';
import '../services/causes_service.dart';
import '../services/dynamicLinks.dart';
import '../services/faq_service.dart';
import '../services/internal_notification_service.dart';
import '../services/navigation_service.dart';
import '../services/pushNotifications.dart';
import '../services/search_service.dart';
import '../services/shared_preferences_service.dart';
import '../services/storage.dart';
import '../services/user_service.dart';
import 'app.router.dart';

final locator = StackedLocator.instance;

Future<void> setupLocator({
  String? environment,
  EnvironmentFilter? environmentFilter,
  StackedRouterWeb? stackedRouter,
}) async {
// Register environments
  locator.registerEnvironment(
      environment: environment, environmentFilter: environmentFilter,);

// Register dependencies
  locator.registerLazySingleton(() => BottomSheetService());
  locator.registerLazySingleton(() => RouterService());
  locator.registerLazySingleton(() => CausesService());
  locator.registerLazySingleton(() => SearchService());
  locator.registerLazySingleton(() => SecureStorageService());
  locator.registerLazySingleton(() => SharedPreferencesService());
  locator.registerLazySingleton(() => AuthenticationService());
  locator.registerLazySingleton(() => UserService());
  locator.registerLazySingleton(() => FAQService());
  locator.registerLazySingleton(() => PushNotificationService());
  locator.registerLazySingleton(() => DynamicLinkService());
  locator.registerLazySingleton(() => AnalyticsService());
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => DialogService());
  locator.registerLazySingleton(() => ApiService());
  locator.registerLazySingleton(() => InternalNotificationService());
  if (stackedRouter == null) {
    throw Exception(
        'Stacked is building to use the Router (Navigator 2.0) navigation but no stackedRouter is supplied. Pass the stackedRouter to the setupLocator function in main.dart',);
  }

  locator<RouterService>().setRouter(stackedRouter);
}

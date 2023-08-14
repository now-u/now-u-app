import 'package:logging/logging.dart';
import 'package:flutter/foundation.dart';
import 'package:nowu/app/app.locator.dart';
import 'package:nowu/services/causes_service.dart';
import 'package:nowu/services/dynamicLinks.dart';
import 'package:nowu/services/pushNotifications.dart';
import 'package:nowu/services/router_service.dart';
import 'package:nowu/services/shared_preferences_service.dart';
import 'package:nowu/services/superbase.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:nowu/services/user_service.dart';
import 'package:nowu/utils/require.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:stacked/stacked.dart';

class StartupViewModel extends BaseViewModel {
  final _routerService = locator<RouterService>();
  final _logger = Logger('StartupViewModel');

  // TODO Add retires on error with backoff
  Future handleStartUpLogic() async {
    final sentry_transaction =
        Sentry.startTransaction('StartupViewModel', 'handleStartUpLogic');
    _logger.info('handleStartUpLogic starting');

    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

    final _userService = locator<UserService>();

    print('Initing superbase service');

    // TODO Cannot be done offline! Maybe try catch this for now and skip login if fails??
    final _supabaseService = locator<SupabaseService>();
    await _supabaseService.init();

    print('Inited superbase service');

    final isMobile = defaultTargetPlatform == TargetPlatform.iOS ||
        defaultTargetPlatform == TargetPlatform.android;

    // TODO Only setup for android and ios
    if (isMobile) {
      final _dynamicLinkService = locator<DynamicLinkService>();
      await _dynamicLinkService.handleDynamicLinks();

      // Register for push notifications
      final _pushNotificationService = locator<PushNotificationService>();
      await _pushNotificationService.init();
    }

    // TODO Remove if unused
    // final _remoteConfigService = locator<RemoteConfigService>();
    // await _remoteConfigService.init();

    final _sharedPreferencesService = locator<SharedPreferencesService>();
    await _sharedPreferencesService.init();

    final _causesService = locator<CausesService>();

    // TODO Add timeout to dio - if service is not up it times out
    final currentUser = await _userService.fetchUser();
    final userCausesInfo = await _causesService.fetchUserInfo();

    sentry_transaction.finish();
    if (currentUser == null) {
      _routerService.clearStackAndShow(const IntroViewRoute());
    } else {
      _routerService.navigateUserInitalRoute(
        currentUser,
        require(userCausesInfo,
            'User cauess info cannot be null if hte user is authenticated'),
      );
    }
  }
}

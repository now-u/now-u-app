import 'package:logging/logging.dart';
import 'package:flutter/foundation.dart';
import 'package:nowu/app/app.locator.dart';
import 'package:nowu/services/api_service.dart';
import 'package:nowu/services/auth.dart';
import 'package:nowu/services/causes_service.dart';
import 'package:nowu/services/dynamicLinks.dart';
import 'package:nowu/services/pushNotifications.dart';
import 'package:nowu/services/router_service.dart';
import 'package:nowu/services/shared_preferences_service.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:nowu/ui/common/post_login_viewmodel.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:stacked/stacked.dart';

class StartupViewModel extends BaseViewModel with PostLoginViewModelMixin {
  final _routerService = locator<RouterService>();
  final _logger = Logger('StartupViewModel');

  // Override initialise to stop setting up navigate on post login
  @override
  void initialise() {
    _logger.info('Initialised startup view model');
  }

  // TODO Add retires on error with backoff
  Future handleStartUpLogic() async {
    final sentryTransaction =
        Sentry.startTransaction('StartupViewModel', 'handleStartUpLogic');
    _logger.info('handleStartUpLogic starting');

    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

    final isMobile = defaultTargetPlatform == TargetPlatform.iOS ||
        defaultTargetPlatform == TargetPlatform.android;

    if (isMobile) {
      _logger.info('Initalizing dynamic links service');
      final _dynamicLinkService = locator<DynamicLinkService>();
      await _dynamicLinkService.handleDynamicLinks();

      // Register for push notifications
      _logger.info('Initalizing push notifications service');
      final _pushNotificationService = locator<PushNotificationService>();
      await _pushNotificationService.init();
    }

    // TODO Remove if unused
    // final _remoteConfigService = locator<RemoteConfigService>();
    // await _remoteConfigService.init();

    _logger.info('Initalizing shared preferences service');
    final _sharedPreferencesService = locator<SharedPreferencesService>();
    await _sharedPreferencesService.init();

    _logger.info('Initalizing api service');
    final _apiService = locator<ApiService>();
    _apiService.init();

    _logger.info('Initalizing authentication service');
    final _authenticationService = locator<AuthenticationService>();
    await _authenticationService.init();

	// TODO This feels brittle, can we do this somehwere more centrally?
	// TODO Can probably remove this
	if (_authenticationService.token != null) {
	    _logger.info('Setting token for api service');
		_apiService.setToken(_authenticationService.token!);
	}

    _logger.info('Initalizing causes service');
    final _causesService = locator<CausesService>();
    await _causesService.init();

    sentryTransaction.finish();

    if (_authenticationService.isAuthenticated) {
	  _logger.info('User is authenticated');
      return fetchUserAndNavigatePostLogin();
    }

    // TODO Track if device has already finished intro, if so show login page instead
	_logger.info('User is not authenticated');
    _routerService.clearStackAndShow(const IntroViewRoute());
  }
}

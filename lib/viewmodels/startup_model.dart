//import 'package:app/constants/route_names.dart';
import 'package:app/locator.dart';
import 'package:app/routes.dart';
import 'package:app/services/auth.dart';
import 'package:app/services/dynamicLinks.dart';
import 'package:app/services/navigation_service.dart';
import 'package:app/services/pushNotifications.dart';
import 'package:app/services/remote_config_service.dart';
import 'package:app/services/shared_preferences_service.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:app/viewmodels/base_model.dart';
import 'package:flutter/material.dart';

class StartUpViewModel extends BaseModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final NavigationService _navigationService = locator<NavigationService>();

  Future handleStartUpLogic() async {
    registerFirebaseServicesToLocator();

    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

    final DynamicLinkService _dynamicLinkService =
        locator<DynamicLinkService>();
    await _dynamicLinkService.handleDynamicLinks();

    // Register for push notifications
    final PushNotificationService _pushNotificationService =
        locator<PushNotificationService>();
    await _pushNotificationService.init();

    final RemoteConfigService _remoteConfigService =
        locator<RemoteConfigService>();
    await _remoteConfigService.init();

    final SharedPreferencesService _sharedPreferencesService =
        locator<SharedPreferencesService>();
    await _sharedPreferencesService.init();

    var currentUser = await _authenticationService.fetchUser();

    if (currentUser != null) {
      _navigationService.navigateTo(Routes.home);
    } else {
      _navigationService.navigateTo(Routes.intro);
    }
  }
}

//import 'package:nowu/constants/route_names.dart';
import 'package:nowu/locator.dart';
import 'package:nowu/routes.dart';
import 'package:nowu/services/auth.dart';
import 'package:nowu/services/causes_service.dart';
import 'package:nowu/services/dynamicLinks.dart';
import 'package:nowu/services/navigation_service.dart';
import 'package:nowu/services/pushNotifications.dart';
import 'package:nowu/services/remote_config_service.dart';
import 'package:nowu/services/shared_preferences_service.dart';
import 'package:nowu/services/superbase.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:nowu/services/user_service.dart';
import 'package:nowu/viewmodels/base_model.dart';
import 'package:nowu/models/User.dart';
import 'package:flutter/material.dart';

class StartUpViewModel extends BaseModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final NavigationService _navigationService = locator<NavigationService>();

  Future handleStartUpLogic() async {
    registerFirebaseServicesToLocator();

    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

	final _userService = locator<UserService>();

    final _supabaseService = locator<SupabaseService>();
    await _supabaseService.init();

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

	final _causesService = locator<CausesService>();

    final currentUser = await _userService.fetchUser();
    final userCasusesInfo = await _causesService.fetchUserInfo();

    // _navigationService.navigateTo(
    //     currentUser != null ? Routes.home : Routes.intro,
    //     clearHistory: true);
    // var currentSession = _supabaseService.client.auth.currentSession;

    // TODO Check if user has profile and navigate accordingly, probably share this logic as well
    _navigationService.navigateTo(
        currentUser == null
            ? Routes.intro
            : (currentUser.isInitialised && userCasusesInfo.isInitialised == true)
                ? Routes.home
                : Routes.profileSetup,
        clearHistory: true);
  }
}

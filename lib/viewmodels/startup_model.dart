//import 'package:app/constants/route_names.dart';
import 'package:app/locator.dart';
import 'package:app/routes.dart';
import 'package:app/services/auth.dart';
import 'package:app/services/dynamicLinks.dart';
import 'package:app/services/navigation.dart';
import 'package:app/services/pushNotifications.dart';
import 'package:app/services/remote_config_service.dart';
import 'package:app/viewmodels/base_model.dart';

class StartUpViewModel extends BaseModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final PushNotificationService _pushNotificationService =
      locator<PushNotificationService>();
  final DynamicLinkService _dynamicLinkService = locator<DynamicLinkService>();
  final RemoteConfigService _remoteConfigService = locator<RemoteConfigService>();

  Future handleStartUpLogic() async {
    await _dynamicLinkService.handleDynamicLinks();

    // Register for push notifications
    await _pushNotificationService.init();
    await _remoteConfigService.init();

    var hasLoggedInUser = await _authenticationService.isUserLoggedIn();

    if (hasLoggedInUser) {
      _navigationService.navigateTo(Routes.home);
    } else {
      _navigationService.navigateTo(Routes.login);
    }
  }
}

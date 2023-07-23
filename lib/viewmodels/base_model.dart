import 'package:causeApiClient/causeApiClient.dart';
import 'package:nowu/locator.dart';
import 'package:nowu/routes.dart';
import 'package:nowu/services/auth.dart';
import 'package:nowu/services/navigation_service.dart';
import 'package:flutter/widgets.dart';
import 'package:nowu/services/user_service.dart';

class BaseModel extends ChangeNotifier {
  final AuthenticationService? _authenticationService = locator<AuthenticationService>();
  final NavigationService? _navigationService = locator<NavigationService>();
  final UserService _userService = locator<UserService>();

  // TODO Remove user from base
  UserProfile? get currentUser => _userService.currentUser;

  bool _busy = false;
  bool get busy => _busy;

  void setBusy(bool value) {
    _busy = value;
    notifyListeners();
  }

  Future<void> logout() async {
    await _authenticationService!.logout();
    _navigationService!.navigateTo(Routes.login);
  }
}

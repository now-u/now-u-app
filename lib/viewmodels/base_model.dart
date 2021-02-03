import 'package:app/locator.dart';
import 'package:app/routes.dart';
import 'package:app/models/User.dart';
import 'package:app/services/auth.dart';
import 'package:app/services/navigation_service.dart';
import 'package:flutter/widgets.dart';

class BaseModel extends ChangeNotifier {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final NavigationService _navigationService = locator<NavigationService>();

  User get currentUser => _authenticationService.currentUser;

  bool _busy = false;
  bool get busy => _busy;

  void setBusy(bool value) {
    _busy = value;
    notifyListeners();
  }

  void logout() {
    _authenticationService.logout();
    _navigationService.navigateTo(Routes.home);
  }
}

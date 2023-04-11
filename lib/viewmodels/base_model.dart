import 'package:nowu/locator.dart';
import 'package:nowu/routes.dart';
import 'package:nowu/models/User.dart';
import 'package:nowu/services/auth.dart';
import 'package:nowu/services/navigation_service.dart';
import 'package:flutter/widgets.dart';

class BaseModel extends ChangeNotifier {
  final AuthenticationService? _authenticationService =
      locator<AuthenticationService>();
  final NavigationService? _navigationService = locator<NavigationService>();

  User? get currentUser => _authenticationService!.currentUser;

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

import 'package:stacked/stacked.dart';

import '../../../app/app.locator.dart';
import '../../../services/auth.dart';
import '../../../services/router_service.dart';
import '../../../services/user_service.dart';

class DeleteAccountViewModel extends BaseViewModel {
  final _userService = locator<UserService>();
  final _authenticationService = locator<AuthenticationService>();
  final _routerService = locator<RouterService>();

  String inputName = '';
  bool isNameValid = false;

  void updateInputName(String value) {
    inputName = value;
    isNameValid = value == _userService.currentUser?.name;
    notifyListeners();
  }

  void deleteAccount() async {
    if (!isNameValid) return;

    await _userService.deleteUser();
    await _authenticationService.logout();
    _routerService.clearStackAndShow(const LoginViewRoute());
  }
}

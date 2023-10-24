import 'dart:async';

import 'package:logging/logging.dart';
import 'package:nowu/services/navigation_service.dart';
import 'package:nowu/services/router_service.dart';
import 'package:nowu/services/storage.dart';
import 'package:nowu/ui/common/post_login_viewmodel.dart';
import 'package:stacked/stacked.dart';
import 'package:nowu/app/app.locator.dart';
import 'package:nowu/services/auth.dart';

import 'login_view.form.dart';

class LoginFormValidators {
  static String? emailValidator(String? email) {
    if (email == null || email.isEmpty) return 'Email cannot be empty';
    if (!RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9-]+\.[a-zA-Z-]+",
    ).hasMatch(email)) {
      return 'Email must be a valid email address';
    }
    return null;
  }
}

class LoginViewModel extends FormViewModel with PostLoginViewModelMixin {
  final _authenticationService = locator<AuthenticationService>();
  final _routerService = locator<RouterService>();
  final _navigationService = locator<NavigationService>();
  final _secureStroageService = locator<SecureStorageService>();
  final _logger = Logger('LoginViewModel');

  bool showValidation = false;

  Future loginWithGoogle() async {
    await _authenticationService.signInWithGoogle();
  }

  Future loginWithFacebook() async {
    await _authenticationService.signInWithFacebook();
  }

  Future loginWithApple() async {
    await _authenticationService.signInWithApple();
  }

  Future loginWithEmail() async {
    validateForm();
    showValidation = true;
    notifyListeners();
    if (!isFormValid) {
      return;
    }
    _logger.info('Logging in with email $emailInputValue');
    await _secureStroageService.setEmail(emailInputValue!);
    _authenticationService.sendSignInEmail(emailInputValue!);
    await _routerService.navigateToLoginEmailSentView(email: emailInputValue!);
  }

  void launchTandCs() {
    _navigationService.launchLink(
      'http://www.now-u.com/static/media/now-u_privacy-notice.25c0d41b.pdf',
      isExternal: true,
    );
  }

  void skipLogin() async {
    await _routerService.navigateToHome(clearHistory: true);
  }
}

import 'dart:async';

import 'package:logging/logging.dart';
import 'package:nowu/app/app.locator.dart';
import 'package:nowu/assets/constants.dart';
import 'package:nowu/router.dart';
import 'package:nowu/router.gr.dart';
import 'package:nowu/services/auth.dart';
import 'package:nowu/services/dialog_service.dart';
import 'package:nowu/services/navigation_service.dart';
import 'package:nowu/services/router_service.dart';
import 'package:nowu/services/storage.dart';
import 'package:nowu/services/user_service.dart';
import 'package:nowu/ui/common/post_login_viewmodel.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:stacked/stacked.dart';

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
  final _router = locator<AppRouter>();
  final _navigationService = locator<NavigationService>();
  final _secureStroageService = locator<SecureStorageService>();
  final _dialogService = locator<DialogService>();
  final _userService = locator<UserService>();
  final _logger = Logger('LoginViewModel');

  bool showValidation = false;

  Future loginWithGoogle() async {
    try {
      await _authenticationService.signInWithGoogle();
    } catch (e) {
      _logger.severe('Login failed: error=$e');
      await Sentry.captureException(e);
      _dialogService.showErrorDialog(
        title: 'Login failed',
        description: 'Unknwon error during login. Please try again.',
      );
    }
  }

  Future loginWithFacebook() async {
    await _authenticationService.signInWithFacebook();
  }

  Future loginWithApple() async {
    final response = await _authenticationService.signInWithApple();
    _userService.prefilledName = response.user?.userMetadata?['full_name'];
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
    await _router.push(LoginEmailSentRoute(email: emailInputValue!));
  }

  void launchPrivacyPolicy() {
    _navigationService.launchLink(PRIVACY_POLICY_URL, isExternal: true);
  }

  void skipLogin() async {
    await _router.replaceAll([TabsRoute(children: [const HomeRoute()])]);
  }
}

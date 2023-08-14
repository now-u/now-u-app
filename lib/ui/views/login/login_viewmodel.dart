import 'dart:async';

import 'package:causeApiClient/causeApiClient.dart';
import 'package:nowu/pages/login/emailSentPage.dart';
import 'package:nowu/routes.dart';
import 'package:nowu/services/causes_service.dart';
import 'package:nowu/services/navigation_service.dart';
import 'package:nowu/services/router_service.dart';
import 'package:nowu/services/storage.dart';
import 'package:nowu/services/superbase.dart';
import 'package:nowu/services/user_service.dart';
import 'package:open_mail_app/open_mail_app.dart';
import 'package:stacked/stacked.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide User;
import 'package:nowu/app/app.locator.dart';
import 'package:nowu/services/auth.dart';
import 'package:nowu/services/dialog_service.dart';

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

class LoginViewModel extends FormViewModel {
  final _authenticationService = locator<AuthenticationService>();
  final _routerService = locator<RouterService>();
  final _navigationService = locator<NavigationService>();
  final _dialogService = locator<DialogService>();
  final _secureStroageService = locator<SecureStorageService>();
  final _userService = locator<UserService>();
  final _causesService = locator<CausesService>();

  late final StreamSubscription<AuthState>? _authStateSubscription;
  final _supabaseService = locator<SupabaseService>();

  void init() {
    _authStateSubscription =
        _supabaseService.client?.auth.onAuthStateChange.listen((event) async {
      print('Auth state has changed!');
      UserProfile? user = await _userService.fetchUser();
      // TODO Are there other user things we need to fetch, should we share the logic for fetching all user info?
      CausesUser? causesUser = await _causesService.fetchUserInfo();

      if (user == null || causesUser == null) {
        // TODO Add metric here
        _dialogService.showDialog(
          BasicDialog(title: 'Login failed', description: 'Login failed'),
        );
      } else {
        _routerService.navigateUserInitalRoute(user, causesUser);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _authStateSubscription?.cancel();
    // TODO Is this required?
    // disposeForm();
  }

  Future loginWithGoogle() async {
    await _authenticationService.signInWithGoogle();
  }

  Future loginWithFacebook() async {
    await _authenticationService.signInWithFacebook();
  }

  Future loginWithEmail() async {
    validateForm();
    if (hasEmailInputValidationMessage) {
      throw Exception('Invalid login form submitted');
    }
    _secureStroageService.setEmail(emailInputValue!);
    await _authenticationService.sendSignInEmail(emailInputValue!);
    _navigationService.navigateTo(
      Routes.emailSent,
      arguments: EmailSentPageArguments(email: emailInputValue!),
      clearHistory: true,
    );
  }

  Future loginWithCode({
    required String email,
    required String token,
  }) async {
    setBusy(true);
    try {
      await _authenticationService.signInWithCode(email, token);
      setBusy(false);
    } catch (e) {
      setBusy(false);
      await _dialogService.showDialog(
        BasicDialog(
          title: 'Login error',
          description:
              'Authentication failed, please double check your token from the email',
        ),
      );
    }
  }

  Future openMailApp() async {
    var result = await OpenMailApp.openMailApp();

    // If no mail apps found, show error
    if (!result.didOpen && !result.canOpen) {
      _dialogService.showDialog(
        BasicDialog(
          title: 'No email apps found',
          description: 'Please check your emails',
        ),
      );

      // iOS: if multiple mail apps found, show dialog to select.
      // There is no native intent/default app system in iOS so
      // you have to do it yourself.
    } else if (!result.didOpen && result.canOpen) {
      _dialogService.showDialog(EmailAppPickerDialog(result.options));
    }
  }

  void navigateToSecretCodePage(String email) {
    _navigationService.navigateTo(Routes.loginCodeInput, arguments: email);
  }

  void launchTandCs() {
    _navigationService.launchLink(
      'http://www.now-u.com/static/media/now-u_privacy-notice.25c0d41b.pdf',
      isExternal: true,
    );
  }

  void skipLogin() {
    // TODO Is this the correct thing
    _routerService.navigateToHome(clearHistory: true);
  }
}

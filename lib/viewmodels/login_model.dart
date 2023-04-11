import 'dart:async';

import 'package:nowu/models/User.dart';
import 'package:nowu/pages/login/emailSentPage.dart';
import 'package:nowu/routes.dart';
import 'package:nowu/services/storage.dart';
import 'package:nowu/services/superbase.dart';
import 'package:open_mail_app/open_mail_app.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide User;
import 'base_model.dart';
import 'package:nowu/locator.dart';
import 'package:nowu/services/auth.dart';
import 'package:nowu/services/navigation_service.dart';
import 'package:nowu/services/dialog_service.dart';
import 'package:nowu/services/api_service.dart';

class LoginViewModel extends BaseModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final DialogService _dialogService = locator<DialogService>();
  final SecureStorageService _secureStroageService =
      locator<SecureStorageService>();

  late final StreamSubscription<AuthState> _authStateSubscription;
  final _supabaseService = locator<SupabaseService>();

  String _email = "";
  void set email(String email) {
    _secureStroageService.setEmail(email);
    this._email = email;
  }

  void init() {
    _authStateSubscription =
        _supabaseService.client.auth.onAuthStateChange.listen((event) async {
      print("Auth state has changed!");
      User? user = await _authenticationService.fetchUser();

      if (user == null) {
        _dialogService.showDialog(
            BasicDialog(title: "Login failed", description: "Login failed"));
      } else if (!user.hasProfile) {
        print("Navigating to profile setup");
        _navigationService.navigateTo(Routes.profileSetup, clearHistory: true);
      } else {
        _navigationService.navigateTo(Routes.home, clearHistory: true);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _authStateSubscription.cancel();
  }

  Future sendLoginEmail() async {
    await _authenticationService.sendSignInEmail(_email);
    _navigationService.navigateTo(Routes.emailSent,
        arguments: EmailSentPageArguments(email: _email), clearHistory: true);
  }

  Future loginWithGoogle() async {
    await _authenticationService.signInWithGoogle();
  }

  Future loginWithFacebook() async {
    await _authenticationService.signInWithFacebook();
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
      await _dialogService.showDialog(BasicDialog(
          title: "Login error",
          description:
              "Authentication failed, please double check your token from the email"));
    }
  }

  Future openMailApp() async {
    var result = await OpenMailApp.openMailApp();

    // If no mail apps found, show error
    if (!result.didOpen && !result.canOpen) {
      _dialogService.showDialog(BasicDialog(
          title: "No email apps found",
          description: "Please check your emails"));

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
      "http://www.now-u.com/static/media/now-u_privacy-notice.25c0d41b.pdf",
      isExternal: true,
    );
  }
}

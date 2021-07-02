import 'package:app/routes.dart';

import 'base_model.dart';
import 'package:app/locator.dart';
import 'package:app/services/auth.dart';
import 'package:app/services/navigation_service.dart';
import 'package:app/services/dialog_service.dart';
import 'package:app/services/facebook_auth.dart';

import 'package:app/pages/login/emailSentPage.dart';

import 'package:flutter/foundation.dart';

class LoginViewModel extends BaseModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final DialogService _dialogService = locator<DialogService>();
  final SocialAuth _socialAuth = locator<SocialAuth>();

  Future email({
    @required String email,
    @required String name,
    @required bool newsletterSignup,
  }) async {
    setBusy(true);

    var result = await _authenticationService.sendSignInWithEmailLink(
      email,
      name,
      newsletterSignup,
    );

    setBusy(false);

    if (result is bool) {
      if (result) {
        _navigationService.navigateTo(Routes.emailSent,
            arguments: EmailSentPageArguments(email: email));
      } else {
        await _dialogService.showDialog(
            title: "Login error",
            description: "There has been an error please try again");
      }
    } else {
      await _dialogService.showDialog(
          title: "Login error",
          description:
              "There has been an error, please check you have access to the internet.");
    }
  }

  Future login({
    @required String email,
    @required String token,
    bool isManul,
  }) async {
    setBusy(true);

    var err = await _authenticationService.login(
      email,
      token,
    );

    setBusy(false);

    if (err != null) {
      print("Sign up failure: $err");

      String errorMsg = "Login error please try again";
      if (err == AuthError.tokenExpired) {
        errorMsg = "Your token has expired, please restart the login process";
        await _dialogService.showDialog(
            title: "Login error", description: errorMsg);
        _navigationService.navigateTo(Routes.login);
      } else if (err == AuthError.unauthorized) {
        if (isManul) {
          errorMsg =
              "Incorrect token, please double check your token from the email";
          await _dialogService.showDialog(
              title: "Login error", description: errorMsg);
        } else {
          errorMsg = "Incorrect login link, please try again";
          await _dialogService.showDialog(
              title: "Login error", description: errorMsg);
        }
      } else {
        await _dialogService.showDialog(
            title: "Login error", description: errorMsg);
      }
    } else {
      _navigationService.navigateTo(Routes.intro);
    }
  }

  void facebookLogin() {
    _socialAuth.login();
  }

  void launchTandCs() {
    _navigationService.launchLink(
      "http://www.now-u.com/static/media/now-u_privacy-notice.25c0d41b.pdf",
      isExternal: true,
    );
  }
}

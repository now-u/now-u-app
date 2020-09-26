import 'package:app/routes.dart';

import 'base_model.dart';
import 'package:app/locator.dart';
import 'package:app/services/auth.dart';
import 'package:app/services/navigation.dart';
import 'package:app/services/dialog_service.dart';

import 'package:app/pages/login/emailSentPage.dart';

import 'package:flutter/foundation.dart';

class LoginViewModel extends BaseModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final DialogService _dialogService = locator<DialogService>();
 
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
            description: "There has been an error please try again"
        );
      }
    } else {
        await _dialogService.showDialog(
            title: "Login error",
            description: "There has been an error, please check you have access to the internet."
        );
    }
  }

  Future login({
    @required String email,
    @required String token,
    bool isManul,
  }) async {
    setBusy(true);
    
    print("Hello6");

    var errorMsg = await _authenticationService.login(
      email,
      token,
    );

    print("Hello5");

    setBusy(false);

    if (errorMsg != null) {
      print("Sign up failure: $errorMsg");
      if(isManul == true) {
        await _dialogService.showDialog(title: "Login error", description: "Login failed. Please double check your token.");
      }
      else {
        await _dialogService.showDialog(title: "Login error", description: errorMsg);
      }
    } else {
      _navigationService.navigateTo(Routes.intro);
    }
  }
}

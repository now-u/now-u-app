import 'package:app/routes.dart';

import 'base_model.dart';
import 'package:app/locator.dart';
import 'package:app/services/auth.dart';
import 'package:app/services/navigation.dart';

import 'package:app/pages/login/emailSentPage.dart';

import 'package:flutter/foundation.dart';

class LoginViewModel extends BaseModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final NavigationService _navigationService = locator<NavigationService>();
 
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
        print("Sucess navigating to emailsent page");
        _navigationService.navigateTo(Routes.emailSent,
            arguments: EmailSentPageArguments(email: email));
      } else {
        print("general signup failure");
        //await _dialogService.showDialog(
        //  title: 'Sign Up Failure',
        //  description: 'General sign up failure. Please try again later',
        //);
      }
    } else {
      print("Sign up failure");
      //await _dialogService.showDialog(
      //  title: 'Sign Up Failure',
      //  description: result,
      //);
    }
  }

  Future login({
    @required String email,
    @required String token,
  }) async {
    setBusy(true);

    var errorMsg = await _authenticationService.login(
      email,
      token,
    );

    setBusy(false);

    if (errorMsg != null) {
      print("Sign up failure: $errorMsg");
    } else {
      _navigationService.navigateTo(Routes.intro);
    }
  }
}

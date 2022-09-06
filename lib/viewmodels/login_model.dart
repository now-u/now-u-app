import 'package:app/pages/login/emailSentPage.dart';
import 'package:app/routes.dart';
import 'base_model.dart';
import 'package:app/locator.dart';
import 'package:app/services/auth.dart';
import 'package:app/services/navigation_service.dart';
import 'package:app/services/dialog_service.dart';
import 'package:app/services/api_service.dart';

class LoginViewModel extends BaseModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final DialogService _dialogService = locator<DialogService>();

  Future email({
    required String email,
    required String name,
    required bool newsletterSignup,
  }) async {
    setBusy(true);
    try {
      await _authenticationService.sendSignInWithEmailLink(
        email,
        name,
        newsletterSignup,
      );
      setBusy(false);
      _navigationService.navigateTo(Routes.emailSent,
          arguments: EmailSentPageArguments(email: email));
    } on ApiException catch (e) {
      setBusy(false);
      await _dialogService.showDialog(
        BasicDialog(
          title: "Login error",
          description:
              "The following error has occured please try again. ${e.message}",
        ),
      );
    }
  }

  Future login({
    required String email,
    required String token,
    bool isManual = false,
  }) async {
    print("Logging in");
    setBusy(true);

    try {
      await _authenticationService.login(
        email,
        token,
      );
      setBusy(false);

      if (currentUser!.selectedCauses.length == 0) {
        _navigationService.navigateTo(Routes.causesOnboardingPage);
      } else {
        _navigationService.navigateTo(Routes.home);
      }
    } on ApiException catch (e) {
      print("Got api exception");
      String errorMessage = e.message;
      if (e.type == ApiExceptionType.TOKEN_EXPIRED) {
        errorMessage =
            "Your token has expired, please restart the login process";
      }
      if (e.type == ApiExceptionType.UNAUTHORIZED) {
        if (isManual) {
          errorMessage =
              "Incorrect token, please double check your token from the email";
        } else {
          errorMessage = "Incorrect login link, please double check your email";
        }
      }

      setBusy(false);
      await _dialogService.showDialog(
          BasicDialog(title: "Login error", description: errorMessage));
    }
  }

  void launchTandCs() {
    _navigationService.launchLink(
      "http://www.now-u.com/static/media/now-u_privacy-notice.25c0d41b.pdf",
      isExternal: true,
    );
  }
}

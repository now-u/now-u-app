import 'package:app/assets/constants.dart';
import 'package:app/locator.dart';
import 'package:app/routes.dart';
import 'package:app/services/navigation_service.dart';
import 'package:app/services/user_service.dart';
import 'package:app/viewmodels/base_model.dart';
import 'package:flutter/widgets.dart';

class ProfileSetupViewModel extends BaseModel {
  final _navigationService = locator<NavigationService>();
  final _userSerivce = locator<UserService>();
  final formKey = GlobalKey<FormState>();

  String? name;
  bool signUpForNewsLetter = false;

  ProfileSetupViewModel() {
    this.name = currentUser?.fullName;
  }

  void openTsAndCs() {
    _navigationService.launchLink(TERMS_AND_CONDITIONS_URL);
  }

  void saveAndNavigate() async {
    setBusy(true);
    // We know name is defined here as the form is valid
    print("Setting name to: $name");
    await _userSerivce.updateUser(
        name: name!, newsLetterSignup: signUpForNewsLetter);
    setBusy(false);
    _navigationService.navigateTo(Routes.causesOnboardingPage);
  }

  void launchTandCs() {
    _navigationService.launchLink(
      TERMS_AND_CONDITIONS_URL,
      isExternal: true,
    );
  }
}

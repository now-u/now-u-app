import 'package:flutter/widgets.dart';
import 'package:nowu/locator.dart';
import 'package:nowu/assets/constants.dart';
import 'package:nowu/router.dart';
import 'package:nowu/router.gr.dart';
import 'package:nowu/services/auth.dart';
import 'package:nowu/services/navigation_service.dart';
import 'package:nowu/services/router_service.dart';
import 'package:nowu/services/user_service.dart';
import 'package:nowu/ui/views/causes_selection/select_causes_viewmodel.dart';
import 'package:stacked/stacked.dart';

class ProfileSetupViewModel extends BaseViewModel {
  final _router = locator<AppRouter>();
  final _navigationService = locator<NavigationService>();
  final _userSerivce = locator<UserService>();
  final _authenticationService = locator<AuthenticationService>();
  final formKey = GlobalKey<FormState>();

  String? name;
  bool signUpForNewsLetter = false;

  ProfileSetupViewModel() {
    this.name = _userSerivce.prefilledName ??
        _authenticationService.getCurrentUserName();
  }

  void openTsAndCs() {
    // TODO Fix
    // _navigationService.launchLink(TERMS_AND_CONDITIONS_URI);
  }

  void saveAndNavigate() async {
    setBusy(true);
    // We know name is defined here as the form is valid
    print('Setting name to: $name');
    // TODO FIX
    await _userSerivce.updateUser(
      name: name!,
      newsLetterSignup: signUpForNewsLetter,
    );
    setBusy(false);
    _router.push(const OnboardingSelectCausesRoute());
  }

  void launchTandCs() {
    // TODO Fix
    // _navigationService.launchLink(
    //   TERMS_AND_CONDITIONS_URL,
    //   isExternal: true,
    // );
  }
}

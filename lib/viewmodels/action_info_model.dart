import 'package:app/viewmodels/base_campaign_model.dart';

import 'package:app/locator.dart';
import 'package:app/routes.dart';
import 'package:app/services/auth.dart';
import 'package:app/services/navigation.dart';

import 'package:app/models/Action.dart';

class ActionInfoViewModel extends BaseCampaignViewModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final NavigationService _navigationService = locator<NavigationService>();

  Future completeAction(int id) async {
    setBusy(true);
    bool success = await _authenticationService.completeAction(id);
    setBusy(false);
    if (success) {
      _navigationService.navigateTo(Routes.actions);
    }
  }

  Future removeActionStatus(int id) async {
    setBusy(true);
    await _authenticationService.removeActionStatus(id);
    setBusy(false);
    notifyListeners();
  }

  Future starAction(int id) async {
    setBusy(true);
    await _authenticationService.starAction(id);
    setBusy(false);
    notifyListeners();
  }

  void launchAction(CampaignAction action) {
    _navigationService.launchLink(action.getLink());
  }
}

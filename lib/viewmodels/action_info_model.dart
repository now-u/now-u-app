import 'package:app/viewmodels/base_campaign_model.dart';

import 'package:app/locator.dart';
import 'package:app/routes.dart';
import 'package:app/services/auth.dart';
import 'package:app/services/navigation_service.dart';
import 'package:app/services/causes_service.dart';

import 'package:app/models/Action.dart';

class ActionInfoViewModel extends BaseCampaignViewModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final CausesService _causesService = locator<CausesService>();

  CampaignAction? _action;
  CampaignAction? get action => _action;

  bool isLoading = true;

  Future<void> fetchAction(ListCauseAction action) async {
    setBusy(true);
    _action = await action.getAction();
    isLoading = false;
    setBusy(false);
    notifyListeners();
  }

  Future completeAction() async {
    setBusy(true);
    bool success = await _authenticationService.completeAction(_action!.id);
    setBusy(false);
    if (success) {
      _navigationService.navigateTo(Routes.actions);
    }
  }

  Future removeActionStatus() async {
    setBusy(true);
    await _authenticationService.removeActionStatus(_action!.id);
    setBusy(false);
    notifyListeners();
  }

  Future starAction() async {
    setBusy(true);
    await _authenticationService.starAction(_action!.id);
    setBusy(false);
    notifyListeners();
  }

  void launchAction() {
    _navigationService.launchLink(_action!.getLink()!);
  }
}

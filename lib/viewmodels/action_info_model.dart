import 'package:app/services/causes_service.dart';
import 'package:app/viewmodels/base_model.dart';

import 'package:app/locator.dart';
import 'package:app/routes.dart';
import 'package:app/services/navigation_service.dart';

import 'package:app/models/Action.dart';

class ActionInfoViewModel extends BaseModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final CausesService _causesService = locator<CausesService>();

  CampaignAction? _action;
  CampaignAction? get action => _action;

  Future<void> fetchAction(ListCauseAction action) async {
    setBusy(true);
    // TODO catch error
    _action = await _causesService.getAction(action.id);
    setBusy(false);
    notifyListeners();
  }

  Future completeAction() async {
    setBusy(true);
    bool success = await _causesService.completeAction(_action!.id);
    setBusy(false);
    if (success) {
      _navigationService.navigateTo(Routes.actions);
    }
  }

  Future removeActionStatus() async {
    setBusy(true);
    await _causesService.removeActionStatus(_action!.id);
    setBusy(false);
    notifyListeners();
  }

  void launchAction() {
    _navigationService.launchLink(_action!.link!);
  }
}

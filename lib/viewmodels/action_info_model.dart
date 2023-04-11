import 'package:nowu/models/Cause.dart';
import 'package:nowu/pages/explore/ExplorePage.dart';
import 'package:nowu/services/causes_service.dart';
import 'package:nowu/services/dialog_service.dart';
import 'package:nowu/viewmodels/base_model.dart';

import 'package:nowu/locator.dart';
import 'package:nowu/routes.dart';
import 'package:nowu/services/navigation_service.dart';

import 'package:nowu/models/Action.dart';
import 'package:nowu/viewmodels/explore_page_view_model.dart';

class ActionInfoViewModel extends BaseModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final CausesService _causesService = locator<CausesService>();
  final DialogService _dialogService = locator<DialogService>();

  CampaignAction? _action;
  CampaignAction? get action => _action;

  Future<void> fetchAction(int actionId) async {
    setBusy(true);
    // TODO catch error
    _action = await _causesService.getAction(actionId);
    setBusy(false);
    notifyListeners();
  }

  Future completeAction() async {
    setBusy(true);
    await _causesService.completeAction(_action!.id).then((_) {
      setBusy(false);
      _navigationService.navigateTo(Routes.actions);
    }).onError((err, _) {
      setBusy(false);
      _dialogService.showDialog(
        BasicDialog(title: "Error", description: "Failed to complete action"),
      );
    });
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

  void navigateToCauseExplorePage() {
    ListCause cause = this.action!.cause;
    _navigationService.navigateTo(Routes.explore,
        arguments: ExplorePageArguments(
            sections: home_explore_page.sections,
            title: "Explore ${cause.title} cause",
            baseParams: {
              "cause__in": [this.action!.cause.id]
            }));
  }
}

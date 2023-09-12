import 'package:nowu/services/causes_service.dart';
import 'package:nowu/services/dialog_service.dart';
import 'package:nowu/services/router_service.dart';
import 'package:nowu/services/search_service.dart';
import 'package:nowu/services/user_service.dart';

import 'package:nowu/app/app.locator.dart';
import 'package:nowu/services/navigation_service.dart';
import 'package:nowu/ui/views/explore/explore_page_viewmodel.dart';
import 'package:stacked/stacked.dart';

class ActionInfoViewModel extends FutureViewModel<Action> {
  final _navigationService = locator<NavigationService>();
  final _routerService = locator<RouterService>();
  final _causesService = locator<CausesService>();
  final _userService = locator<UserService>();
  final _dialogService = locator<DialogService>();

  final int actionId;
  ActionInfoViewModel(this.actionId);

  Future<Action> futureToRun() => _causesService.getAction(actionId);

  Future completeAction() async {
    if (_userService.currentUser == null) {
      // TODO Based on UX add a popup or something
      return _routerService.navigateToLoginView();
    }

    setBusy(true);
    try {
      await _causesService.completeAction(data!.id);
      setBusy(false);
      // TODO Really?
      _routerService.back();
    } catch (err) {
      // TODO Log and metric!
      setBusy(false);
      print(err.toString());
      _dialogService.showErrorDialog(
        title: 'Error',
        description: 'Failed to complete action',
      );
    }
  }

  Future removeActionStatus() async {
    setBusy(true);
    await _causesService.removeActionStatus(data!.id);
    setBusy(false);
    notifyListeners();
  }

  void launchAction() {
    _navigationService.launchLink(data!.link);
  }

  void navigateToCauseExplorePage() {
    // TODO THis needs some more thought
    _routerService.navigateToExplore(
      ExplorePageFilterData(filterCauseIds: Set.of([data!.cause.id])),
    );
  }
}

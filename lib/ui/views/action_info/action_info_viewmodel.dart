import 'package:nowu/locator.dart';
import 'package:nowu/router.dart';
import 'package:nowu/router.gr.dart';
import 'package:nowu/services/analytics.dart';
import 'package:nowu/services/causes_service.dart';
import 'package:nowu/services/dialog_service.dart';
import 'package:nowu/services/navigation_service.dart';
import 'package:nowu/services/user_service.dart';
import 'package:nowu/ui/views/explore/explore_page_viewmodel.dart';
import 'package:stacked/stacked.dart';

class ActionInfoViewModel extends FutureViewModel<Action> {
  final _navigationService = locator<NavigationService>();
  final _router = locator<AppRouter>();
  final _causesService = locator<CausesService>();
  final _userService = locator<UserService>();
  final _dialogService = locator<DialogService>();
  final _analyticsService = locator<AnalyticsService>();

  final int actionId;

  ActionInfoViewModel(this.actionId);

  Future<Action> futureToRun() => _causesService.getAction(actionId);

  Future completeAction() async {
    if (_userService.currentUser == null) {
      // TODO Based on UX add a popup or something
      return _router.push(const LoginRoute());
    }

    setBusy(true);
    try {
      await _causesService.completeAction(data!);
      setBusy(false);
      _dialogService.showActionCompletedDialog();
      notifySourceChanged();
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
    await _causesService.removeActionStatus(data!);
    setBusy(false);
    notifyListeners();
  }

  Future launchAction() async {
    // TODO Where should analytics be in bloc model?
    await _analyticsService.logActionEvent(
      data!,
      ActionEvent.TakeActionClicked,
    );
    _navigationService.launchLink(data!.link);
  }

  void navigateToCauseExplorePage() {
    // TODO THis needs some more thought
    _router.push(
      TabsRoute(
        children: [
          ExploreRoute(
            filterData:
                ExplorePageFilterData(filterCauseIds: Set.of([data!.cause.id])),
          ),
        ],
      ),
    );
  }
}

import 'package:causeApiClient/causeApiClient.dart';
import 'package:nowu/services/causes_service.dart';
import 'package:nowu/services/dialog_service.dart';
import 'package:nowu/services/router_service.dart';
import 'package:nowu/services/search_service.dart';
import 'package:nowu/services/user_service.dart';

import 'package:nowu/app/app.locator.dart';
import 'package:nowu/services/internal_notification_service.dart';
import 'package:nowu/services/navigation_service.dart';

import 'package:nowu/models/Notification.dart';
import 'package:nowu/ui/views/explore/explore_page_definition.dart';
import 'package:stacked/stacked.dart';

class HomeViewModel extends BaseViewModel {
  final _internalNotificationService = locator<InternalNotificationService>();
  final _navigationService = locator<NavigationService>();
  final _routerService = locator<RouterService>();
  final _causesService = locator<CausesService>();
  final _dialogService = locator<DialogService>();
  final _userService = locator<UserService>();

  late List<Cause> _causes;
  List<Cause> get causes => _causes;

  UserProfile? get currentUser => _userService.currentUser;

  void init() {
    fetchNotifications();
    _causes = _causesService.causes;
  }

  // TODO should these def really be in the iewmodel? Feel like it shoul dbe in the view to me
  final myCampaigns = CampaignExploreSectionArgs(
    title: 'My campaigns',
  );

  final suggestedCampaigns = CampaignExploreSectionArgs(
    title: 'Suggested campaigns',
    baseParams: CampaignSearchFilter(recommended: true),
  );

  final myActions = ActionExploreSectionArgs(
    title: 'What can I do today?',
    // TODO Fix, this should only filter by completed if there is an active user
    baseParams: ActionSearchFilter(completed: false),
  );

  final inTheNews = NewsArticleExploreSectionArgs(
    title: 'In the news',
  );

  Future getCausePopup(Cause listCause) async {
    final dialogResult = await _dialogService.showCauseDialog(cause: listCause);
    if (dialogResult) {
      _routerService.navigateToChangeSelectCausesView();
    }
  }

  List<InternalNotification>? get notifications =>
      _internalNotificationService.notifications;

  int get numberOfCompletedCampaigns {
    return _causesService.userInfo!.completedCampaignIds.length;
  }

  int get numberOfCompletedActions {
    return _causesService.userInfo!.completedActionIds.length;
  }

  int get numberOfCompletedLearningResources {
    return _causesService.userInfo!.completedLearningResourceIds.length;
  }

  // getNotifications
  Future fetchNotifications() async {
    await _internalNotificationService.fetchNotifications();
    notifyListeners();
  }

  Future openNotification(InternalNotification notification) async {
    await _routerService.navigateToNotificationInfoView(
      notification: notification,
    );
  }

  Future dismissNotification(int id) async {
    bool success = await _internalNotificationService.dismissNotification(id);
    if (success) {
      notifyListeners();
    }
  }

  void onPressCampaignButton() {
    _navigationService.launchLink(
      'https://docs.google.com/forms/d/e/1FAIpQLSfPKOVlzOOV2Bsb1zcdECCuZfjHAlrX6ZZMuK1Kv8eqF85hIA/viewform',
      description:
          'To suggest causes for future campaigns, fill in this Google Form',
      buttonText: 'Go',
    );
  }

  void goToExplorePage() {
    _routerService.navigateToExplore();
  }

  void goToEditCausesPage() {
    _routerService.navigateToChangeSelectCausesView();
  }
}
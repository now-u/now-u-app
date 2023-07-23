import 'package:nowu/pages/explore/explore_page_view_model.dart';
import 'package:nowu/services/auth.dart';
import 'package:nowu/services/causes_service.dart';
import 'package:nowu/services/dialog_service.dart';
import 'package:nowu/services/search_service.dart';
import 'package:nowu/viewmodels/base_model.dart';
import 'package:nowu/models/Cause.dart';

import 'package:nowu/locator.dart';
import 'package:nowu/services/internal_notification_service.dart';
import 'package:nowu/services/navigation_service.dart';

import 'package:nowu/models/Notification.dart';
import 'package:nowu/routes.dart';

class HomeViewModel extends BaseModel with ExploreViewModelMixin {
  final InternalNotificationService _internalNotificationService =
      locator<InternalNotificationService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final CausesService _causesService = locator<CausesService>();
  final DialogService _dialogService = locator<DialogService>();

  final myCampaigns = exploreSectionFromArgs(CampaignExploreSectionArgs(
    title: "My campaigns",
  ));

  final suggestedCampaigns = exploreSectionFromArgs(CampaignExploreSectionArgs(
    title: "Suggested campaigns",
	baseParams: CampaignSearchFilter(recommended: true),
  ));

  final myActions = exploreSectionFromArgs(ActionExploreSectionArgs(
    title: "What can I do today?",
    // TODO Fix, this should only filter by completed if there is an active user
	baseParams: ActionSearchFilter(completed: false),
  ));

  final inTheNews = exploreSectionFromArgs(NewsArticleExploreSectionArgs(
    title: "In the news",
  ));

  HomeViewModel() {
    sections = [myCampaigns, suggestedCampaigns, myActions, inTheNews];
  }

  void init() {
    initSections();
    fetchNotifications();
    fetchCauses();
  }

  List<Cause> _causes = [];

  List<Cause> get causes => _causes;

  Future fetchCauses() async {
    setBusy(true);

    _causes = await _causesService.getCauses();

    setBusy(false);

    print("Fetched ${_causes.length} causes");
    notifyListeners();
  }

  Future getCausePopup(Cause listCause) async {
    var dialogResult = await _dialogService.showDialog(CauseDialog(listCause));
    if (dialogResult.response) {
      _navigationService.navigateTo(Routes.causesEditPage);
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
    setBusy(true);
    await _internalNotificationService.fetchNotifications();
    setBusy(false);
    notifyListeners();
  }

  Future dismissNotification(int id) async {
    bool success = await _internalNotificationService.dismissNotification(id);
    if (success) {
      notifyListeners();
    }
  }

  void onPressCampaignButton() {
    _navigationService.launchLink(
        "https://docs.google.com/forms/d/e/1FAIpQLSfPKOVlzOOV2Bsb1zcdECCuZfjHAlrX6ZZMuK1Kv8eqF85hIA/viewform",
        description:
            "To suggest causes for future campaigns, fill in this Google Form",
        buttonText: "Go");
  }

  void goToExplorePage() {
    _navigationService.navigateTo(Routes.explore);
  }

  void goToEditCausesPage() {
    _navigationService.navigateTo(Routes.causesEditPage);
  }
}

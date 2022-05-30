import 'package:app/services/causes_service.dart';
import 'package:app/services/dialog_service.dart';
import 'package:app/viewmodels/base_model.dart';
import 'package:app/models/Cause.dart';

import 'package:app/locator.dart';
import 'package:app/services/internal_notification_service.dart';
import 'package:app/services/navigation_service.dart';

import 'package:app/models/Notification.dart';
import 'package:app/viewmodels/explore_page_view_model.dart';
import 'package:app/routes.dart';

class HomeViewModel extends BaseModel with ExploreViewModelMixin {
  final InternalNotificationService _internalNotificationService =
      locator<InternalNotificationService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final CausesService _causesService = locator<CausesService>();
  final DialogService _dialogService = locator<DialogService>();

  final ExploreSection myCampaigns = CampaignExploreSection(
    title: "My campaigns",
  );

  final ExploreSection suggestedCampaigns =
      CampaignExploreSection(title: "Suggested campaigns", baseParams: {
    "recommended": true,
  });

  final ExploreSection myActions = ActionExploreSection(
    title: "What can I do today?",
  );

  final ExploreSection inTheNews = NewsExploreSection(
    title: "In the news",
  );

  HomeViewModel() {
    sections = [myCampaigns, suggestedCampaigns, myActions, inTheNews];
  }

  void init() {
    initSections();
    fetchNotifications();
    fetchCauses();
  }

  List<ListCause> _causes = [];

  List<ListCause> get causes => _causes;

  Future fetchCauses() async {
    setBusy(true);

    _causes = await _causesService.getCauses();

    setBusy(false);

    print("Fetched ${_causes.length} causes");
    notifyListeners();
  }

  Future getCausePopup(ListCause listCause) async {
    var dialogResult = await _dialogService.showDialog(CauseDialog(listCause));
  }

  List<InternalNotification>? get notifications =>
      _internalNotificationService.notifications;

  int get numberOfJoinedCampaigns {
    return currentUser!.getSelectedCampaigns().length;
  }

  // getCompletedActions
  int get numberOfCompletedActions {
    return currentUser!.getCompletedActions()!.length;
  }
  
  int get numberOfCompletedLearningResources {
    return currentUser!.getCompletedLearningResources()!.length;
  }

  // getActiveStarredActions
  int get numberOfStarredActions {
    return currentUser!.getStarredActions()!.length;
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

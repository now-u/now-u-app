import 'package:app/viewmodels/base_model.dart';
import 'package:app/viewmodels/base_campaign_model.dart';

import 'package:app/locator.dart';
import 'package:app/services/internal_notification_service.dart';
import 'package:app/services/navigation.dart';

import 'package:app/models/Notification.dart';

class HomeViewModel extends BaseModel with CampaignRO {
  final InternalNotificationService _internalNotificationService =
      locator<InternalNotificationService>();
  final NavigationService _navigationService = locator<NavigationService>();

  List<InternalNotification> get notifications =>
      _internalNotificationService.notifications;

  int get numberOfJoinedCampaigns {
    return currentUser.getSelectedCampaigns().length;
  }

  // getCompletedActions
  int get numberOfCompletedActions {
    return currentUser.getCompletedActions().length;
  }

  // getActiveStarredActions
  int get numberOfStarredActions {
    return currentUser.getStarredActions().length;
  }

  Future fetchAll() async {
    fetchNotifications();
    fetchCampaigns();
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
      description: "To suggest causes for future campaigns, fill in this Google Form",
      buttonText: "Go"
    );
  }
}

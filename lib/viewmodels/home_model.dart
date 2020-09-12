import 'package:app/viewmodels/base_model.dart';
import 'package:app/viewmodels/base_campaign_model.dart';

import 'package:app/locator.dart';
import 'package:app/services/internal_notification_service.dart';

import 'package:app/models/Notification.dart';

class HomeViewModel extends BaseModel with CampaignRO {

  List<InternalNotification> _notifications = [];
  List<InternalNotification> get notifications => _notifications;

  InternalNotificationService _internalNotificationService = locator<InternalNotificationService>();

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
    List<InternalNotification> notifications = await _internalNotificationService.getNotifications();
    _notifications = notifications;
    setBusy(false);
    notifyListeners();
  }

  Future dismissNotification(int id) async {
    bool success = await _internalNotificationService.dismissNotification(id);
    if (success) {
      _notifications.removeWhere((InternalNotification n) => n.getId() == id);
    }
    notifyListeners();
  }
}

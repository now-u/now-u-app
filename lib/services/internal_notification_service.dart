import 'package:app/models/Notification.dart';
import 'package:app/services/api_service.dart';

import 'package:app/locator.dart';

class InternalNotificationService {
  final ApiService _apiService = locator<ApiService>();

  List<InternalNotification>? _notifications = [];
  List<InternalNotification>? get notifications {
    return _notifications;
  }

  Future fetchNotifications() async {
    try {
      _notifications = await _apiService.getModelListRequest(
          "v1/users/me/notifications", InternalNotification.fromJson);
    } catch (e) {
      print("Error getting notifications");
    }
  }

  Future<bool> dismissNotification(int? notificationId) async {
    try {
      await _apiService
          .putRequest("v1/users/me/notifications/$notificationId/dismiss");
      _notifications!
          .removeWhere((InternalNotification n) => n.getId() == notificationId);
      return true;
    } catch (e) {
      print("Error dismissing notifications");
      return false;
    }
  }
}

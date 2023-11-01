import 'package:nowu/models/Notification.dart';

// TODO Move to apiv2
class InternalNotificationService {
  // final ApiService _apiService = locator<ApiService>();

  List<InternalNotification>? _notifications = [];
  List<InternalNotification>? get notifications {
    return _notifications;
  }

// TODO Fix
  Future fetchNotifications() async {
    // try {
    //   _notifications = await _apiService.getModelListRequest(
    //     'v1/users/me/notifications',
    //     InternalNotification.fromJson,
    //   );
    // } catch (e) {
    //   print('Error getting notifications');
    // }
  }

  Future<bool> dismissNotification(int? notificationId) async {
    return true;
    // try {
    //   await _apiService
    //       .putRequest('v1/users/me/notifications/$notificationId/dismiss');
    //   _notifications!
    //       .removeWhere((InternalNotification n) => n.getId() == notificationId);
    //   return true;
    // } catch (e) {
    //   print('Error dismissing notifications');
    //   return false;
    // }
  }
}

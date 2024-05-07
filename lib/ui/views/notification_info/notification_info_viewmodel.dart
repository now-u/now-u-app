import 'package:nowu/locator.dart';
import 'package:nowu/models/Notification.dart';
import 'package:nowu/router.dart';

import 'package:nowu/services/internal_notification_service.dart';
import 'package:nowu/services/router_service.dart';
import 'package:stacked/stacked.dart';

class NotificationInfoViewModel extends BaseViewModel {
  final InternalNotification notification;
  NotificationInfoViewModel(this.notification);

  final _internalNotificationService = locator<InternalNotificationService>();
  final _router = locator<AppRouter>();

  Future dismissNotification() async {
    bool success =
        await _internalNotificationService.dismissNotification(notification.id);
    if (success) {
      // TODO Whats the difference with pop?
      _router.back();
    }
    // TODO inform user of issue
  }
}

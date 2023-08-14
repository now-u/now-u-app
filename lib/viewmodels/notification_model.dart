import 'package:nowu/app/app.locator.dart';
import 'package:nowu/services/navigation_service.dart';

import 'package:nowu/services/internal_notification_service.dart';
import 'package:stacked/stacked.dart';

class NotificationViewModel extends BaseViewModel {
  InternalNotificationService? _internalNotificationService =
      locator<InternalNotificationService>();
  NavigationService? _navigationService = locator<NavigationService>();

  Future dismissNotification(int? id) async {
    bool success = await _internalNotificationService!.dismissNotification(id);
    if (success) {
      _navigationService!.goBack();
    }
    // TODO inform user of issue
  }
}

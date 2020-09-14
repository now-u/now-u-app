import 'package:app/viewmodels/base_model.dart';

import 'package:app/locator.dart';
import 'package:app/services/navigation.dart';

import 'package:app/services/internal_notification_service.dart';

class NotificationViewModel extends BaseModel {
  
  InternalNotificationService _internalNotificationService = locator<InternalNotificationService>();
  NavigationService _navigationService = locator<NavigationService>();

  Future dismissNotification(int id) async {
    bool success = await _internalNotificationService.dismissNotification(id);
    if (success) {
      _navigationService.goBack();
    }
    // TODO inform user of issue
  }
}

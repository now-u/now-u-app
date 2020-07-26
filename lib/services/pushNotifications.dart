import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:app/main.dart';
import 'package:app/locator.dart';
import 'package:app/services/navigation.dart';

class PushNotificationsService {
  final FirebaseMessaging _fcm  = FirebaseMessaging();
  final NavigationService _navigationService = locator<NavigationService>();

  Future init() async {
    if (Platform.isIOS) {
      _fcm.requestNotificationPermissions(IosNotificationSettings());
    }

    _fcm.configure(
      onMessage: (Map<String, dynamic> message) async {
        print('onMessage: $message');
      },
      onLaunch: (Map<String, dynamic> message) async {
        print('onLaunch: $message');
        _serialiseAndNavigate(message);
      },
      onResume: (Map<String, dynamic> message) async {
        print('onResume: $message');
        _serialiseAndNavigate(message);
      },
    );
  }

  void _serialiseAndNavigate(Map<String, dynamic> message) {
    var notificationData = message['data'];
    var view = notificationData['view'];

    if (view != null) {
      _navigationService.navigateTo(view);
    }
  }
}

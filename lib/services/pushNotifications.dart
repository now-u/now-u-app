import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:nowu/app/app.locator.dart';
import 'package:nowu/services/navigation_service.dart';

class PushNotificationService {
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  final LauncherService? _navigationService = locator<LauncherService>();

  Future init() async {
    if (Platform.isIOS) {
      await _fcm.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );
    }

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('onMessage: $message');
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('onMessage: $message');
      _serialiseAndNavigate(message);
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('onMessage: $message');
      _serialiseAndNavigate(message);
    });
  }

  void _serialiseAndNavigate(RemoteMessage message) {
    var notificationData = message.data;
    var view = notificationData['view'];

    if (view != null) {
      // TODO: Fix this!
      // ignore: deprecated_member_use_from_same_package
      _navigationService!.navigateTo(view);
    }
  }
}

import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationService {
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  // final NavigationService? _navigationService = locator<NavigationService>();

  Future init() async {
    await _fcm.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

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
      // _navigationService!.navigateTo(view);
    }
  }
}

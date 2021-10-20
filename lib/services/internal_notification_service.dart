import 'package:app/models/Notification.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:app/locator.dart';
import 'package:app/services/auth.dart';

class InternalNotificationService {
  final AuthenticationService? _authenticationService =
      locator<AuthenticationService>();

  List<InternalNotification>? _notifications = [];
  List<InternalNotification>? get notifications {
    return _notifications;
  }

  String domainPrefix = "https://api.now-u.com/api/v1/";

  Future fetchNotifications() async {
    try {
      http.Response response = await http.get(
          Uri.parse(domainPrefix + 'users/me/notifications'),
          headers: <String, String>{
            'token': _authenticationService!.currentUser!.getToken()!,
          });

      List<InternalNotification>? notifications = json
          .decode(response.body)['data']
          .map((e) => InternalNotification.fromJson(e))
          .toList()
          .cast<InternalNotification>();

      _notifications = notifications;
    } catch (e) {
      print("Error getting notifications");
    }
  }

  Future<bool> dismissNotification(int? notificationId) async {
    try {
      http.Response response = await http.put(
          Uri.parse(domainPrefix + 'users/me/notifications/$notificationId/dismiss'),
          headers: <String, String>{
            'token': _authenticationService!.currentUser!.getToken()!,
          });
      if (response.statusCode != 200) {
        print("Error dismissing notifications");
        print(response.statusCode);
        return false;
      }
      _notifications!
          .removeWhere((InternalNotification n) => n.getId() == notificationId);
      return true;
    } catch (e) {
      print("Error dismissing notifications");
      return false;
    }
  }
}

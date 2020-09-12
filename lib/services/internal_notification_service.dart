import 'package:app/models/Notification.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:app/locator.dart';
import 'package:app/services/auth.dart';

class InternalNotificationService {
  
  final AuthenticationService _authenticationService = locator<AuthenticationService>();
  
  String domainPrefix = "https://api.now-u.com/api/v1/";

  Future<List<InternalNotification>> getNotifications() async {
    try {
      http.Response response =
        await http.get(domainPrefix + 'users/me/notifications', headers: <String, String>{
          'token': _authenticationService.currentUser.getToken(),
        });

      List<InternalNotification> notifications = json.decode(response.body)['data'].map((e) => InternalNotification.fromJson(e)).toList().cast<InternalNotification>();
      
      return notifications;

    } catch(e) {
      print("Error getting notifications");
      return [];
    }
  }
  
  Future<bool> dismissNotification(int notificationId) async {
    try {
      http.Response response =
          await http.put(domainPrefix + 'users/me/notifications/$notificationId/dismiss', headers: <String, String>{
        'token': _authenticationService.currentUser.getToken(),
      });
      if (response.statusCode != 200) {
        print("Error dismissing notifications");
        print(response.statusCode);
        return false;
      }
      return true;
    } catch(e) {
      print("Error dismissing notifications");
      return false;
    }
  }

}


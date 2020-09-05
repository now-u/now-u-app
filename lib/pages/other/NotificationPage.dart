import 'package:app/assets/components/darkButton.dart';
import 'package:flutter/material.dart';

import 'package:app/models/Notification.dart';


class NotificationPage extends StatelessWidget {
  final InternalNotification notification;
  NotificationPage(this.notification);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Back Button
          Container(height: 20,),

          // Main Stuff
          Column(
            children: [
              Text(notification.getTitle()),
              notification.getBodyWidget(),
            ],
          ),
          
          // Dismiss Button 
          DarkButton(
            "Got it",
            onPressed: () {},
          )
        ],
      ),  
    );
  }
}

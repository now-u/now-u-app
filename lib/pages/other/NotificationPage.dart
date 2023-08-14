import 'package:nowu/assets/components/buttons/darkButton.dart';
import 'package:flutter/material.dart';

import 'package:nowu/assets/StyleFrom.dart';
import 'package:nowu/assets/components/custom_network_image.dart';

import 'package:nowu/models/Notification.dart';

import 'package:stacked/stacked.dart';
import 'package:nowu/viewmodels/notification_model.dart';

class NotificationPage extends StatelessWidget {
  final InternalNotification notification;
  NotificationPage(this.notification);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorDark,
      body: ViewModelBuilder<NotificationViewModel>.reactive(
        viewModelBuilder: () => NotificationViewModel(),
        builder: (context, model, child) {
          return ListView(
            children: [
              // Back Button
              SafeArea(
                child: GestureDetector(
                  onTap: Navigator.of(context).pop,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Icon(
                        Icons.chevron_left,
                        size: 35,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                ),
              ),

              // Main Stuff
              CustomNetworkImage(notification.getImage(), height: 150),
              const SizedBox(height: 60),
              Text(
                notification.getTitle()!,
                style: textStyleFrom(
                  Theme.of(context).textTheme.headlineMedium,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                child: notification.getBodyWidget(context),
              ),

              // Dismiss Button
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DarkButton(
                    'Got it',
                    onPressed: () {
                      model.dismissNotification(notification.getId());
                    },
                  ),
                ],
              ),
              const SizedBox(height: 40),
            ],
          );
        },
      ),
    );
  }
}

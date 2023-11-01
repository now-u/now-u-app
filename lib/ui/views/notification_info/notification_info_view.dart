import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'package:nowu/assets/components/buttons/darkButton.dart';
import 'package:nowu/assets/components/custom_network_image.dart';
import 'package:nowu/models/Notification.dart';
import 'package:nowu/themes.dart';

import 'notification_info_viewmodel.dart';

class NotificationInfoView extends StackedView<NotificationInfoViewModel> {
  final InternalNotification notification;
  const NotificationInfoView({required this.notification});

  @override
  NotificationInfoViewModel viewModelBuilder(BuildContext context) =>
      NotificationInfoViewModel(notification);

  @override
  Widget builder(
    BuildContext context,
    NotificationInfoViewModel viewModel,
    Widget? child,
  ) {
    return Theme(
      data: darkTheme,
      child: Scaffold(
        body: ListView(
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
              style: Theme.of(context).textTheme.headlineMedium,
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
                // TODO Remove dark button
                DarkButton(
                  'Got it',
                  onPressed: viewModel.dismissNotification,
                ),
              ],
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

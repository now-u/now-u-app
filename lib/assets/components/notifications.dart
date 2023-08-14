import 'package:flutter/material.dart';

import 'package:nowu/assets/StyleFrom.dart';
import 'package:nowu/assets/components/customTile.dart';

import 'package:nowu/routes.dart';

import 'package:nowu/models/Notification.dart';

class NotificationTile extends StatelessWidget {
  final InternalNotification notification;
  final Function dismissFunction;

  NotificationTile(this.notification, {required this.dismissFunction});
  @override
  Widget build(BuildContext context) {
    return CustomTile(
      onClick: () {
        Navigator.of(context)
            .pushNamed(Routes.notification, arguments: notification);
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon
          Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: const BorderRadius.all(Radius.circular(8.0)),
              ),
              child: const Padding(
                padding: EdgeInsets.all(8),
                child: Icon(
                  Icons.notifications_active,
                  color: Colors.white,
                ),
              ),
            ),
          ),

          const SizedBox(width: 2),

          // Text
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                const SizedBox(height: 10),
                Text(
                  notification.getTitle()!,
                  style: Theme.of(context).textTheme.displayMedium,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                Text(
                  notification.getSubtitle() ?? '',
                  style: textStyleFrom(
                    Theme.of(context).textTheme.bodyLarge,
                    fontSize: 11,
                  ),
                )
              ],
            ),
          ),

          // Dismiss button
          Padding(
            padding: const EdgeInsets.all(8),
            child: Container(
              child: MaterialButton(
                onPressed: () {
                  dismissFunction(notification.getId());
                },
                elevation: 2.0,
                minWidth: 0,
                color: const Color.fromRGBO(196, 196, 196, 1),
                child: const Icon(
                  Icons.close,
                  color: Colors.white,
                ),
                padding: const EdgeInsets.all(0),
                shape: const CircleBorder(),
                height: 10,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

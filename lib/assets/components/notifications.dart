import 'package:flutter/material.dart';

import 'package:app/assets/StyleFrom.dart';
import 'package:app/assets/components/customTile.dart';

import 'package:app/models/Notification.dart';

class NotificationTile extends StatelessWidget {
  final InternalNotification notification;

  NotificationTile(this.notification);
  @override
  Widget build(BuildContext context) {
    return CustomTile(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          // Icon
          Padding(
            padding: EdgeInsets.all(10),
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.all(Radius.circular(8.0))
              ),
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Icon(
                  Icons.notifications_active,
                  color: Colors.white,
                ),
              ),
            )
          ),

          SizedBox(width: 2),

          // Text
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(height: 10),
                Text(
                  notification.getTitle(),
                  style: Theme.of(context).primaryTextTheme.headline4,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                Text(
                  notification.getSubtitle(),
                  style: textStyleFrom(
                    Theme.of(context).primaryTextTheme.bodyText1,
                    fontSize: 11,
                  ),
                )
              ],
            ),
          ),

          // Dismiss button
          Padding(
            padding: EdgeInsets.all(8),
            child: Container(
              child: MaterialButton(
                onPressed: () {},
                elevation: 2.0,
                minWidth: 0,
                color: Color.fromRGBO(196,196,196,1),
                child: Icon(
                  Icons.close,
                  color: Colors.white,
                ),
                padding: EdgeInsets.all(0),
                shape: CircleBorder(),
                height: 10,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
            ),
          ),
        ],
      )
    );
  }
}

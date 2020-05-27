import 'package:flutter/material.dart';
import 'package:flushbar/flushbar.dart';

import 'package:app/assets/components/progress.dart';

Flushbar pointsNotifier (int points, int nextBadgePoints, BuildContext context) {

  return notifier("Congrats! You just earned ${points} for joining a campaign. ${nextBadgePoints - points} points till your next bage", points / nextBadgePoints, context);
}

Flushbar notifier(String message, double progress, BuildContext context) {
  return 
    Flushbar(
      duration:  Duration(seconds: 3),              
      flushbarPosition: FlushbarPosition.TOP,
      borderRadius: 10,
      backgroundColor: Colors.white,
      titleText: Padding(
        padding: EdgeInsets.all(10),
        child: RichText(
          text: TextSpan(
            style: Theme.of(context).primaryTextTheme.bodyText1,
            children: <TextSpan> [
              TextSpan(
                text: message,
              ),
            ]
          ),
        )
      ),
      messageText: 
        Container(
          width: double.infinity,
          height: 20,
          child: Align(
            alignment: Alignment.center,
            child: ProgressBar(
                progress: 0.6, 
                widthAsDecimal: 0.9,
                toDoColor: Colors.grey,
                doneColor: Theme.of(context).primaryColor
            ),
          ),
        ),
    );
}

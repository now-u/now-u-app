import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flushbar/flushbar.dart';

import 'package:app/assets/routes/customRoute.dart';

import 'package:app/models/Badge.dart';
import 'package:app/models/Campaign.dart';
import 'package:app/models/Action.dart';
import 'package:app/models/ViewModel.dart';
import 'package:app/models/Reward.dart';

import 'package:app/pages/other/RewardComplete.dart';

import 'package:app/main.dart';

import 'package:app/assets/StyleFrom.dart';
import 'package:app/assets/components/progress.dart';

void joinCampaign(ViewModel viewModel, BuildContext context, Campaign campaign) {
  if (!viewModel.userModel.user.getSelectedCampaigns().contains(campaign.getId())) {
    viewModel.userModel.user.addSelectedCamaping(campaign.getId());
    viewModel.onSelectCampaigns(viewModel.userModel.user, (int points, int nextBadgePoints, bool newBadge) {
      if (!newBadge) {
        pointsNotifier(viewModel.userModel.user.getPoints(), points, nextBadgePoints, context)..show(context);
      }
      else {
        Text("You did not get a new badge");
        gotBadgeNotifier(
          badge: getNextBadgeFromInt(viewModel.userModel.user.getPoints()),
          context: context,
        );
      }
    });
  }   
}

void completeAction(ViewModel viewModel, BuildContext context, CampaignAction action) {
  if (!viewModel.userModel.user.getCompletedActions().contains(action.getId())) {
    viewModel.onCompleteAction(action, (int points, int nextBadgePoints, bool newBadge) {
      // If you did not get a new badge
      if (!newBadge) {
        List<Reward> newlyCompletedRewards = viewModel.userModel.user.newlyCompletedRewards(action);
        // If you did get a new reward
        if (newlyCompletedRewards.length > 0) {
          Navigator.push(
            context, 
            CustomRoute(builder: (context) => RewardCompletePage(viewModel, newlyCompletedRewards))
          );
        }
        // Otherwise just shw the popup
        else {
        pointsNotifier(viewModel.userModel.user.getPoints(), points, nextBadgePoints, context)..show(context);
        }
      }
      // If you did get a new badge then show that popup
      else {
          Text("You did not get a new badge");
          gotBadgeNotifier(
            badge: getNextBadgeFromInt(viewModel.userModel.user.getPoints()),
            context: context,
          );
      }
    });
  }   
}


Flushbar pointsNotifier (int userPoints, int earnedPoints, int nextBadgePoints, BuildContext context) {

  return notifier("Congrats! You just earned ${earnedPoints} for joining a campaign. ${nextBadgePoints - (userPoints)} points till your next bage", userPoints / nextBadgePoints, context);
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
                progress: progress, 
                widthAsDecimal: 0.9,
                toDoColor: Colors.grey,
                doneColor: Theme.of(context).primaryColor
            ),
          ),
        ),
    );
}

Function gotBadgeNotifier({
    Badge badge,
    BuildContext context,
  }) {

  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (_) => AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(35),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width * 0.5,
            child: Text(
              "Congratulations",
              style: Theme.of(context).primaryTextTheme.headline2,
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.65,
            child: Text(
              "You earned a new badge",
              style: Theme.of(context).primaryTextTheme.bodyText1,
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Container(
              height: 120,
              width: 120,
              child:
                Image.asset(badge.getImage()),
            )
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.5,
            child: Text(
              badge.getName(),
              style: Theme.of(context).primaryTextTheme.headline2,
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 20),
          Container(
            width: MediaQuery.of(context).size.width * 0.65,
            child: Text(
              badge.getSuccessMessage(),
              style: Theme.of(context).primaryTextTheme.bodyText1,
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 20),
          Container(
            width: MediaQuery.of(context).size.width * 0.65,
            child: RichText(
              textAlign: TextAlign.center,
              text:  TextSpan(
                children: [
                  TextSpan(
                    text: "See all your achievements in your ",
                    style: Theme.of(context).primaryTextTheme.bodyText1
                  ),
                  TextSpan(
                    text: "profile",
                    style: textStyleFrom(
                      Theme.of(context).primaryTextTheme.bodyText1,
                      color: Theme.of(context).buttonColor,
                    ),
                  recognizer: TapGestureRecognizer()..onTap = () {
                    Navigator.pushNamed(context, Routes.profile);
                  }
                    
                  ),
                  TextSpan(
                    text: ".",
                    style: Theme.of(context).primaryTextTheme.bodyText1
                  ),
                ]
              ),
            ),
          )
        ],
      ),
    )
  );
}

Function showBage({
    bool locked,
    BuildContext context,
    Badge badge,
  }) {

  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (_) => AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(35),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(10),
            child: Container(
              height: 120,
              width: 120,
              child:
                locked ? 
                Icon(
                  Icons.lock, 
                  size: 60,
                  color: Theme.of(context).primaryColor
                ) :
                Image.asset(badge.getImage()),
            )
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.5,
            child: Text(
              locked ? "Locked" :
              badge.getName(),
              style: Theme.of(context).primaryTextTheme.headline2,
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 20),
          Container(
            width: MediaQuery.of(context).size.width * 0.65,
            child: Text(
              locked ? "You need ${badge.getPoints()} points to unlock this badge" :
              badge.getSuccessMessage(),
              style: Theme.of(context).primaryTextTheme.bodyText1,
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    )
  );
}

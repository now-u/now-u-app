import 'package:flutter/foundation.dart';
import 'package:app/models/Action.dart';
import 'package:tuple/tuple.dart';
import 'dart:math';

// Must be kept in this order
enum RewardType {
  CompletedCampaignsNumber,
  CompletedActionsNumber,
  CompletedTypedActionsNumber,
  SelectInOneMonthCampaignsNumber,
  //CompleteCampaignsNumber
}

List motivationalPostfix = [
  "Great work",
  "Keep it up",
  "You're amazing",
];

class Reward {
  final random = new Random();
  //final int id;
  String? title;
  //String _description;

  // Number required to complete action
  final int successNumber;

  final RewardType type;
  final CampaignActionType? actionType;

  Reward({
    //@required this.id,
    String? title,
    required this.successNumber,
    required this.type,
    this.actionType, // This is required if type = CompletedTypedActionsNumber
  }) {
    this.title = title ?? generateTitle();
  }

  String generateTitle() {
    String endingPlural = successNumber > 1 ? "s" : "";
    if (type == RewardType.CompletedTypedActionsNumber) {
      Tuple3<String?, String?, String?> descPrePostFix =
          generateCampaingActionDesc(actionType);
      String pre = descPrePostFix.item1!;
      String post = descPrePostFix.item3!;
      return (pre + " ${successNumber} " + post + "${endingPlural}");
    }
    if (type == RewardType.CompletedActionsNumber) {
      return "Complete ${successNumber} action${endingPlural}";
    }

    if (type == RewardType.CompletedCampaignsNumber) {
      return "Complete ${successNumber} campaign${endingPlural}";
    }

    return "";
  }

  String generateCompletionText() {
    if (type == RewardType.CompletedTypedActionsNumber) {
      Tuple3<String?, String?, String?> descPrePostFix =
          generateCampaingActionDesc(actionType);
      String pre = descPrePostFix.item2!;
      String post = descPrePostFix.item3!;
      String endingPlural = successNumber > 1 ? "s" : "";
      return ("You " +
          pre +
          " ${successNumber} " +
          post +
          "${endingPlural}. " +
          motivationalPostfix[random.nextInt(motivationalPostfix.length)] +
          ".");
    }
    return "";
  }

  String? getTitle() {
    return title;
  }

  RewardType getType() {
    return type;
  }

  CampaignActionType? getActionType() {
    return actionType;
  }
}

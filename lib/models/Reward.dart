import 'package:flutter/foundation.dart';
import 'package:app/models/Action.dart';

// Must be kept in this order
enum RewardType {
  CompletedCampaignsNumber,
  CompletedActionsNumber,
  CompletedTypedActionsNumber,
  SelectInOneMonthCampaignsNumber,
  //CompleteCampaignsNumber
}

class Reward {
  //final int id;
  final String title;
  //String _description;

  // Number required to complete action
  final int successNumber;

  final RewardType type;
  final CampaignActionType actionType;

  Reward({
    //@required this.id, 
    @required this.title, 
    @required this.successNumber,
    @required this.type,
    this.actionType, // This is required if type = CompletedTypedActionsNumber
  });

  //int getId() {
  //  return id;
  //}
  String getTitle() {
    return title;
  }
  RewardType getType() {
    return type;
  }
  CampaignActionType getActionType() {
    return actionType;
  }
}


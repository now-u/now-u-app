import 'package:flutter/foundation.dart';

// 
enum RewardType {
  CompletedCampaignsNumber,
  CompletedActionsNumber,
  CompletedTypedActionsNumber,
  SelectInOneMonthCampaignsNumber,
  //CompleteCampaignsNumber
}

class Reward {
  final int id;
  final String title;
  //String _description;

  // Number required to complete action
  int successNumber;

  final RewardType type;

  Reward({
    @required this.id, 
    @required this.title, 
    @required this.successNumber,
    @required this.type,
  });

  int getId() {
    return id;
  }
  String getTitle() {
    return title;
  }
  RewardType getType() {
    return type;
  }
}


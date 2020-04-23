import 'package:flutter/foundation.dart';

enum CampaignActionType {
  Petition,
  Email,
  Donation,
  Learn,
  Socail,
  Volunteer,
  Shop,
  Other 
}

class CampaignAction {
  int id;
  String title;
  String description;
  String link;
  CampaignActionType type;

  CampaignAction({
    @required int id, 
    @required String title, 
    @required String description, 
    @required String link,
    @required CampaignActionType type,
  }) {
    this.id = id; 
    this.title = title;
    this.description = description;
    this.link = link;
    this.type = type;
  }

  int getId() {
    return id; 
  }
  String getTitle() {
    return title; 
  }
  String getDescription() {
    return description; 
  }
  String getLink() {
    return link; 
  }
  CampaignActionType getType() {
    return type; 
  }
}

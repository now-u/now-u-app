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


CampaignActionType campaignActionTypeFromString (String s) {
  switch (s) {
    case "petiton": {
      return CampaignActionType.Petition;
    }
    case "email": {
      return CampaignActionType.Email;
    }
    case "donation": {
      return CampaignActionType.Donation;
    }
    case "learn": {
      return CampaignActionType.Learn;
    }
    case "social": {
      return CampaignActionType.Socail;
    }
    case "volunteer": {
      return CampaignActionType.Volunteer;
    }
    case "shop": {
      return CampaignActionType.Shop;
    }
    default: {
      return CampaignActionType.Other; 
    }
  }
  
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

  CampaignAction.fromJson(Map json) {
    print(json);
    id = json['id'];
    title = json['title'];
    description = json['description'];
    link = json['link'];
    type = campaignActionTypeFromString(json['link']);
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

import 'package:flutter/foundation.dart';
import 'package:tuple/tuple.dart';

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

Tuple3<String, String, String> generateCampaingActionDesc (CampaignActionType t) {
  switch (t) {
    case CampaignActionType.Petition: {
      return Tuple3("Sign", "Signed", "petition");
    }
    case CampaignActionType.Email: {
      return Tuple3("Send", "Sent", "email");
    }
    case CampaignActionType.Donation: {
      return Tuple3("Make", "Made", "donation");
    }
    case CampaignActionType.Learn: {
      return Tuple3("Complete", "Completed", "learning action");
    }
    case CampaignActionType.Socail: {
      return Tuple3("Share", "Shared", "time");
    }
    case CampaignActionType.Volunteer: {
      return Tuple3("Volunteer", "Volunteered", "time");
    }
    case CampaignActionType.Shop: {
      return Tuple3("Make", "Made", "purchase");
    }
    default: {
      return Tuple3("Complete", "Completed", "special action");
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
    //print(json);
    id = json['id'];
    title = json['title'];
    description = json['description'];
    link = json['link'];
    type = campaignActionTypeFromString(json['type']);
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

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

Tuple2<String, String> generateCampaingActionDesc (CampaignActionType t) {
  switch (t) {
    case CampaignActionType.Petition: {
      return Tuple2("Sign", "petition");
    }
    case CampaignActionType.Email: {
      return Tuple2("Send", "email");
    }
    case CampaignActionType.Donation: {
      return Tuple2("Make", "donation");
    }
    case CampaignActionType.Learn: {
      return Tuple2("Complete", "learning action");
    }
    case CampaignActionType.Socail: {
      return Tuple2("Share", "time");
    }
    case CampaignActionType.Volunteer: {
      return Tuple2("Volunteer", "time");
    }
    case CampaignActionType.Socail: {
      return Tuple2("Make", "purchase");
    }
    default: {
      return Tuple2("Complte", "special action");
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

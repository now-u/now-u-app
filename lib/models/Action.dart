import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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

Map defaultCampaignActionTypeData = 
  {
    'type': CampaignActionType.Other,        
    'name': "other",          
    'verb': "Complete", 
    'pastVerb': "Completed", 
    'displayName': "special action", 
    'icon': FontAwesomeIcons.check, 
    'iconColor': Colors.red,
    'iconBackgroundColor': Colors.redAccent
  };

List<Map> campaignActionTypeData = [
  {
    'type': CampaignActionType.Petition,
    'name': "petition", 
    'verb': "Sign", 
    'pastVerb': "Signed", 
    'displayName': "petiton", 
    'icon': FontAwesomeIcons.signature, 
    'iconColor': Colors.red,
    'iconBackgroundColor': Colors.redAccent
  },
  {
    'type': CampaignActionType.Email,        
    'name': "email", 
    'verb': "Send", 
    'pastVerb': "Sent", 
    'displayName': "email", 
    'icon': FontAwesomeIcons.envelope, 
    'iconColor': Colors.red,
    'iconBackgroundColor': Colors.redAccent
  },
  {
    'type': CampaignActionType.Donation,     
    'name': "donation", 
    'verb': "Make", 
    'pastVerb': "Made", 
    'displayName': "donation", 
    'icon': FontAwesomeIcons.envelope, 
    'iconColor': Colors.red,
    'iconBackgroundColor': Colors.redAccent
  },
  {
    'type': CampaignActionType.Learn,        
    'name': "learn", 
    'verb': "Complete", 
    'pastVerb': "Completed", 
    'displayName': "learning action", 
    'icon': FontAwesomeIcons.book, 
    'iconColor': Colors.red,
    'iconBackgroundColor': Colors.redAccent
  },
  {
    'type': CampaignActionType.Socail,       
    'name': "social", 
    'verb': "Share", 
    'pastVerb': "Shared", 
    'displayName': "time", 
    'icon': FontAwesomeIcons.share, 
    'iconColor': Colors.red,
    'iconBackgroundColor': Colors.redAccent
  },
  {
    'type': CampaignActionType.Volunteer,    
    'name': "volunteer", 
    'verb': "Volunteer", 
    'pastVerb': "Volunteered", 
    'displayName': "time", 
    'icon': FontAwesomeIcons.personBooth, 
    'iconColor': Colors.red,
    'iconBackgroundColor': Colors.redAccent
  },
  {
    'type': CampaignActionType.Shop,         
    'name': "shop", 
    'verb': "Make", 
    'pastVerb': "Made", 
    'displayName': "purchase", 
    'icon': FontAwesomeIcons.coins, 
    'iconColor': Colors.red,
    'iconBackgroundColor': Colors.redAccent
  },
  defaultCampaignActionTypeData,
];

CampaignActionType campaignActionTypeFromString (String s) {
  for (int i =0; i < campaignActionTypeData.length; i++) {
    if (campaignActionTypeData[i]['name'] == s) {
      return campaignActionTypeData[i]['type'];
    }
  }
  return CampaignActionType.Other;
}

Tuple3<String, String, String> generateCampaingActionDesc (CampaignActionType t) {
  for (int i =0; i < campaignActionTypeData.length; i++) {
    if (campaignActionTypeData[i]['type'] == t) {
      return Tuple3(campaignActionTypeData[i]['verb'], campaignActionTypeData[i]['pastVerb'], campaignActionTypeData[i]['displayName']);
    }
  }
  return Tuple3("Complete", "Completed", "special action");
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
  Map getActionIconMap () {
    for (int i =0; i < campaignActionTypeData.length; i++) {
      if (campaignActionTypeData[i]['type'] == type) {
        return {
          'icon': campaignActionTypeData[i]['icon'],
          'iconColor': campaignActionTypeData[i]['iconColor'],
          'iconBackgroundColor': campaignActionTypeData[i]['iconBackgroundColor']
        };
      }
    }
    return defaultCampaignActionTypeData;
  }

}

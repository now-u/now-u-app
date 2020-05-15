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
    'name': "other",          
    'verb': "Complete", 
    'pastVerb': "Completed", 
    'displayName': "special action", 
    'icon': FontAwesomeIcons.check, 
    'iconColor': Colors.red,
    'iconBackgroundColor': Colors.redAccent
  };

Map campaignActionTypeData = {
  CampaignActionType.Petition: {
    'name': "petition", 
    'verb': "Sign", 
    'pastVerb': "Signed", 
    'displayName': "petiton", 
    'icon': FontAwesomeIcons.signature, 
    'iconColor': Colors.red,
    'iconBackgroundColor': Colors.redAccent
  },
  CampaignActionType.Email: {
    'name': "email", 
    'verb': "Send", 
    'pastVerb': "Sent", 
    'displayName': "email", 
    'icon': FontAwesomeIcons.envelope, 
    'iconColor': Color.fromRGBO(255, 136,0, 1),
    'iconBackgroundColor': Color.fromRGBO(255, 136, 0, 0.15)
  },
  CampaignActionType.Donation: {
    'name': "donation", 
    'verb': "Make", 
    'pastVerb': "Made", 
    'displayName': "donation", 
    'icon': FontAwesomeIcons.handHoldingHeart, 
    'iconColor': Color.fromRGBO(211, 0, 1, 1),
    'iconBackgroundColor': Color.fromRGBO(211, 0, 1, 0.15)
  },
  CampaignActionType.Learn: {
    'name': "learn", 
    'verb': "Complete", 
    'pastVerb': "Completed", 
    'displayName': "learning action", 
    'icon': FontAwesomeIcons.book, 
    'iconColor': Colors.red,
    'iconBackgroundColor': Colors.redAccent
  },
  CampaignActionType.Socail: {
    'type': CampaignActionType.Socail,       
    'name': "social", 
    'verb': "Share", 
    'pastVerb': "Shared", 
    'displayName': "time", 
    'icon': FontAwesomeIcons.share, 
    'iconColor': Colors.red,
    'iconBackgroundColor': Colors.redAccent
  },
  CampaignActionType.Volunteer: {
    'name': "volunteer", 
    'verb': "Volunteer", 
    'pastVerb': "Volunteered", 
    'displayName': "time", 
    'icon': FontAwesomeIcons.personBooth, 
    'iconColor': Colors.red,
    'iconBackgroundColor': Colors.redAccent
  },
  CampaignActionType.Shop: {
    'name': "shop", 
    'verb': "Make", 
    'pastVerb': "Made", 
    'displayName': "purchase", 
    'icon': FontAwesomeIcons.coins, 
    'iconColor': Color.fromRGBO(243, 183,0, 1),
    'iconBackgroundColor': Color.fromRGBO(243, 183, 0, 0.15)
  },
  CampaignActionType.Other: defaultCampaignActionTypeData
};

CampaignActionType campaignActionTypeFromString (String s) {
  // Apparently if we return early it just doesnt do the return? Not sure why that would be but this seems to fix it
  CampaignActionType t = CampaignActionType.Other;
  campaignActionTypeData.forEach((key, value) {
    print("Checking if " + value['name'] + " == " + s);
    if (value['name'] == s) {
      print("MATCH");
      t = key;
    }
  });
  return t;
}

Tuple3<String, String, String> generateCampaingActionDesc (CampaignActionType t) {
  print("Getting campaing aciton desc");
  if (campaignActionTypeData.containsKey(t)) {
    print("Found key");
    print(campaignActionTypeData[t]['name']);
    print("Looking for the thing");
    return Tuple3(campaignActionTypeData[t]['verb'], campaignActionTypeData[t]['pastVerb'], campaignActionTypeData[t]['displayName']);

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
    print("Getting the actionicon map for");
    print(type.toString());
    if (campaignActionTypeData.containsKey(type)) {
      return {
        'icon': campaignActionTypeData[type]['icon'],
        'iconColor': campaignActionTypeData[type]['iconColor'],
        'iconBackgroundColor': campaignActionTypeData[type]['iconBackgroundColor']
      };
    }
    return defaultCampaignActionTypeData;
  }

}

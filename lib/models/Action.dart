import 'package:app/assets/StyleFrom.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

enum CampaignActionType {
  Volunteer,
  Donation,
  Fundraise,
  Awareness,
  Petition,
  Behaviour,
  Contact,
  Protest,
  Connect,
  Learn,
  Quiz,
  Other 
}

Color red = Color.fromRGBO(211, 0, 1, 1);
Color redO = colorFrom(red, opacity: 0.15);
Color orange = Color.fromRGBO(255, 136, 0, 1);
Color orangeO = colorFrom(orange, opacity: 0.15);
Color yellow = Color.fromRGBO(243, 183,0, 1);
Color yellowO = colorFrom(yellow, opacity: 0.15);
Color blue = Color.fromRGBO(1, 26, 67, 1);
Color blueO = colorFrom(blue, opacity: 0.15);

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
  CampaignActionType.Volunteer: {
    'name': "volunteer", 
    'verb': "Volunteer", 
    'pastVerb': "Volunteered", 
    'displayName': "volunteer", 
    'icon': FontAwesomeIcons.handsHelping, 
    'iconColor': red,
    'iconBackgroundColor': redO,
  },
  CampaignActionType.Donation: {
    'name': "donation", 
    'verb': "Make", 
    'pastVerb': "Made", 
    'displayName': "donation", 
    'icon': FontAwesomeIcons.handHoldingHeart, 
    'iconColor': yellow,
    'iconBackgroundColor': yellowO,
  },
  CampaignActionType.Fundraise: {
    'name': "fundraise", 
    'verb': "Take part in", 
    'pastVerb': "Took part in", 
    'displayName': "fundraiser", 
    'icon': FontAwesomeIcons.moneyBillWaveAlt, 
    'iconColor': yellow,
    'iconBackgroundColor': yellowO,
  },
  CampaignActionType.Awareness: {
    'name': "awareness", 
    'verb': "Raise awareness", 
    'pastVerb': "Raised awareness", 
    'displayName': "time", 
    'icon': FontAwesomeIcons.share, 
    'iconColor': orange,
    'iconBackgroundColor': orangeO,
  },
  CampaignActionType.Petition: {
    'name': "petition", 
    'verb': "Sign", 
    'pastVerb': "Signed", 
    'displayName': "petiton", 
    'icon': FontAwesomeIcons.signature, 
    'iconColor': orange,
    'iconBackgroundColor': orangeO,
  },
  CampaignActionType.Behaviour: {
    'name': "behaviour", 
    'verb': "Complete", 
    'pastVerb': "Completed", 
    'displayName': "behaviour change action", 
    'icon': FontAwesomeIcons.streetView, 
    'iconColor': red,
    'iconBackgroundColor': redO,
  },
  CampaignActionType.Contact: {
    'name': "contact", 
    'verb': "Complete", 
    'pastVerb': "Completed", 
    'displayName': "contact change action", 
    'icon': FontAwesomeIcons.phone, 
    'iconColor': orange,
    'iconBackgroundColor': orangeO,
  },
  CampaignActionType.Protest: {
    'name': "protest", 
    'verb': "Take part in", 
    'pastVerb': "Took part in", 
    'displayName': "protest", 
    'icon': FontAwesomeIcons.sign, 
    'iconColor': red,
    'iconBackgroundColor': redO,
  },
  CampaignActionType.Connect: {
    'name': "connect", 
    'verb': "Connect", 
    'pastVerb': "Connted", 
    'displayName': "times", 
    'icon': FontAwesomeIcons.link, 
    'iconColor': red,
    'iconBackgroundColor': redO,
  },
  CampaignActionType.Learn: {
    'name': "learn", 
    'verb': "Complete", 
    'pastVerb': "Completed", 
    'displayName': "learning action", 
    'icon': FontAwesomeIcons.userGraduate, 
    'iconColor': blue,
    'iconBackgroundColor': blueO,
  },
  CampaignActionType.Quiz: {
    'name': "quiz", 
    'verb': "Complete", 
    'pastVerb': "Completed", 
    'displayName': "quiz", 
    'icon': FontAwesomeIcons.question, 
    'iconColor': blue,
    'iconBackgroundColor': blueO,
  },
  CampaignActionType.Other: defaultCampaignActionTypeData
};

CampaignActionType campaignActionTypeFromString (String s) {
  // Apparently if we return early it just doesnt do the return? Not sure why that would be but this seems to fix it
  CampaignActionType t = CampaignActionType.Other;
  campaignActionTypeData.forEach((key, value) {
    if (value['name'] == s) {
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
  double time;
  String whatDescription;
  String whyDescription;
  String link;
  CampaignActionType type;

  CampaignAction({
    @required int id, 
    @required String title, 
    @required String whatDescription, 
    @required String whyDescription, 
    @required String link,
    @required CampaignActionType type,
    @required double time,
  }) {
    this.id = id; 
    this.title = title;
    this.whatDescription = whatDescription;
    this.whyDescription = whyDescription;
    this.link = link;
    this.type = type;
    this.time = time;
  }

  CampaignAction.fromJson(Map json) {
    //print(json);
    id = json['id'];
    title = json['title'];
    whatDescription = json['what_description'];
    whyDescription = json['why_description'];
    link = json['link'];
    time = json['time'];
    type = campaignActionTypeFromString(json['type']);
  }

  int getId() {
    return id; 
  }
  String getTitle() {
    return title; 
  }
  String getWhatDescription() {
    return whatDescription; 
  }
  String getWhyDescription() {
    return whyDescription; 
  }
  String getLink() {
    return link; 
  }
  double getTime() {
    return time; 
  }
  String getTimeText() {
    return "1-2 mins"; 
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

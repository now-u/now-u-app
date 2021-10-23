import 'package:app/assets/StyleFrom.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';
import 'package:app/models/Cause.dart';

import 'package:app/locator.dart';
import 'package:app/services/causes_service.dart';

// Custom Icons
import 'package:app/assets/icons/customIcons.dart';

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

List<String> rejectionReasons = [
  "It requires too much effort",
  "It takes too long",
  "It does not seem useful/impactful",
  "I have completed too many of these",
  "This is not something I like doing",
  "Other",
];

// Depreciated
Color red = Color.fromRGBO(211, 0, 1, 1);
Color redO = colorFrom(red, opacity: 0.15);

Color green = Color.fromRGBO(89, 152, 26, 0.7);
Color greenO = colorFrom(green, opacity: 0.2);
Color orange = Color.fromRGBO(255, 136, 0, 0.7);
Color orangeO = colorFrom(orange, opacity: 0.2);
Color yellow = Color.fromRGBO(243, 183, 0, 0.7);
Color yellowO = colorFrom(yellow, opacity: 0.2);
Color blue = Color.fromRGBO(38, 151, 211, 0.7);
Color blueO = colorFrom(blue, opacity: 0.2);

class ActionType {
  String name;
  IconData icon;
  Color primaryColor;
  Color secondaryColor;

  ActionType({
    required this.name,
    required this.icon,
    required this.primaryColor,
    required this.secondaryColor
  });
}

ActionType getInvolved = ActionType(
  name: "Get involved",
  icon: CustomIcons.ic_getinvolved,
  primaryColor: orange,
  secondaryColor: orangeO,
);
ActionType learn = ActionType(
  name: "Learn",
  icon: CustomIcons.ic_learning,
  primaryColor: blue,
  secondaryColor: blueO,
);
ActionType advocate = ActionType(
  name: "Advoacte",
  icon: CustomIcons.ic_raiseawareness,
  primaryColor: orange,
  secondaryColor: orangeO,
);
ActionType raiseMoney = ActionType(
  name: "Raise money",
  icon: CustomIcons.ic_raisemoney,
  primaryColor: yellow,
  secondaryColor: yellowO,
);
List<ActionType> actionTypes = [getInvolved, learn, advocate, raiseMoney];

Map defaultCampaignActionTypeData = {
  'name': "other",
  'verb': "Complete",
  'pastVerb': "Completed",
  'displayName': "special action",
  //'icon': FontAwesomeIcons.check,
  //'Type': CustomIcons.heartHand,
  'type': getInvolved,
};

Map campaignActionTypeData = {
  CampaignActionType.Volunteer: {
    'name': "volunteer",
    'verb': "Volunteer",
    'pastVerb': "Volunteered",
    'displayName': "volunteer",
    //'icon': CustomIcons.icon_vol_1,
    'type': getInvolved,
  },
  CampaignActionType.Donation: {
    'name': "donate",
    'verb': "Make",
    'pastVerb': "Made",
    'displayName': "donation",
    //'icon': CustomIcons.icon_donate_01,
    'type': raiseMoney,
  },
  CampaignActionType.Fundraise: {
    'name': "fundraise",
    'verb': "Take part in",
    'pastVerb': "Took part in",
    'displayName': "fundraiser",
    //'icon': CustomIcons.icon_fundraise_01,
    'type': raiseMoney,
  },
  CampaignActionType.Awareness: {
    'name': "awareness",
    'verb': "Raise awareness",
    'pastVerb': "Raised awareness",
    'displayName': "time",
    //'icon': CustomIcons.icon_raise_awareness_01_01,
    'type': advocate,
  },
  CampaignActionType.Petition: {
    'name': "sign",
    'verb': "Sign",
    'pastVerb': "Signed",
    'displayName': "petiton",
    //'icon': CustomIcons.icon_petition_01,
    'type': advocate,
  },
  CampaignActionType.Behaviour: {
    'name': "behaviour",
    'verb': "Complete",
    'pastVerb': "Completed",
    'displayName': "behaviour change action",
    //'icon': CustomIcons.icon_behaviour_01,
    'type': getInvolved,
  },
  CampaignActionType.Contact: {
    'name': "contact",
    'verb': "Complete",
    'pastVerb': "Completed",
    'displayName': "contact change action",
    //'icon': CustomIcons.icon_contact_01,
    'type': advocate,
  },
  CampaignActionType.Protest: {
    'name': "protest",
    'verb': "Take part in",
    'pastVerb': "Took part in",
    'displayName': "protest",
    //'icon': CustomIcons.icon_protest_01,
    'type': getInvolved,
  },
  CampaignActionType.Connect: {
    'name': "connect",
    'verb': "Connect",
    'pastVerb': "Connted",
    'displayName': "times",
    //'icon': FontAwesomeIcons.link,
    //'icon': CustomIcons.icon_connect_01,
    'type': getInvolved,
  },
  CampaignActionType.Learn: {
    'name': "learn",
    'verb': "Complete",
    'pastVerb': "Completed",
    'displayName': "learning action",
    //'icon': CustomIcons.icon_learning_01,
    'type': learn,
  },
  CampaignActionType.Quiz: {
    'name': "quiz",
    'verb': "Complete",
    'pastVerb': "Completed",
    'displayName': "quiz",
    //'icon': CustomIcons.icon_quiz_01,
    'type': learn,
  },
  CampaignActionType.Other: defaultCampaignActionTypeData
};

List<Map> timeBrackets = [
  {"text": "1-5 mins", "minTime": 0, "maxTime": 5},
  {"text": "5-15 mins", "minTime": 5, "maxTime": 15},
  {"text": "15-30 mins", "minTime": 15, "maxTime": 30},
  {"text": "30-60 mins", "minTime": 30, "maxTime": 60},
  {"text": "Few hours", "minTime": 60, "maxTime": 240},
  {"text": "Long term", "minTime": 240, "maxTime": double.infinity},
];

CampaignActionType campaignActionTypeFromString(String? s) {
  CampaignActionType t = CampaignActionType.Other;
  campaignActionTypeData.forEach((key, value) {
    if (value['name'] == s) {
      t = key;
    }
  });
  return t;
}

Tuple3<String?, String?, String?> generateCampaingActionDesc(
    CampaignActionType? t) {
  print("Getting campaing aciton desc");
  if (campaignActionTypeData.containsKey(t)) {
    print("Found key");
    print(campaignActionTypeData[t]['name']);
    print("Looking for the thing");
    return Tuple3(
        campaignActionTypeData[t]['verb'],
        campaignActionTypeData[t]['pastVerb'],
        campaignActionTypeData[t]['displayName']);
  }
  return Tuple3("Complete", "Completed", "special action");
}

class ListCauseAction {
  int _id;
  int get id => _id;
  
  String _title;
  String get title => _title;

  /// The type of the action
  CampaignActionType _type;
  /// Returns the type if its know otherwise return Other
  CampaignActionType get type => campaignActionTypeData.containsKey(_type) ? _type : CampaignActionType.Other;
  /// The super type is a bigger category than the type - This is used for the
  /// styling.
  ActionType get superType => campaignActionTypeData[type]['type'];
  Color get primaryColor => superType.primaryColor;
  Color get secondaryColor => superType.secondaryColor;
  IconData get icon => superType.icon;

  /// The causes that this action is part of
  List<ListCause> _causes;
  // Although at the api level an action can be in many causes, for now we are
  // only showing a single cause in the UI.
  ListCause? get cause => _causes.length > 0 ? _causes[0] : null;
  
  double _time;
  double get time => _time;
  String get timeText => timeBrackets.firstWhere((b) => b['maxTime'] > time)['text'];

  DateTime _createdAt;
  DateTime? _releasedAt;
  /// Return when this action was released
  DateTime get releaseTime => _releasedAt == null ? _createdAt : _releasedAt!;
  bool get isNew => DateTime.now().difference(releaseTime).compareTo(Duration(days: 2)) < 0;

  /// Whether the user has completed this action
  bool _completed;
  get isCompleted => _completed;
  
  /// Whether the user has completed this action
  bool _starred;
  get isStarred => _starred;

  ListCauseAction({
    required int id,
    required String title,
    required CampaignActionType type,
    required List<ListCause> causes,
    required DateTime createdAt,
    required bool completed,
    required bool starred,
    required double time,

    DateTime? releasedAt,
  }) :
    _id = id,
    _title = title,
    _type = type,
    _causes = causes,
    _time = time,
    _createdAt = createdAt,
    _releasedAt = releasedAt,
    _completed = completed,
    _starred = starred;
  
  ListCauseAction.fromJson(Map<String, dynamic> json) :
      _id = json['id'],
      _title = json['title'],
      _type = campaignActionTypeFromString(json['type']),
      _causes = json['causes'].map((causeJson) => ListCause.fromJson(causeJson)).toList().cast<ListCause>(),
      _time = json['time'].toDouble(),
      _createdAt = DateTime.parse(json['created_at']),
      _releasedAt = json['release_date'] == null ? null : DateTime.parse(json['release_date']),
      _completed = json['completed'],
      _starred = json['starred'];

    Future<CampaignAction> getAction() async {
      CausesService _causesService = locator<CausesService>();
      return _causesService.getAction(id);
    }
}

class CampaignAction extends ListCauseAction {
  String? whatDescription;
  String? whyDescription;
  String? link;

  CampaignAction({
    required int id,
    required String title,
    required CampaignActionType type,
    required List<ListCause> causes,
    required DateTime createdAt,
    required bool completed,
    required bool starred,
    required double time,
    DateTime? releasedAt,

    required this.whatDescription,
    required this.whyDescription,
    required this.link,
  }) : super(id: id, title: title, type: type, causes: causes, createdAt: createdAt, completed: completed, starred: starred, releasedAt: releasedAt, time: time);

  CampaignAction.fromJson(Map<String, dynamic> json) :
    whatDescription = json['what_description'],
    whyDescription = json['why_description'],
    link = json['link'],
    super.fromJson(json);

  String? getWhatDescription() {
    return whatDescription;
  }

  String? getWhyDescription() {
    return whyDescription;
  }

  String? getLink() {
    return link;
  }
}

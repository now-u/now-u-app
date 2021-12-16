// Custom Icons
import 'package:app/assets/icons/customIcons.dart';
import 'package:app/locator.dart';
import 'package:app/models/Cause.dart';
import 'package:app/models/Explorable.dart';
import 'package:app/services/causes_service.dart';
import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';

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

const List<String> rejectionReasons = [
  "It requires too much effort",
  "It takes too long",
  "It does not seem useful/impactful",
  "I have completed too many of these",
  "This is not something I like doing",
  "Other",
];

const green0 = Color.fromRGBO(89, 152, 26, 1);
const green1 = Color.fromRGBO(230, 240, 221, 1);
const green2 = Color.fromRGBO(177, 199, 155, 1);

const orange0 = Color.fromRGBO(255, 136, 0, 1);
const orange1 = Color.fromRGBO(255, 237, 217, 1);
const orange2 = Color.fromRGBO(231, 190, 162, 1);

const yellow0 = Color.fromRGBO(243, 183, 0, 1);
const yellow1 = Color.fromRGBO(253, 244, 217, 1);
const yellow2 = Color.fromRGBO(243, 183, 0, 1);

const blue0 = Color.fromRGBO(38, 151, 211, 1);
const blue1 = Color.fromRGBO(190, 224, 242, 1);
const blue2 = Color.fromRGBO(99, 180, 223, 1);

class ActionType {
  final String name;
  final IconData icon;
  final Color primaryColor;
  final Color secondaryColor;
  final Color tertiaryColor;

  const ActionType({
    required this.name,
    required this.icon,
    required this.primaryColor,
    required this.secondaryColor,
    required this.tertiaryColor,
  });
}

const ActionType getInvolved = ActionType(
  name: "Get involved",
  icon: CustomIcons.ic_getinvolved,
  primaryColor: orange0,
  secondaryColor: orange1,
  tertiaryColor: orange2,
);
const ActionType learn = ActionType(
  name: "Learn",
  icon: CustomIcons.ic_learning,
  primaryColor: blue0,
  secondaryColor: blue1,
  tertiaryColor: blue2,
);
const ActionType advocate = ActionType(
  name: "Advocate",
  icon: CustomIcons.ic_raiseawareness,
  primaryColor: orange0,
  secondaryColor: orange1,
  tertiaryColor: orange2,
);
const ActionType raiseMoney = ActionType(
  name: "Raise money",
  icon: CustomIcons.ic_raisemoney,
  primaryColor: yellow0,
  secondaryColor: yellow1,
  tertiaryColor: yellow2,
);
const List<ActionType> actionTypes = [getInvolved, learn, advocate, raiseMoney];

const Map defaultCampaignActionTypeData = {
  'name': "other",
  'verb': "Complete",
  'pastVerb': "Completed",
  'displayName': "special action",
  //'icon': FontAwesomeIcons.check,
  //'Type': CustomIcons.heartHand,
  'type': getInvolved,
};

const Map campaignActionTypeData = {
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
    'displayName': "petition",
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
    'pastVerb': "Connected",
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

const List<Map> timeBrackets = [
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

Tuple3<String?, String?, String?> generateCampaignActionDesc(
    CampaignActionType? t) {
  if (campaignActionTypeData.containsKey(t)) {
    return Tuple3(
        campaignActionTypeData[t]['verb'],
        campaignActionTypeData[t]['pastVerb'],
        campaignActionTypeData[t]['displayName']);
  }
  return const Tuple3("Complete", "Completed", "special action");
}

class ListCauseAction extends Explorable {
  final int id;

  final String title;

  /// The type of the action
  final CampaignActionType type;

  /// The super type is a bigger category than the type - This is used for the
  /// styling.
  ActionType get superType => campaignActionTypeData[type]['type'];

  Color get primaryColor => superType.primaryColor;

  Color get secondaryColor => superType.secondaryColor;

  Color get tertiaryColor => superType.tertiaryColor;

  IconData get icon => superType.icon;

  /// The cause that this action is part of
  // Although at the api level an action can be in many causes, for now we are
  // only showing a single cause in the UI.
  final ListCause cause;

  final double time;

  String get timeText =>
      timeBrackets.firstWhere((b) => b['maxTime'] > time)['text'];

  /// When this action was released
  final DateTime releaseTime;

  bool get isNew =>
      DateTime.now()
          .difference(releaseTime)
          .compareTo(const Duration(days: 2)) <
      0;

  /// Whether the user has completed this action
  final bool completed;

  /// Whether the user has completed this action
  final bool starred;

  ListCauseAction({
    required this.id,
    required this.title,
    required this.type,
    required List<ListCause> causes,
    required DateTime createdAt,
    required this.completed,
    required this.starred,
    required this.time,
    DateTime? releasedAt,
  })  : cause = causes[0],
        releaseTime = releasedAt ?? createdAt;

  ListCauseAction.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        type = campaignActionTypeFromString(json['type']),
        cause = ListCause.fromJson(json['causes'][0]),
        time = json['time'].toDouble(),
        releaseTime = DateTime.parse(json['release_date'] ?? json['created_at']),
        completed = json['completed'],
        starred = json['starred'];

  Future<CampaignAction> getAction() async {
    CausesService _causesService = locator<CausesService>();
    return _causesService.getAction(id);
  }
}

class CampaignAction extends ListCauseAction {
  final String? whatDescription;
  final String? whyDescription;
  final String? link;

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
    this.whatDescription,
    this.whyDescription,
    this.link,
  }) : super(
          id: id,
          title: title,
          type: type,
          causes: causes,
          createdAt: createdAt,
          completed: completed,
          starred: starred,
          releasedAt: releasedAt,
          time: time,
        );

  CampaignAction.fromJson(Map<String, dynamic> json)
      : whatDescription = json['what_description'],
        whyDescription = json['why_description'],
        link = json['link'],
        super.fromJson(json);
}

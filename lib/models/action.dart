// Custom Icons
import 'package:causeApiClient/causeApiClient.dart' as Api;
import 'package:built_collection/built_collection.dart';
import 'package:nowu/assets/icons/customIcons.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:nowu/models/user.dart';
import 'package:nowu/models/cause.dart';
import 'package:nowu/models/exploreable.dart';
import 'package:nowu/models/time.dart';

export 'package:causeApiClient/causeApiClient.dart'
    show ListAction, Action, ActionTypeEnum;

// TODO Move to colors and rename
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
  final List<Api.ActionTypeEnum> subTypes;

  const ActionType({
    required this.name,
    required this.icon,
    required this.primaryColor,
    required this.secondaryColor,
    required this.tertiaryColor,
    required this.subTypes,
  });
}

const ActionType getInvolved = ActionType(
  name: 'Get involved',
  icon: CustomIcons.ic_getinvolved,
  primaryColor: orange0,
  secondaryColor: orange1,
  tertiaryColor: orange2,
  subTypes: [
    Api.ActionTypeEnum.OTHER,
    Api.ActionTypeEnum.BEHAVIOR,
    Api.ActionTypeEnum.PURCHASE,
    Api.ActionTypeEnum.VOLUNTEER,
    Api.ActionTypeEnum.PROTEST,
    Api.ActionTypeEnum.CONNECT,
  ],
);

const ActionType learn = ActionType(
  name: 'Learn',
  icon: CustomIcons.ic_learning,
  primaryColor: blue0,
  secondaryColor: blue1,
  tertiaryColor: blue2,
  subTypes: [
    Api.ActionTypeEnum.LEARN,
    Api.ActionTypeEnum.QUIZ,
  ],
);
const ActionType advocate = ActionType(
  name: 'Advocate',
  icon: CustomIcons.ic_raiseawareness,
  primaryColor: orange0,
  secondaryColor: orange1,
  tertiaryColor: orange2,
  subTypes: [
    Api.ActionTypeEnum.RAISE_AWARENESS,
    Api.ActionTypeEnum.SIGN,
    Api.ActionTypeEnum.CONTACT,
  ],
);
const ActionType raiseMoney = ActionType(
  name: 'Raise money',
  icon: CustomIcons.ic_raisemoney,
  primaryColor: yellow0,
  secondaryColor: yellow1,
  tertiaryColor: yellow2,
  subTypes: [
    Api.ActionTypeEnum.DONATE,
    Api.ActionTypeEnum.FUNDRAISE,
  ],
);
const List<ActionType> actionTypes = [getInvolved, learn, advocate, raiseMoney];

ActionType getActionTypeFromSubtype(Api.ActionTypeEnum type) {
  return actionTypes.firstWhere(
    (actionType) => actionType.subTypes.contains(type),
    orElse: () => getInvolved,
  );
}

class ListAction implements Explorable {
  int id;
  String title;
  // TODO create type
  Cause cause;
  ActionType type;
  DateTime releaseAt;
  DateTime createdAt;
  int time;
  bool isCompleted;

  DateTime get releaseTime => releaseAt;

  bool get isNew => isNewDate(releaseTime);
  String get timeText => getTimeText(time);

  bool isCompletedByUser(Api.CausesUser user) {
    return user.completedActionIds.contains(this.id);
  }

  ListAction({
    required this.id,
    required this.title,
    required this.releaseAt,
    required this.createdAt,
    required this.time,
    required this.cause,
    required this.type,
    required this.isCompleted,
  });

  ListAction.fromApiData({
    required this.id,
    required this.title,
    required this.releaseAt,
    required this.createdAt,
    required this.time,
    required BuiltList<Api.Cause> causes,
    required Api.ActionTypeEnum actionType,
    required CausesUser? userInfo,
  })  : cause = Cause.fromApiModel(causes[0], userInfo),
        isCompleted = userInfo?.completedActionIds.contains(id) ?? false,
        type = getActionTypeFromSubtype(actionType);

  factory ListAction.fromApiModel(
    Api.ListAction apiModel,
    CausesUser? userInfo,
  ) {
    return ListAction.fromApiData(
      id: apiModel.id,
      title: apiModel.title,
      releaseAt: apiModel.releaseAt,
      createdAt: apiModel.createdAt,
      time: apiModel.time,
      causes: apiModel.causes,
      actionType: apiModel.actionType,
      userInfo: userInfo,
    );
  }
}

class Action extends ListAction {
  String whatDescription;
  String whyDescription;
  Uri link;

  Action({
    required this.whatDescription,
    required this.whyDescription,
    required this.link,
    required super.id,
    required super.title,
    required super.releaseAt,
    required super.createdAt,
    required super.time,
    required super.cause,
    required super.type,
    required super.isCompleted,
  });

  Action.fromApiModel(
    Api.Action apiModel,
    CausesUser? userInfo,
  )   : whatDescription = apiModel.whatDescription,
        whyDescription = apiModel.whyDescription,
        link = Uri.parse(apiModel.link),
        super.fromApiData(
          id: apiModel.id,
          title: apiModel.title,
          releaseAt: apiModel.releaseAt,
          createdAt: apiModel.createdAt,
          time: apiModel.time,
          causes: apiModel.causes,
          actionType: apiModel.actionType,
          userInfo: userInfo,
        );
}

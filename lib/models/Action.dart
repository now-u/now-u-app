// Custom Icons
import 'package:causeApiClient/causeApiClient.dart';
import 'package:nowu/assets/icons/customIcons.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:nowu/models/time.dart';

export 'package:causeApiClient/causeApiClient.dart' show ListAction, Action, ActionTypeEnum;

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
  final List<ActionTypeEnum> subTypes;

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
	name: "Get involved",
	icon: CustomIcons.ic_getinvolved,
	primaryColor: orange0,
	secondaryColor: orange1,
	tertiaryColor: orange2,
	subTypes: [
		ActionTypeEnum.OTHER,
		ActionTypeEnum.BEHAVIOR,
		ActionTypeEnum.PURCHASE,
		ActionTypeEnum.VOLUNTEER,
		ActionTypeEnum.PROTEST,
		ActionTypeEnum.CONNECT,
	],
);

const ActionType learn = ActionType(
	name: "Learn",
	icon: CustomIcons.ic_learning,
	primaryColor: blue0,
	secondaryColor: blue1,
	tertiaryColor: blue2,
	subTypes: [
		ActionTypeEnum.LEARN,
		ActionTypeEnum.QUIZ,
	]
);
const ActionType advocate = ActionType(
	name: "Advocate",
	icon: CustomIcons.ic_raiseawareness,
	primaryColor: orange0,
	secondaryColor: orange1,
	tertiaryColor: orange2,
	subTypes: [
	  	ActionTypeEnum.RAISE_AWARENESS,
	  	ActionTypeEnum.SIGN,
	  	ActionTypeEnum.CONTACT,
	]
);
const ActionType raiseMoney = ActionType(
	name: "Raise money",
	icon: CustomIcons.ic_raisemoney,
	primaryColor: yellow0,
	secondaryColor: yellow1,
	tertiaryColor: yellow2,
	subTypes: [
		ActionTypeEnum.DONATE,
		ActionTypeEnum.FUNDRAISE,
	]
);
const List<ActionType> actionTypes = [getInvolved, learn, advocate, raiseMoney];

ActionType getActionTypeFromSubtype(ActionTypeEnum type) {
	return actionTypes.firstWhere((actionType) => actionType.subTypes.contains(type), orElse: () => getInvolved);
}

// TODO Move out of action
extension ListActionExtension on ListAction {
	Cause get cause => causes[0];
	ActionType get type => getActionTypeFromSubtype(actionType);

	// TODO This is not quite right, it could be enabled - update API to provide releasedTime
	// which is set based on when the action was enabled/released
	DateTime get releaseTime => releaseAt ?? createdAt;
	
	bool get isNew => isNewDate(releaseTime);
	String get timeText => getTimeText(time);

	bool isCompletedByUser(CausesUser user) {
		return user.completedActionIds.contains(this.id);
	}
}

extension ActionExtension on Action {
	Cause get cause => causes[0];
	ActionType get type => getActionTypeFromSubtype(actionType);

	// TODO This is not quite right, it could be enabled - update API to provide releasedTime
	// which is set based on when the action was enabled/released
	DateTime get releaseTime => releaseAt ?? createdAt;
	
	bool get isNew => isNewDate(releaseTime);
	String get timeText => getTimeText(time);
}

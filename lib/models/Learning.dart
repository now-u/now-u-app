import 'package:causeApiClient/causeApiClient.dart' as Api;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nowu/assets/icons/customIcons.dart';
import 'package:nowu/models/time.dart';

export 'package:causeApiClient/causeApiClient.dart'
    show LearningResource, LearningResourceTypeEnum;

// extension on LearningTopic {
//   bool containsNew() {
//     var r = resources.firstWhereOrNull((LearningResource r) => r.isNew());
//     return r != null;
//   }
// }

class LearningResourceType {
  final String name;
  final IconData icon;

  LearningResourceType({
    required this.name,
    required this.icon,
  });
}

LearningResourceType getResourceTypeFromEnum(Api.LearningResourceTypeEnum type) {
  switch (type) {
    case Api.LearningResourceTypeEnum.VIDEO:
      return LearningResourceType(name: 'Video', icon: CustomIcons.ic_video);
    case Api.LearningResourceTypeEnum.READING:
      return LearningResourceType(
        name: 'Reading',
        icon: CustomIcons.ic_learning,
      );
    case Api.LearningResourceTypeEnum.INFOGRAPHIC:
      return LearningResourceType(
        name: 'Infographic',
        icon: CustomIcons.ic_report,
      );
    // TODO Are these real?
    // case LearningResourceTypeEnum.REPORT:
    // 	return LearningResourceType(name: "report", icon: CustomIcons.ic_report);
    // case LearningResourceTypeEnum.STORY:
    // 	return LearningResourceType(name: "story", icon: CustomIcons.ic_story);
  }
  // TODO Publish error metric
  // TODO Update icon to be custom iconLearning.dart
  return LearningResourceType(
    name: 'Other',
    icon: FontAwesomeIcons.chalkboardUser,
  );
}

class LearningResource {
	int id;
	String title;
	Api.Cause cause;
	LearningResourceType type;
	int time;
	DateTime createdAt;

	LearningResource.fromApiModel(Api.LearningResource apiModel):
		id = apiModel.id,
		title = apiModel.title,
		cause = apiModel.causes[0],
		type = getResourceTypeFromEnum(apiModel.learningResourceType),
		time = apiModel.time,
		createdAt = apiModel.createdAt;

  String get timeText => timeBrackets.firstWhere((b) => b.maxTime > time).text;

  IconData get icon => type.icon;

  bool isNew() {
    return DateTime.now()
            .difference(createdAt)
            .compareTo(const Duration(days: 2)) <
        0;
  }

  bool isCompletedByUser(Api.CausesUser user) {
    print(
      'Checking is completed: ${user.completedLearningResourceIds.contains(this.id)}',
    );
    return user.completedLearningResourceIds.contains(this.id);
  }
}

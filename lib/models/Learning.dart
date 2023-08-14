import 'package:causeApiClient/causeApiClient.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nowu/assets/icons/customIcons.dart';
import 'package:nowu/models/time.dart';

export 'package:causeApiClient/causeApiClient.dart'
    show LearningResource, LearningResourceTypeEnum;

/// TODO Remove -> The LearningCentre page will be removed in v2
// class LearningCentre {
//   // Id of campaign
//   int? campaign;
//   List<LearningTopic>? learningTopics;
//
//   List<LearningTopic>? getLearningTopics() {
//     return learningTopics;
//   }
//
//   LearningCentre.fromJson(List json) {
//     learningTopics = json
//         .map((e) => LearningTopic.fromJson(e))
//         .toList()
//         .cast<LearningTopic>();
//   }
//
//   bool containsNew() {
//     var c = learningTopics!.firstWhereOrNull((r) => r.containsNew());
//     return c != null;
//   }
// }

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

LearningResourceType getResourceTypeFromEnum(LearningResourceTypeEnum type) {
  switch (type) {
    case LearningResourceTypeEnum.VIDEO:
      return LearningResourceType(name: 'Video', icon: CustomIcons.ic_video);
    case LearningResourceTypeEnum.READING:
      return LearningResourceType(
        name: 'Reading',
        icon: CustomIcons.ic_learning,
      );
    case LearningResourceTypeEnum.INFOGRAPHIC:
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
    icon: FontAwesomeIcons.chalkboardTeacher,
  );
}

// TODO Add documentation to open api spec and remove this
/// A learning resources is attached to a [LearningTopic] and offers more information on the topic.
///
/// Practially a learning resource is just a link with some extra meta data
/// like the time expected to completed the resource. We also store if the user
/// has completed the resource. // TODO Do this
extension LearningResourceExtension on LearningResource {
  String get timeText =>
      timeBrackets.firstWhere((b) => b['maxTime'] > time)['text'];

  LearningResourceType get type =>
      getResourceTypeFromEnum(learningResourceType);
  IconData get icon => type.icon;

  Cause get cause => causes[0];

  bool isCompletedByUser(CausesUser user) {
    print(
      'Checking is completed: ${user.completedLearningResourceIds.contains(this.id)}',
    );
    return user.completedLearningResourceIds.contains(this.id);
  }

  bool isNew() {
    return DateTime.now()
            .difference(createdAt)
            .compareTo(const Duration(days: 2)) <
        0;
  }
}

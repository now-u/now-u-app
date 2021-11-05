import 'package:collection/collection.dart' show IterableExtension;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:app/assets/icons/customIcons.dart';

import 'package:app/models/Action.dart';

class LearningCentre {
  // Id of campaign
  int? campaign;
  List<LearningTopic>? learningTopics;

  List<LearningTopic>? getLearningTopics() {
    return learningTopics;
  }

  LearningCentre.fromJson(List json) {
    print("Getting learning centre from json");
    //campaign = json['campaign'];
    learningTopics = json
        .map((e) => LearningTopic.fromJson(e))
        .toList()
        .cast<LearningTopic>();
  }

  bool containsNew() {
    var c = learningTopics!.firstWhereOrNull((r) => r.containsNew());
    return c != null;
  }
}

class LearningTopic {
  int? id;
  String? title;
  String? imageLink;
  String? ourAnswer;
  List<LearningResource>? resources;

  LearningTopic.fromJson(Map json) {
    print("Getting learning topic from json");
    id = json['id'];
    title = json['title'];
    imageLink = json['image_link'];
    ourAnswer = json['our_answer'];
    print("Got the things up till resources");
    resources = (json['learning_resources'])
        .map((e) => LearningResource.fromJson(e))
        .toList()
        .cast<LearningResource>();
  }

  int? getId() {
    return id;
  }

  String? getTitle() {
    return title;
  }

  String? getImageLink() {
    return imageLink;
  }

  String? getOurAnswer() {
    return ourAnswer;
  }

  List<LearningResource>? getResources() {
    return resources;
  }

  bool containsNew() {
    print("Checking contains");
    print(resources);
    var r = resources!.firstWhereOrNull((LearningResource r) => r.isNew());
    print("Checked contains");
    return r != null;
  }
}

enum LearningResourceType {
  Video,
  Reading,
  Infographic,
  Other,
}

class LearningResource {
  int? id;
  String? title;
  double? time;
  String? link;
  String? type;
  DateTime? createdAt;
  String? source;

  LearningResource.fromJson(Map json) {
    id = json['id'];
    title = json['title'];
    time = json['time'];
    link = json['link'];
    type = json['type'];
    createdAt = DateTime.parse(json['created_at']);
    source = json['source'];
  }

  int? getId() {
    return id;
  }

  String? getTitle() {
    return title;
  }

  String? getLink() {
    return link;
  }

  String? getType() {
    return type;
  }

  IconData getTypeIcon() {
    switch (type) {
      case "reading":
        {
          return CustomIcons.ic_learning;
        }
      case "video":
        {
          return CustomIcons.ic_video;
        }
      case "infographic":
        {
          return CustomIcons.ic_report;
        }
      case "report":
        {
          return CustomIcons.ic_report;
        }
      case "story":
        {
          return CustomIcons.ic_story;
        }
      case "other":
        {
          return FontAwesomeIcons.chalkboardTeacher;
        }
    }
    return FontAwesomeIcons.chalkboardTeacher;
  }

  double? getTime() {
    return time;
  }

  String? getTimeText() {
    return timeBrackets.firstWhere((b) => b['maxTime'] > time)['text'];
  }

  String? getSource() {
    return source;
  }

  bool isNew() {
    print("Checking is new");
    print(createdAt);
    return DateTime.now().difference(createdAt!).compareTo(Duration(days: 2)) <
        0;
  }
}

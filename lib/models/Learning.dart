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
    learningTopics = json
        .map((e) => LearningTopic.fromJson(e))
        .toList()
        .cast<LearningTopic>();
  }

  bool containsNew() {
    var c =
        learningTopics!.firstWhereOrNull((r) => r.containsNew());
    return c != null;
  }
}

class LearningTopic {
  int _id;
  int get id => _id;

  String _title;
  String get title => _title;

  String _imageLink;
  String get imageLink => _imageLink;

  String _ourAnswer;
  String get ourAnswer => _ourAnswer;

  List<LearningResource> _resources;
  List<LearningResource> get resources => _resources;

  LearningTopic.fromJson(Map json) :
    _id = json['id'],
    _title = json['title'],
    _imageLink = json['image_link'],
    _ourAnswer = json['our_answer'],
    _resources = (json['learning_resources'])
        .map((e) => LearningResource.fromJson(e))
        .toList()
        .cast<LearningResource>();

  bool containsNew() {
    var r = resources.firstWhereOrNull((LearningResource r) => r.isNew());
    return r != null;
  }
}

class LearningResourceType {
  String name;
  IconData icon;

  LearningResourceType({
    required this.name,
    required this.icon,
  });
}

LearningResourceType otherType = LearningResourceType(name: "other", icon: FontAwesomeIcons.chalkboardTeacher);
List<LearningResourceType> learningResourceTypes = [
  LearningResourceType(name: "video", icon: CustomIcons.ic_video),
  LearningResourceType(name: "reading", icon: CustomIcons.ic_learning),
  LearningResourceType(name: "infographic", icon: CustomIcons.ic_report),
  LearningResourceType(name: "report", icon: CustomIcons.ic_report),
  LearningResourceType(name: "story", icon: CustomIcons.ic_story),
  otherType,
];

LearningResourceType getResourceTypeFromString(String typeName) {
  return learningResourceTypes.firstWhere((LearningResourceType type) => type.name == typeName, orElse: () => otherType);
}

class LearningResource {
  int _id;
  int get id => _id;

  String _title;
  String get title => _title;

  double _time;
  double get time => _time;
  String get timeText => timeBrackets.firstWhere((b) => b['maxTime'] > _time)['text'];

  String _link;
  String get link => _link;

  LearningResourceType _type;
  LearningResourceType get type => _type;
  IconData get icon => _type.icon;

  DateTime _createdAt;
  DateTime get createdAt => _createdAt;

  String? _source;
  String? get source => _source;

  LearningResource.fromJson(Map json) :
    _id = json['id'],
    _title = json['title'],
    _time = json['time'],
    _link = json['link'],
    _type = getResourceTypeFromString(json['type']),
    _createdAt = DateTime.parse(json['created_at']),
    _source = json['source'];

  bool isNew() {
    return DateTime.now().difference(_createdAt).compareTo(Duration(days: 2)) < 0;
  }
}

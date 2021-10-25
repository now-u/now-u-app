import 'package:collection/collection.dart' show IterableExtension;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:app/assets/icons/customIcons.dart';

import 'package:app/models/Action.dart';

/// TODO Remove -> The LearningCentre page will be removed in v2 
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

/// A learning topic is a collection of [LearningResource].
///
/// A learning topic is usually a question. now-u then offers an answer to this
/// question (_ourAnswer). We then provide a collection of [LearningResource]
/// which the user can use to find out more information about this topic.
class LearningTopic {
  /// Api id
  int _id;
  int get id => _id;

  /// The title of a the topic, usually a question 
  String _title;
  String get title => _title;

  /// Link for header image for this topic 
  String _imageLink;
  String get imageLink => _imageLink;

  /// Our answer to the topic question
  String _ourAnswer;
  String get ourAnswer => _ourAnswer;

  /// The additional resources associated with this topic
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

  /// Returns true if the topic has some new resources in it
  // TODO move this logic to api (if still required)
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

/// A learning resources is attached to a [LearningTopic] and offers more information on the topic.
///
/// Practially a learning resource is just a link with some extra meta data
/// like the time expected to completed the resource. We also store if the user
/// has completed the resource. // TODO Do this
class LearningResource {
  /// Api id 
  int _id;
  int get id => _id;

  /// Title of the resource
  String _title;
  String get title => _title;

  /// Time expected to complete the resource (in mins) 
  double _time;
  double get time => _time;
  String get timeText => timeBrackets.firstWhere((b) => b['maxTime'] > _time)['text'];

  /// Link to the resource (This could be internal or external see [NavigationService])
  String _link;
  String get link => _link;

  /// The type of the resource (eg article/video)
  LearningResourceType _type;
  LearningResourceType get type => _type;
  IconData get icon => _type.icon;

  DateTime _createdAt;
  DateTime get createdAt => _createdAt;

  /// String name of the source of the article eg BBC news
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

  /// Whether the resource has been created in the last 2 days 
  // TODO move to api
  bool isNew() {
    return DateTime.now().difference(_createdAt).compareTo(Duration(days: 2)) < 0;
  }
}

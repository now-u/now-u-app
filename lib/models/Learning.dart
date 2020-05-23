import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LearningCentre {
  // Id of campaign
  int campaign;
  List<LearningTopic> learningTopics;

  List<LearningTopic> getLearningTopics() {
    return learningTopics;
  }
  LearningCentre.fromJson(Map json) {
    campaign = json['campaign'];
    learningTopics = json['learning_topics'].map((e) => LearningTopic.fromJson(e)).toList().cast<LearningTopic>();
  }
}

class LearningTopic {
  int id;
  String title;
  String imageLink;
  String ourAnswer;
  List<LearningResource> resources;
  
  LearningTopic.fromJson(Map json) {
    id = json['id'];
    title = json['title'];
    imageLink = json['image_link'];
    ourAnswer = json['our_answer'];
    resources = (json['resources']).map((e) => LearningResource.fromJson(e)).toList().cast<LearningResource>();
  }

  String getTitle() {
    return title;
  }
  String getImageLink() {
    return imageLink;
  }
  String getOurAnswer() {
    return ourAnswer;
  }
  String getResources() {
    return ourAnswer;
  }
}

class LearningResource {
  int id;
  String title;
  double time;
  String link;
  String type;
  
  LearningResource.fromJson(Map json) {
    id = json['id'];
    title = json['title'];
    time = json['time'];
    link = json['link'];
    type = json['type'];
  }

  String getTitle() {
    return title;
  }
  String getLink() {
    return link;
  }
  String getType() {
    return type;
  }
  IconData getTypeIcon() {
    switch (type) {
      case "read": {
        return Icons.book;
      }
      case "video": {
        return Icons.book;
      }
      case "personal_story": {
        return FontAwesomeIcons.heart;
      }
    }
    return FontAwesomeIcons.leanpub;
  }
  double getTime() {
    return time;
  }
  String getTimeText() {
    return time.toString();
  }
}

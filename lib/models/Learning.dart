class LearningCentre {
  // Id of campaign
  int campaign;
  List<LearningTopic> learningTopic;

  List<LearningTopic> getLearningTopics() {
    return learningTopic;
  }
  LearningCentre.fromJson(Map json) {
    campaign = json['campaign'];
    learningTopic = json['learning_topic'].map((e) => LearningTopic.fromJson(e)).toList().cast<LearningTopic>();
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
    ourAnswer = json['our_link'];
    resources = (json['resources']).map((e) => LearningResource.fromJson(e)).toList().cast<LearningResource>();
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
  double getTime() {
    return time;
  }
}

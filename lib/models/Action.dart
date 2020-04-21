import 'package:flutter/foundation.dart';

class CampaignAction {
  int id;
  String title;
  String description;
  String link;

  CampaignAction({
    @required int id, 
    @required String title, 
    @required String description, 
    @required String link
  }) {
    this.id = id; 
    this.title = title;
    this.description = description;
    this.link = link;
  }

  int getId() {
    return id; 
  }
  String getTitle() {
    return title; 
  }
  String getDescription() {
    return description; 
  }
  String getLink() {
    return link; 
  }
}

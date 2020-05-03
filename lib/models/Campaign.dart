import 'package:flutter/foundation.dart';
import 'package:app/models/Action.dart';
import 'dart:convert';

class Campaign {
  int id;
  String title;
  String description;
  int numberOfCampaingers;
  String headerImage;
  bool isCampaignSelected;
  List<CampaignAction> actions;
  String videoLink;
  
  Campaign({
    @required int id,
    @required String title,
    @required String description,
    @required int numberOfCampaigners,
    @required String headerImage,
    @required List<CampaignAction> actions,
    this.videoLink,
  }) {
    this.id = id; 
    this.title = title;
    this.description = description;
    this.numberOfCampaingers = numberOfCampaigners;
    this.headerImage = headerImage;
    this.actions = actions;
    this.videoLink = videoLink;
  }

  Campaign copyWith({
    int id,
    String title,
    String description,
    int numberOfCampaingers,
    String headerImage,
    List<CampaignAction> actions,
    String videoLink,
  }) {
    return Campaign(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      numberOfCampaigners: numberOfCampaingers ?? this.numberOfCampaingers,
      headerImage: headerImage ?? this.headerImage,
      actions: actions ?? this.actions,
      videoLink: videoLink ?? this.videoLink,
    );
  }

  Campaign.fromJson(Map json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    numberOfCampaingers = json['number_of_campaigners'];
    headerImage = json['header_image'];
    // TODO this proabably wont work
    actions = (json['actions']).map((e) => CampaignAction.fromJson(e)).toList().cast<CampaignAction>();
    videoLink = json['video_link'];
  }

  Map toJson() => {
    'id': id,
    'title': title,
    'description': description,
    'number_of_campaigners': numberOfCampaingers,
    'header_image': headerImage,
    // TODO this proabably wont work
    'actions': actions,
    'video_link': videoLink,
  };

  int getId() {
    return id; 
  }
  String getTitle() {
    return title; 
  }
  String getDescription() {
    return description; 
  }
  int getNumberOfCampaigners() {
    return numberOfCampaingers; 
  }
  String getHeaderImage() {
    return headerImage;
  }
  String getVideoLink() {
    return videoLink;
  }
  bool isSelected(List<int> selectedCampaings) {
    return selectedCampaings.contains(id);
  }
  List<CampaignAction> getActions() {
    return actions; 
  }
}
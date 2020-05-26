import 'package:flutter/foundation.dart';

import 'package:app/models/Action.dart';
import 'package:app/models/Organisation.dart';
import 'package:app/models/SDG.dart';

import 'dart:convert';

class Campaign {
  int id;
  String title;
  String description;
  int numberOfCampaingers;
  String headerImage;
  bool isCampaignSelected;
  List<CampaignAction> actions;
  List<Organisation> generalPartners;
  List<Organisation> campaignPartners;
  String videoLink;
  List<SDG> sdgs;
  
  Campaign({
    @required int id,
    @required String title,
    @required String description,
    @required int numberOfCampaigners,
    @required String headerImage,
    @required List<CampaignAction> actions,
    @required List<SDG> sdgs,
    List<Organisation> generalPartners,
    List<Organisation> campaignPartners,
    this.videoLink,
  }) {
    this.id = id; 
    this.title = title;
    this.description = description;
    this.numberOfCampaingers = numberOfCampaigners;
    this.headerImage = headerImage;
    this.actions = actions;
    this.videoLink = videoLink;
    this.generalPartners = generalPartners ?? [];
    this.campaignPartners = campaignPartners ?? [];
    this.sdgs = sdgs ?? [];
  }

  Campaign copyWith({
    int id,
    String title,
    String description,
    int numberOfCampaingers,
    String headerImage,
    List<CampaignAction> actions,
    List<Organisation> generalPartners,
    List<Organisation> campaignPartners,
    String videoLink,
    List<SDG> sdgs,
  }) {
    return Campaign(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      numberOfCampaigners: numberOfCampaingers ?? this.numberOfCampaingers,
      headerImage: headerImage ?? this.headerImage,
      actions: actions ?? this.actions,
      generalPartners: generalPartners ?? this.generalPartners,
      campaignPartners: campaignPartners ?? this.campaignPartners,
      videoLink: videoLink ?? this.videoLink,
      sdgs: sdgs ?? this.sdgs,
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
    campaignPartners = json.containsKey('campaign_partners') ? (json['campaign_partners']).map((e) => Organisation.fromJson(e)).toList().cast<Organisation>() : [];
    generalPartners = json.containsKey('general_partners') ? (json['general_partners']).map((e) => Organisation.fromJson(e)).toList().cast<Organisation>() : [];
    videoLink = json['video_link'];
    sdgs = json['sdgs'].map((s) => getSDGfromNumber(s)).toList().cast<SDG>();
  }

  Map toJson() => {
    'id': id,
    'title': title,
    'description': description,
    'number_of_campaigners': numberOfCampaingers,
    'header_image': headerImage,
    // TODO this proabably wont work
    'actions': actions,
    'general_partners': generalPartners,
    'campaign_partners': campaignPartners,
    'video_link': videoLink,
    'sdgs': sdgs.map((s) => s.getNumber()),
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
  List<Organisation> getCampaignPartners() {
    return campaignPartners; 
  }
  List<Organisation> getGeneralPartners() {
    return generalPartners; 
  }
  List<SDG> getSDGs() {
    return sdgs;
  }
}

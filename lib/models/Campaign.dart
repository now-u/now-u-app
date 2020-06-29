import 'package:flutter/foundation.dart';

import 'package:app/models/Action.dart';
import 'package:app/models/Organisation.dart';
import 'package:app/models/SDG.dart';

import 'dart:convert';

class Campaign {
  int id;
  String title;
  String shortName;
  String description;
  int numberOfCampaingers;
  String headerImage;
  bool isCampaignSelected;
  List<CampaignAction> actions;
  List<Organisation> generalPartners;
  List<Organisation> campaignPartners;
  String videoLink;
  List<SDG> sdgs;
  List<String> keyAims;
  
  Campaign({
    @required int id,
    @required String title,
    @required String shortName,
    @required String description,
    @required int numberOfCampaigners,
    @required String headerImage,
    @required List<CampaignAction> actions,
    @required List<SDG> sdgs,
    List<Organisation> generalPartners,
    List<Organisation> campaignPartners,
    String videoLink,
    List<String> keyAims,
  }) {
    this.id = id; 
    this.title = title;
    this.shortName = shortName;
    this.description = description;
    this.numberOfCampaingers = numberOfCampaigners;
    this.headerImage = headerImage;
    this.actions = actions;
    this.videoLink = videoLink;
    this.generalPartners = generalPartners ?? [];
    this.campaignPartners = campaignPartners ?? [];
    this.sdgs = sdgs ?? [];
    this.keyAims = keyAims ?? [];
  }

  Campaign copyWith({
    int id,
    String title,
    String shortName,
    String description,
    int numberOfCampaingers,
    String headerImage,
    List<CampaignAction> actions,
    List<Organisation> generalPartners,
    List<Organisation> campaignPartners,
    String videoLink,
    List<SDG> sdgs,
    List<String> keyAims,
  }) {
    return Campaign(
      id: id ?? this.id,
      title: title ?? this.title,
      shortName: shortName ?? this.shortName,
      description: description ?? this.description,
      numberOfCampaigners: numberOfCampaingers ?? this.numberOfCampaingers,
      headerImage: headerImage ?? this.headerImage,
      actions: actions ?? this.actions,
      generalPartners: generalPartners ?? this.generalPartners,
      campaignPartners: campaignPartners ?? this.campaignPartners,
      videoLink: videoLink ?? this.videoLink,
      sdgs: sdgs ?? this.sdgs,
      keyAims: keyAims ?? this.keyAims,
    );
  }

  Campaign.fromJson(Map json) {
    print("Getting campaigns from json");
    print(json);
    id = json['id'];
    title = json['title'];
    shortName = json['short_name'];
    description = json['description_app'];
    numberOfCampaingers = json['number_of_campaigners'];
    headerImage = json['header_image'];
    // TODO this proabably wont work
    print("Getting action");
    actions = (json['actions']) == null ? [] : (json['actions']).map((e) => CampaignAction.fromJson(e)).toList().cast<CampaignAction>();
    print("GOT ACTIONS");
    print("Getting ORGANISATIONS");
    campaignPartners = 
        json["campaign_partners"] == null ? [] :
        (json['campaign_partners']).map((e) => Organisation.fromJson(e)).toList().cast<Organisation>();
    print("GOT ORGANISATIONS");
    print("GETTING PARTNERS");
    generalPartners = 
        json['general_partners'] == null ? [] :
        (json['general_partners']).map((e) => Organisation.fromJson(e)).toList().cast<Organisation>();
    print("GOT PARTNERS");
    videoLink = json['video_link'];
    //sdgs = [];
    print("Gettingsdgs");
    //sdgs = [];
    sdgs = 
      json['sdgs'] == null ? <SDG>[] :  
      json['sdgs'].map((s) => getSDGfromNumber(s['id'])).toList().cast<SDG>();
    print("Got whole camapign");

    keyAims = 
      json['key_aims'] == null ? <String>[] :
      json['key_aims'].map((a) => a['title']).toList().cast<String>();

    print("Got the campaign");
  }

  Map toJson() => {
    'id': id,
    'title': title,
    'short_name': shortName,
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
  String getShortName() {
    return shortName; 
  }
  String getDescription() {
    // TODO function to remove escape characters
    var descriptionWithoutNs = description.replaceAll('\\n', '\n\n');
    return descriptionWithoutNs; 
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
  List<String> getKeyAims(){
    return keyAims;
  }
}

import 'package:flutter/foundation.dart';

class Campaign {
  int id;
  String title;
  String description;
  int numberOfCampaingers;
  String headerImage;
  bool isCampaignSelected;
  
  Campaign({
    @required int id,
    @required String title,
    @required String description,
    @required int numberOfCampaigners,
    @required String headerImage,
  }) {
    this.id = id; 
    this.title = title;
    this.description = description;
    this.numberOfCampaingers = numberOfCampaigners;
    this.headerImage = headerImage;
  }

  Campaign copyWith({
    int id,
    String title,
    String description,
    int numberOfCampaingers,
    String headerImage,
  }) {
    return Campaign(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      numberOfCampaigners: numberOfCampaingers ?? this.numberOfCampaingers,
      headerImage: headerImage ?? this.headerImage,
    );
  }

  Campaign.fromJson(Map json) {
    print("Decoding json");
    print(json);
    id = json['id'];
    title = json['title'];
    description = json['description'];
    numberOfCampaingers = json['numberOfCampaingers'];
    headerImage = json['headerImage'];
    print("From json success");
  }

  Map toJson() => {
    'id': id,
    'title': title,
    'description': description,
    'numberOfCampaingers': numberOfCampaingers,
    'headerImage': headerImage,
    'isSelected': isCampaignSelected,
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
  bool isSelected(List<int> selectedCampaings) {
    return selectedCampaings.contains(id);
  }
}

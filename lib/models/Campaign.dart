import 'package:flutter/foundation.dart';

class Campaign {
  int _id;
  String _title;
  String _description;
  int _numberOfCampaingers;
  String _headerImage;
  bool _isSelected;
  
  Campaign({
    @required int id,
    @required String title,
    @required String description,
    @required int numberOfCampaigners,
    @required String headerImage,
    @required bool isSelected,
  }) {
    _id = id; 
    _title = title;
    _description = description;
    _numberOfCampaingers = numberOfCampaigners;
    _headerImage = headerImage;
    _isSelected = isSelected;
  }

  Campaign copyWith({
    int id,
    String title,
    String description,
    int numberOfCampaingers,
    String headerImage,
    bool isSelected,
  }) {
    return Campaign(
      id: id ?? this._id,
      title: title ?? this._title,
      description: description ?? this._description,
      numberOfCampaigners: numberOfCampaingers ?? this._numberOfCampaingers,
      headerImage: headerImage ?? this._headerImage,
      isSelected: isSelected ?? this._isSelected,
    );
  
  }

  int getId() {
    return _id; 
  }
  String getTitle() {
    return _title; 
  }
  String getDescription() {
    return _description; 
  }
  int getNumberOfCampaigners() {
    return _numberOfCampaingers; 
  }
  String getHeaderImage() {
    return _headerImage;
  }
  bool isSelected() {
    return _isSelected;
  }
  void setSelected(bool isSelected) {
    _isSelected = isSelected;
  }
}

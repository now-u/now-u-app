class Campaign {
  int _id;
  String _title;
  String _description;
  int _numberOfCampaingers;
  String _headerImage;
  bool _isSelected;
  
  Campaign(id, title, description, numberOfCampaigners, headerImage, isSelected) {
    _id = id; 
    _title = title;
    _description = description;
    _numberOfCampaingers = numberOfCampaigners;
    _headerImage = headerImage;
    _isSelected = isSelected;
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

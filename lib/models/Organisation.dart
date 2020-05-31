class Organisation {
  int id;
  String name;
  String description;
  String logoLink;
  List<int> linkedCampaigns;
  String email;
  String website;
  
  Organisation.fromJson(Map json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    logoLink = json['logo_link'];
    //linkedCampaigns = json['linked_campaigns'].cast<int>();
    email = json['email'];
    website = json['website'];
  }

  Map toJson() => {
    'id': id,
    'name': name,
    'description': description,
    'logo_link': logoLink,
    'linked_campaigns': linkedCampaigns,
    'email': email,
    'website': website,
  };

  String getName() {
    return name;
  }
  String getDescription() {
    return description;
  }
  String getLogoLink() {
    return logoLink;
  }
  List<int> getLinkedCampaigns() {
    return linkedCampaigns; 
  }
  String getEmail() {
    return email;
  }
  String getWebsite() {
    return website;
  }
}

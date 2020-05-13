class Organisation {
  int id;
  String name;
  String description;
  String logoLink;
  
  Organisation.fromJson(Map json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    logoLink = json['logoLink'];
  }

  Map toJson() => {
    'id': id,
    'name': name,
    'description': description,
    'logoLink': logoLink,
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
}
class User {
  int id;
  String fullName;
  String username;
  int age;

  // TODO make some attributes class that can take any attrribute so I dont need this
  String location;
  double monthlyDonationLimit;
  bool homeOwner;

  // Progress
  List<int> selectedCampaings;
  
  User({id, fullName, username, age, location, monthlyDonationLimit, homeOwner}) {
    this.id = id; 
    this.fullName = fullName;
    this.username = username;
    this.age = age;
    this.location = location;
    this.monthlyDonationLimit = monthlyDonationLimit;
    this.homeOwner = homeOwner;
    this.selectedCampaings = selectedCampaings ?? [];
  }

  User.fromJson(Map json)
    : id = json['id'],
      fullName = json['fullName'],
      username = json['username'],
      age = json['age'],
      location = json['location'],
      monthlyDonationLimit = json['monthlyDonationLimit'],
      homeOwner = json['homeOwner'],
      selectedCampaings = json['selectedCampaings'].cast<int>();

  Map toJson() => {
    'id': id, 
    'fullName': fullName, 
    'username': username, 
    'age': age, 
    'location': location, 
    'monthlyDonationLimit': monthlyDonationLimit, 
    'homeOwner': homeOwner, 
    'selectedCampaings': selectedCampaings, 
  };

  int getId() {
    return id; 
  }
  String getName() {
    return fullName; 
  }
  String getUsername() {
    return username; 
  }
  int getAge() {
    return age; 
  }
  String getLocation() {
    return location;
  }
  double getMonthlyDonationLimit() {
    return monthlyDonationLimit;
  }
  bool getHomeOwner() {
    return homeOwner;
  }
  Map getAttributes () {
    return {
      'id' : id, 
      'fullName': fullName, 
      'username': username,
      'age': age,
      'location': location,
      'monthlyDonationLimit': monthlyDonationLimit,
      'homeOwner': homeOwner,
    };
  }
  List<int> getSelectedCampaigns() {
    return selectedCampaings ?? [];
  }
  
  void setName(String name) {
    this.fullName = name; 
  }
  void setUsername(String username) {
    this.username = username; 
  }
  void setAge(int age) {
    this.age = age; 
  }
  void setLocation(location) {
    this.location = location;
  }
  void setMonthlyDonationLimit(monthlyDonationLimit) {
    this.monthlyDonationLimit = monthlyDonationLimit;
  }
  void setHomeOwner(bool homeOwner) {
    this.homeOwner = homeOwner;
  }
  void addSelectedCamaping(int id) {
    if (this.selectedCampaings == null) {
      this.selectedCampaings = [id];
    } else {
      this.selectedCampaings.add(id);
    }
  }
  void removeSelectedCamaping(int id) {
    this.selectedCampaings.remove(id);
  }
}

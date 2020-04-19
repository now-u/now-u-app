class User {
  int _id;
  String _fullName;
  String _username;
  int _age;

  // TODO make some attributes class that can take any attrribute so I dont need this
  String _location;
  double _monthlyDonationLimit;
  bool _homeOwner;
  
  User({id, fullName, username, age, location, monthlyDonationLimit, homeOwner}) {
    _id = id; 
    _fullName = fullName;
    _username = username;
    _age = age;
    _location = location;
    _monthlyDonationLimit = monthlyDonationLimit;
    _homeOwner = homeOwner;
  }

  int getId() {
    return _id; 
  }
  String getName() {
    return _fullName; 
  }
  String getUsername() {
    return _username; 
  }
  int getAge() {
    return _age; 
  }
  String getLocation() {
    return _location;
  }
  double getMonthlyDonationLimit() {
    return _monthlyDonationLimit;
  }
  bool getHomeOwner() {
    return _homeOwner;
  }
  Map getAttributes () {
    return {
      'id' : _id, 
      'fullName': _fullName, 
      'username': _username,
      'age': _age,
      'location': _location,
      'monthlyDonationLimit': _monthlyDonationLimit,
      'homeOwner': _homeOwner,
    };
  }
  
  void setName(String name) {
    _fullName = name; 
  }
  void setUsername(String username) {
     _username = username; 
  }
  void setAge(int age) {
    _age = age; 
  }
  void setLocation(location) {
    _location = location;
  }
  void setMonthlyDonationLimit(monthlyDonationLimit) {
    _monthlyDonationLimit = monthlyDonationLimit;
  }
  void setHomeOwner(bool homeOwner) {
    _homeOwner = homeOwner;
  }
}

import 'package:app/models/Reward.dart';
import 'package:app/models/Action.dart';
import 'dart:convert';

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
  List<int> selectedCampaigns = [];
  List<int> completedCampaigns = [];
  List<int> completedRewards = [];
  List<int> completedActions = [];

  Map<CampaignActionType, int> completedActionsType;
  
  User({id, fullName, username, age, location, monthlyDonationLimit, homeOwner, selectedCampaigns, completedCampaigns, completedActions, completedRewards, completedActionsType}) {
    this.id = id; 
    this.fullName = fullName;
    this.username = username;
    this.age = age;
    this.location = location;
    this.monthlyDonationLimit = monthlyDonationLimit;
    this.homeOwner = homeOwner;
    
    this.selectedCampaigns = selectedCampaigns ?? [];
    this.completedActions = completedActions ?? [];
    this.completedRewards = completedRewards ?? [];
    
    this.completedActionsType = 
        completedActionsType ?? this.initCompletedAction();
  }

  User copyWith({
    int id,
    String fullName,
    String username,
    int age,

    // TODO make some attributes class that can take any attrribute so I dont need this
    String location,
    double monthlyDonationLimit,
    bool homeOwner,

    // Progress
    List<int> selectedCampaigns,
    List<int> completedCampaigns,
    List<int> completedRewards,
    List<int> completedActions,

    Map<CampaignActionType, int> completedActionsType,
  }) {
    return User(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      username: username ?? this.username,
      age: age ?? this.age,
      location: location ?? this.location,
      monthlyDonationLimit: monthlyDonationLimit ?? this.monthlyDonationLimit,
      homeOwner: homeOwner ?? this.homeOwner,
      selectedCampaigns: selectedCampaigns ?? this.selectedCampaigns,
      completedCampaigns: completedCampaigns ?? this.completedCampaigns,
      completedRewards: completedRewards ?? this.completedRewards,
      completedActions: completedActions ?? this.completedActions,
      completedActionsType: completedActionsType ?? this.completedActionsType,
    );
  }

  User.fromJson(Map json) {
    id = json['id'];
    fullName = json['fullName'];
    username = json['username'];
    age = json['age'];
    location = json['location'];
    monthlyDonationLimit = json['monthlyDonationLimit'];
    homeOwner = json['homeOwner'];
    // For cast not to throw null exception must be a default value of [] in User class
    selectedCampaigns = json['selectedCampaigns'] == null ? <int>[] : json['selectedCampaigns'].cast<int>();
    completedCampaigns = json['completedCampaigns'] == null ? <int>[] : json['completedCampaigns'].cast<int>();
    completedActions = json['completedActions'] == null ? <int>[] : json['completedActions'].cast<int>();
    completedRewards = json['completedRewards'] == null ? <int>[] : json['completedRewards'].cast<int>();
    completedActionsType = json['completedActionsType'] == null ? this.initCompletedAction() : campaignActionTypesDecode(json['completedActionsType'].cast<int>());
  }

  Map toJson() => {
    'id': id, 
    'fullName': fullName, 
    'username': username, 
    'age': age, 
    'location': location, 
    'monthlyDonationLimit': monthlyDonationLimit, 
    'homeOwner': homeOwner, 
    'selectedCampaigns': selectedCampaigns, 
    'completedCampaigns': completedCampaigns, 
    'completedActions': completedActions, 
    'completedRewards': completedRewards, 
    'completedActionsType': campaignActionTypesEncode(completedActionsType), 
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
    return selectedCampaigns ?? [];
  }
  int getSelectedCampaignsLength() {
    if (selectedCampaigns == null) return 0;
    else return selectedCampaigns.length;
  }

  List<int> getCompletedActions() {
    return completedActions; 
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
    if (this.selectedCampaigns == null) {
      this.selectedCampaigns = [id];
    } else {
      this.selectedCampaigns.add(id);
    }
  }
  void removeSelectedCamaping(int id) {
    this.selectedCampaigns.remove(id);
  }

  // Progress
  // Return the reward progress
  double getRewardProgress(Reward reward) {
    if(this.completedRewards.contains(reward.getId())) return 1;
    RewardType type = reward.type;
    int count = 0;
    if (type == RewardType.CompletedActionsNumber) {
      count = this.completedActions.length;
    }
    else if (type == RewardType.CompletedCampaignsNumber) {
      count = this.completedCampaigns.length;
    } 
    else if (type == RewardType.SelectInOneMonthCampaignsNumber) {
      count = this.selectedCampaigns.length;
    }
    else if (type == RewardType.CompletedTypedActionsNumber) {
      if (reward.getActionType() == null) {
        print("A CompletedTypedActionsNumber reward requires a CampaignActionType");
        return 0;
      }
      else {
        count = this.completedActionsType[reward.getActionType()];
      }
    }

    // return 
    if (count > reward.successNumber) {
      completeReward(reward);
      return 1;
    } 
    return count / reward.successNumber;
  }
  
  void completeAction(CampaignAction a) {
    completedActions.add(a.getId());
    completedActionsType.update(a.getType(), (int x) => x + 1);
  }

  void completeReward(Reward r) {
    completedRewards.add(r.getId());
  }

  bool isCompleted(CampaignAction a) {
    return completedActions.contains(a.getId());
  }
  
  Map<CampaignActionType, int> initCompletedAction() {
    Map<CampaignActionType, int> cas = {
    
    };
    List<CampaignActionType> types = CampaignActionType.values;
    for (int i = 0; i < CampaignActionType.values.length; i++) {
      print(i);
      CampaignActionType t = types[i];
      cas[t] = 0;
    }
    print("Init Complete");
    return cas;
  }
  
}


// TODO this feels very fragile. Find out what happens if I delete/add a CampaignActionType
List<int> campaignActionTypesEncode ( Map<CampaignActionType, int> cats ) {
  List<int> encodable = <int>[];
  List<CampaignActionType> list = CampaignActionType.values;
  for (int i = 0; i < list.length; i++) {
    encodable.add(cats[list[i]]);
  }
  return encodable;
}
Map<CampaignActionType, int> campaignActionTypesDecode ( List<int> ints) {
  Map<CampaignActionType, int> cats = { };
  List<CampaignActionType> types = CampaignActionType.values;
  for (int i = 0; i < ints.length; i++) {
    CampaignActionType t = types[i];
    cats[t] = ints[i];
  }
  return cats;
}

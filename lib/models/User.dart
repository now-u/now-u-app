import 'package:app/models/Reward.dart';
import 'package:app/models/Action.dart';

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
  List<int> completedCampaigns = [];
  List<int> completedRewards = [];
  List<int> completedActions = [];

  Map<CampaignActionType, int> completedActionsType;
  
  User({id, fullName, username, age, location, monthlyDonationLimit, homeOwner, selectedCampaings, completedActions, completedRewards, completedActionsType}) {
    this.id = id; 
    this.fullName = fullName;
    this.username = username;
    this.age = age;
    this.location = location;
    this.monthlyDonationLimit = monthlyDonationLimit;
    this.homeOwner = homeOwner;
    
    this.selectedCampaings = selectedCampaings ?? [];
    this.completedActions = completedActions ?? [];
    this.completedRewards = completedRewards ?? [];
    
    this.completedActionsType = 
        completedActionsType ?? this.initCompletedAction();
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
  int getSelectedCampaignsLength() {
    if (selectedCampaings == null) return 0;
    else return selectedCampaings.length;
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

  // Progress
  // Return the reward progress
  double getRewardProgress(Reward reward, {CampaignActionType type}) {
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
      count = this.selectedCampaings.length;
    }
    else if (type == RewardType.CompletedTypedActionsNumber) {
      if (CampaignActionType == null) {
        print("A CompletedTypedActionsNumber reward requires a CampaignActionType");
        return 0;
      }
      else {
        count = this.completedActionsType[CampaignActionType];
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

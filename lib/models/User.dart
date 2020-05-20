import 'package:app/models/Reward.dart';
import 'package:app/models/Action.dart';
import 'package:app/models/Campaign.dart';
import 'package:app/models/Campaigns.dart';
import 'package:app/models/Action.dart';
import 'package:firebase_auth/firebase_auth.dart';

List<int> rewardValues = [1, 5, 10, 25, 50, 100, 200];
int pointsForJoiningCampaign = 10;
int pointsForCompletingAction = 5;

class User {
  int id;
  FirebaseUser firebaseUser;
  String fullName;
  String email;
  int age;

  // TODO make some attributes class that can take any attrribute so I dont need this
  String location;
  double monthlyDonationLimit;
  bool homeOwner;

  // Progress (All data stored as ids)
  List<int> selectedCampaigns = []; // Stores all campaings that have been selected (including old ones)
  List<int> completedCampaigns = []; // Stores campaings where all actions have been completed (maybe we should do 80% of something)
  List<int> completedRewards = []; 
  List<int> completedActions = [];

  Map<CampaignActionType, int> completedActionsType;
  
  int points;
  
  User({id, firebaseUser, fullName, email, age, location, monthlyDonationLimit, homeOwner, selectedCampaigns, completedCampaigns, completedActions, completedRewards, completedActionsType, points}) {
    this.id = id; 
    this.firebaseUser = firebaseUser;
    this.fullName = fullName;
    this.email = email;
    this.age = age;
    this.location = location;
    this.monthlyDonationLimit = monthlyDonationLimit;
    this.homeOwner = homeOwner;
    
    this.selectedCampaigns = selectedCampaigns ?? [];
    this.completedActions = completedActions ?? [];
    //this.completedRewards = completedRewards ?? [];
    
    this.completedActionsType = 
        completedActionsType ?? initCompletedAction();

    this.points = points ?? 0;
  }

  User.empty(){
    id= -1;
    fullName= "unknown";
    email = "unknown";
    age= -1;
    location= "uknown";
    monthlyDonationLimit= -1;
    homeOwner= false;
    selectedCampaigns = [];
    completedCampaigns = [];
    completedRewards = [];
    completedActions = [];
    completedActionsType = initCompletedAction();
    firebaseUser = null;
    points = 0;
  }

  User copyWith({
    int id,
    FirebaseUser firebaseUser,
    String fullName,
    String email,
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

    int points,
  }) {
    return User(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      age: age ?? this.age,
      location: location ?? this.location,
      monthlyDonationLimit: monthlyDonationLimit ?? this.monthlyDonationLimit,
      homeOwner: homeOwner ?? this.homeOwner,
      selectedCampaigns: selectedCampaigns ?? this.selectedCampaigns,
      completedCampaigns: completedCampaigns ?? this.completedCampaigns,
      completedRewards: completedRewards ?? this.completedRewards,
      completedActions: completedActions ?? this.completedActions,
      completedActionsType: completedActionsType ?? this.completedActionsType,
      firebaseUser: firebaseUser ?? this.firebaseUser,
      points: points ?? this.points,
    );
  }

  User.fromJson(Map json) {
    id = json['id'];
    fullName = json['full_name'];
    email = json['email'];
    age = json['age'];
    location = json['location'];
    monthlyDonationLimit = json['monthly_donation_limit'];
    homeOwner = json['home_owner'];
    // For cast not to throw null exception must be a default value of [] in User class
    selectedCampaigns = json['selected_campaigns'] == null ? <int>[] : json['selected_campaigns'].cast<int>();
    completedCampaigns = json['completed_campaigns'] == null ? <int>[] : json['completed_campaigns'].cast<int>();
    completedActions = json['completed_actions'] == null ? <int>[] : json['completed_actions'].cast<int>();
    completedRewards = json['completed_rewards'] == null ? <int>[] : json['completed_rewards'].cast<int>();
    completedActionsType = json['completed_actions_type'] == null ? this.initCompletedAction() : campaignActionTypesDecode(json['completed_actions_type'].cast<int>());
    
    points = json['points'];
  }
Map toJson() => {
    'id': id, 
    'full_name': fullName, 
    'email': email, 
    'age': age, 
    'location': location, 
    'monthly_donation_limit': monthlyDonationLimit, 
    'home_owner': homeOwner, 
    'selected_campaigns': selectedCampaigns, 
    'completed_campaigns': completedCampaigns, 
    'completed_actions': completedActions, 
    'completed_rewards': completedRewards, 
    'completed_actions_type': campaignActionTypesEncode(completedActionsType), 
    'points': points, 
  };

  Map getAttributes () {
    return {
      //'id' : id, 
      'fullName': fullName, 
      'email': email,
      'age': age,
      'location': location,
      'monthlyDonationLimit': monthlyDonationLimit,
      'homeOwner': homeOwner,
    };
  }
  void setAttribute (String k, v) {
    switch (k) {
      case 'fullName': {
        this.setName(v);
        break;
      }
      case 'email': {
        this.setEmail(v);
        break;
      }
      case 'age': {
        this.setAge(v);
        break;
      }
      case 'location': {
        this.setLocation(v);
        break;
      }
      case 'monthlyDonationLimit': {
        this.setMonthlyDonationLimit(v);
        break;
      }
      case 'homeOwner': {
        this.setHomeOwner(v);
        break;
      }
    }     
  }

  int getId() {
    return id; 
  }
  String getName() {
    return fullName; 
  }
  String getEmail() {
    return email; 
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
  int getPoints() {
    return points;
  }

  void setName(String name) {
    this.fullName = name; 
  }
  void setEmail(String email) {
    this.email = email; 
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
  void setPoints(int points) {
    this.points = points;
  }
  void incrementPoints(int points) {
    this.points += points;
    print("User points are now " + this.points.toString());
  }
  void decrementPoints(int points) {
    this.points -= points;
    print("User points are now " + this.points.toString());
  }

  void addSelectedCamaping(int id) {
    if (!selectedCampaigns.contains(id)) {
      if (this.selectedCampaigns == null) {
        this.selectedCampaigns = [id];
      } else {
        this.selectedCampaigns.add(id);
      }
      incrementPoints(pointsForJoiningCampaign);
    }
  }
  void removeSelectedCamaping(int id) {
    this.selectedCampaigns.remove(id);
    decrementPoints(pointsForJoiningCampaign);
  }

  double getCampaignProgress(Campaign campaign) {
     return numberOfCompletedActionsForCampaign(campaign) / campaign.getActions().length;
  }

  int numberOfCompletedActionsForCampaign(Campaign campaign) {
    int count = 0;
    List<CampaignAction> actions = campaign.getActions();
    for(int i = 0; i < actions.length; i++){
      if( this.completedActions.contains(actions[i].getId()) ) {
        count++;
      }
    } 
    return count;
  }
  
  double getActiveCampaignsProgress(Campaigns campaigns) {
    double total = 0;
    for (int i = 0; i < campaigns.activeLength(); i++) {
      total += getCampaignProgress(campaigns.getActiveCampaigns()[i]);
    }
    return total / campaigns.activeLength();
  }



  // Progress
  // Return the reward progress
  double getRewardProgress(Reward reward) {
    //if(this.completedRewards.contains(reward.getId())) return 1;
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
      //completeReward(reward);
      return 1;
    } 
    return count / reward.successNumber;
  }
  
  void completeAction(CampaignAction a, {Function onCompleteReward}) {
    if (completedActions.contains(a.getId())) {
      print("You can only complete an action once");
      return;
    }
    completedActions.add(a.getId());
    completedActionsType.update(a.getType(), (int x) => x + 1);
    incrementPoints(pointsForCompletingAction);
    print(a.getType().toString());
    print(completedActionsType[a.getType()]);
  }

  bool isMilestone(int x) {
    if ( x < 300 ) {
      return rewardValues.contains(x);
    }
    else 
      return x % 50 == 0;
  }

  // Returns the news rewards completed when this action is completed
  List<Reward> newlyCompletedRewards(CampaignAction completedAction) {
    List<Reward> newRewards = [];
    if (isMilestone(completedActions.length+1)) {
      newRewards.add(
        Reward(
          successNumber: completedActions.length+1,
          type: RewardType.CompletedActionsNumber,
          //title: nextValue(v, rewardValues) == 1 ? "Complete your first ${ k.toString() } " : "Complete ${ nextValue(v, rewardValues)} ${ k.toString() }",
        )
      );
    }
    print(completedAction.getType());
    print(this.completedActionsType);
    if (isMilestone(completedActionsType[completedAction.getType()]+1)) {
      newRewards.add(
        Reward(
          successNumber: completedActionsType[completedAction.getType()] + 1,
          type: RewardType.CompletedTypedActionsNumber,
          actionType: completedAction.getType(),
        ) 
      );
    }
    return newRewards;
  }

  // Old reward system
  //void completeReward(Reward r) {
  //  completedRewards.add(r.getId());
  //}

  bool isCompleted(CampaignAction a) {
    return completedActions.contains(a.getId());
  }
  
  Map<CampaignActionType, int> initCompletedAction() {
    Map<CampaignActionType, int> cas = {};
    List<CampaignActionType> types = CampaignActionType.values;
    for (int i = 0; i < CampaignActionType.values.length; i++) {
      print(i);
      CampaignActionType t = types[i];
      cas[t] = 0;
    }
    print(cas);
    return cas;
  }

  int nextValue (int x, List<int> nums) {
    for ( int i = 0; i < nums.length; i++ ) {
      if(rewardValues[i] > x) return rewardValues[i];
    }
    return ((x % 100) + 1) * 100; // Keep incrememnting rewardValues in 100s
  }
  int prevValue (int x, List<int> nums) {
    if (x <= 0) return 0; // In this case no reward completed
    if (x >= 300) {
      return ((x % 100)) * 100; // Keep incrememnting rewardValues in 100s

    }
    for ( int i = nums.length - 1; i >= 0; i-- ) {
      if(rewardValues[i] <= x) return rewardValues[i];
    }
    return 0; // Probably bad news if we get here
  }
 
  // Get rewards to be completed
  List<Reward> getNextRewards({int x}) {
    List<Reward> rewards = [];
    // Get new CompletedTypedActionsNumber
    completedActionsType.forEach((k, v) {
      rewards.add(
        Reward(
          successNumber: nextValue(v, rewardValues),
          type: RewardType.CompletedTypedActionsNumber,
          actionType: k,
          //title: nextValue(v, rewardValues) == 1 ? "Complete your first ${ k.toString() } " : "Complete ${ nextValue(v, rewardValues)} ${ k.toString() }",
        )
      );
    });
    // Add next completedActionsNumber
    rewards.add(
      Reward(
        successNumber: nextValue(completedCampaigns.length, rewardValues),
        type: RewardType.CompletedCampaignsNumber,
      )
    );
    
    // Add total completed actions 
    rewards.add(
      Reward(
        successNumber: nextValue(completedActions.length, rewardValues),
        type: RewardType.CompletedActionsNumber,
      )
    );
    return rewards;
  }
  
  // Get largest reward that have been completed
  List<Reward> getPreviousRewards({int x}) {
    List<Reward> rewards = [];
    // Get pev (complted) CompletedTypedActionsNumber
    completedActionsType.forEach((k, v) {
      if (prevValue(v, rewardValues) != 0) {
        rewards.add(
          Reward(
            //id: ,  // Need to generate id based on value --> same each time generated
            successNumber: prevValue(v, rewardValues),
            type: RewardType.CompletedTypedActionsNumber,
            actionType: k,
            //title: prevValue(v, rewardValues) == 1 ? "Complete your first ${ k.toString() } " : "Complete ${ prevValue(v, rewardValues)} ${ k.toString() }",
          )
        );
      }
    });
    
    // Add total completed campaigns 
    if (completedCampaigns.length > 0) {
      rewards.add(
        Reward(
          successNumber: prevValue(completedCampaigns.length, rewardValues),
          type: RewardType.CompletedCampaignsNumber,
        )
      );
    }
    
    // Add total completed actions 
    if (completedActions.length > 0) {
      rewards.add(
        Reward(
          successNumber: prevValue(completedActions.length, rewardValues),
          type: RewardType.CompletedActionsNumber,
        )
      );
    }

    print("previous rewards");
    print(rewards.length);
    return rewards;
  }

  List<Reward> getAllRewards({int x}) {
    List<Reward> completedRewards = getPreviousRewards();
    List<Reward> nextRewards = getNextRewards();
    return completedRewards..addAll(nextRewards);
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

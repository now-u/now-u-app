import 'package:app/models/Reward.dart';
import 'package:app/models/Action.dart';
import 'package:app/models/Campaign.dart';
import 'package:app/models/Organisation.dart';

List<String> stagingUsers = [
  "james@now-u.com",
  "dave@now-u.com",
  "valusoutrik@gmail.com",
  "jamezy850@gmail.com",
  "charlieblindsay@gmail.com"
];

class User {
  int? id;
  //FirebaseUser firebaseUser;
  String? fullName;
  String? email;
  DateTime? dateOfBirth;

  // TODO make some attributes class that can take any attrribute so I dont need this
  String? location;
  double? monthlyDonationLimit;
  bool? homeOwner;

  // Progress (All data stored as ids)
  List<int>? selectedCampaigns =
      []; // Stores all campaings that have been selected (including old ones)
  List<int>? completedCampaigns =
      []; // Stores campaings where all actions have been completed (maybe we should do 80% of something)
  //List<int> completedRewards = [];
  List<int?>? completedActions = [];
  List<int>? completedLearningResources = [];

  // Key is rejected id
  // Map stores rejection time and rejection reason
  List<int?>? rejectedActions = [];

  List<int>? starredActions = [];

  Map<CampaignActionType?, int>? completedActionsType;

  int? points;

  Organisation? _organisation;
  Organisation? get organisation => _organisation;
  set setOrganisation(Organisation? org) => _organisation = org;

  String? _token;
  String? get token => this._token;

  bool get isStagingUser => stagingUsers.contains(this.email);

  User({
    id,
    token,
    fullName,
    email,
    dateOfBirth,
    location,
    monthlyDonationLimit,
    homeOwner,
    selectedCampaigns,
    completedCampaigns,
    completedActions,
    rejectedActions,
    starredActions,
    completedRewards,
    completedActionsType,
    completedLearningResources,
    points,
    organisation,
  }) {
    this.id = id;
    this.fullName = fullName;
    this.email = email;
    this.dateOfBirth = dateOfBirth;
    this.location = location;
    this.monthlyDonationLimit = monthlyDonationLimit;
    this.homeOwner = homeOwner;

    this.selectedCampaigns = selectedCampaigns ?? [];
    this.completedActions = completedActions ?? [];
    this.rejectedActions = rejectedActions ?? [];
    this.starredActions = starredActions ?? [];
    //this.completedRewards = completedRewards ?? [];

    this.completedLearningResources = completedLearningResources ?? [];

    this.completedActionsType = completedActionsType ?? initCompletedAction();

    this._token = token;
    _organisation = organisation;
  }

  // This will be removed real soon cause if the user token is null then we need to login again
  User.empty() {
    id = -1;
    fullName = "unknown";
    email = "unknown";
    dateOfBirth = DateTime(1990, 1, 1);
    location = "uknown";
    monthlyDonationLimit = -1;
    homeOwner = false;
    selectedCampaigns = [];
    completedCampaigns = [];
    //completedRewards = [];
    completedActions = [];
    rejectedActions = [];
    starredActions = [];
    completedLearningResources = [];
    completedActionsType = initCompletedAction();
    _token = null;
  }

  User copyWith({
    int? id,
    //FirebaseUser firebaseUser,
    String? fullName,
    String? email,
    DateTime? dateOfBirth,

    // TODO make some attributes class that can take any attrribute so I dont need this
    String? location,
    double? monthlyDonationLimit,
    bool? homeOwner,

    // Progress
    List<int>? selectedCampaigns,
    List<int>? completedCampaigns,
    //List<int> completedRewards,
    List<int?>? completedActions,
    List<int?>? rejectedActions,
    List<int>? starredActions,
    List<int>? completedLearningResources,
    Map<CampaignActionType, int>? completedActionsType,
    String? token,
    Organisation? organisation,
  }) {
    return User(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      location: location ?? this.location,
      monthlyDonationLimit: monthlyDonationLimit ?? this.monthlyDonationLimit,
      homeOwner: homeOwner ?? this.homeOwner,
      selectedCampaigns: selectedCampaigns ?? this.selectedCampaigns,
      completedCampaigns: completedCampaigns ?? this.completedCampaigns,
      //completedRewards: completedRewards ?? this.completedRewards,
      completedActions: completedActions ?? this.completedActions,
      rejectedActions: rejectedActions ?? this.rejectedActions,
      starredActions: starredActions ?? this.starredActions,
      completedLearningResources:
          completedLearningResources ?? this.completedLearningResources,
      completedActionsType: completedActionsType ?? this.completedActionsType,
      token: token ?? this._token,
      organisation: organisation ?? _organisation,
    );
  }

  User.fromJson(
    Map json,
  ) {
    print("Getting user deets");
    id = json['id'];
    fullName = json['full_name'];
    email = json['email'];
    print("Getting up to email");
    dateOfBirth = json['date_of_birth'] == null || json['date_of_birth'] == ""
        ? null
        : DateTime.tryParse(json['date_of_birth']);
    location = json['location'];
    monthlyDonationLimit = json['monthly_donation_limit'];
    homeOwner = json['home_owner'] ?? false;
    print("Getting up to selectedCampaigns");
    // For cast not to throw null exception must be a default value of [] in User class
    selectedCampaigns =
        json['selected_campaigns'] == null || json['selected_campaigns'].isEmpty
            ? <int>[]
            : json['selected_campaigns'].cast<int>();
    print("Getting up to completed campaigns");
    completedCampaigns = json['completed_campaigns'] == null ||
            json['completed_campaigns'].isEmpty
        ? <int>[]
        : json['completed_campaigns'].cast<int>();
    print("Getting up to completed actions");
    completedActions =
        json['completed_actions'] == null || json['completed_actions'].isEmpty
            ? <int>[]
            : json['completed_actions'].cast<int>();
    rejectedActions =
        json['rejected_actions'] == null || json['rejected_actions'].isEmpty
            ? <int>[]
            : json['rejected_actions'].cast<int>();
    starredActions =
        json['favourited_actions'] == null || json['favourited_actions'].isEmpty
            ? <int>[]
            : json['favourited_actions'].cast<int>();

    completedLearningResources = json['completed_learning_resources'] == null ||
            json['completed_learning_resources'].isEmpty
        ? <int>[]
        : json['completed_learning_resources'].cast<int>();

    completedActionsType = json['completed_actions_type'] == null
        ? this.initCompletedAction()
        : campaignActionTypesDecode(json['completed_actions_type'].cast<int>());

    _token = json['token'];
    _organisation = json['organisation'] == null
        ? null
        : Organisation.fromJson(json['organisation']);
    print("Got new user");
  }
  Map toJson() => {
        'id': id,
        'full_name': fullName,
        'email': email,
        'date_of_birth':
            dateOfBirth == null ? null : dateOfBirth!.toIso8601String(),
        'location': location,
        'monthly_donation_limit': monthlyDonationLimit,
        'home_owner': homeOwner,
        'selected_campaigns': selectedCampaigns,
        'completed_campaigns': completedCampaigns,
        'completed_actions': completedActions,
        'rejected_actions': rejectedActions,
        'favourited_actions': starredActions,
        'completed_learning_resources': completedLearningResources,
        'completed_actions_type':
            campaignActionTypesEncode(completedActionsType),
        'token': _token,
      };

  Map getAttributes() {
    return {
      //'id' : id,
      'full_name': fullName,
      'email': email,
      'date_of_birth': dateOfBirth,
      'location': location,
      'monthly_donation_limit': monthlyDonationLimit ?? -1.0,
      'home_owner': homeOwner,
    };
  }

  Map getPostAttributes() {
    return {
      //'id' : id,
      'full_name': fullName,
      'email': email,
      'date_of_birth': dateOfBirth.toString(),
      'location': location,
      'monthly_donatIon_limit': monthlyDonationLimit,
      'home_owner': homeOwner,
    };
  }

  void setAttribute(String k, v) {
    switch (k) {
      case 'full_name':
        {
          this.setName(v.toString());
          break;
        }
      case 'email':
        {
          this.setEmail(v.toString());
          break;
        }
      case 'date_of_birth':
        {
          print("Settting attribute dob");
          this.setDateOfBirth(v);
          break;
        }
      case 'location':
        {
          this.setLocation(v.toString());
          break;
        }
      case 'monthly_donation_limit':
        {
          this.setMonthlyDonationLimit(v);
          break;
        }
      case 'home_owner':
        {
          bool value = v;
          this.setHomeOwner(value);
          break;
        }
    }
  }

  int? getId() {
    return id;
  }

  String? getName() {
    return fullName;
  }

  String? getEmail() {
    return email;
  }

  DateTime? getDateOfBirth() {
    return dateOfBirth;
  }

  int getAge() {
    //TODO calculate from dob
    return -1;
  }

  String? getLocation() {
    return location;
  }

  double? getMonthlyDonationLimit() {
    return monthlyDonationLimit;
  }

  bool? getHomeOwner() {
    return homeOwner;
  }

  List<int> getSelectedCampaigns() {
    return selectedCampaigns ?? [];
  }

  List<Campaign> filterSelectedCampaigns(List<Campaign> campaigns) {
    return campaigns
        .where((c) => selectedCampaigns!.contains(c.id))
        .toList();
  }

  List<Campaign> filterUnselectedCampaigns(List<Campaign> campaigns) {
    return campaigns
        .where((c) => !selectedCampaigns!.contains(c.id))
        .toList();
  }

  int getSelectedCampaignsLength() {
    if (selectedCampaigns == null)
      return 0;
    else
      return selectedCampaigns!.length;
  }

  List<int?>? getCompletedActions() {
    return completedActions;
  }

  List<int?>? getRejectedActions() {
    return rejectedActions;
  }

  List<int>? getStarredActions() {
    return starredActions;
  }

  List<int>? getCompletedLearningResources() {
    return completedLearningResources;
  }

  void setName(String? name) {
    this.fullName = name;
  }

  void setEmail(String email) {
    this.email = email;
  }

  void setDateOfBirth(DateTime? dob) {
    this.dateOfBirth = dob;
  }

  void setLocation(location) {
    this.location = location;
  }

  void setMonthlyDonationLimit(double monthlyDonationLimit) {
    this.monthlyDonationLimit = monthlyDonationLimit;
  }

  void setHomeOwner(bool homeOwner) {
    this.homeOwner = homeOwner;
  }

  void setCompletedActions(List<int?>? actions) {
    this.completedActions = actions;
  }

  void setToken(String token) {
    this._token = token;
  }

  void addSelectedCamaping(int id) {
    if (!selectedCampaigns!.contains(id)) {
      if (this.selectedCampaigns == null) {
        this.selectedCampaigns = [id];
      } else {
        this.selectedCampaigns!.add(id);
      }
    }
  }

  void removeSelectedCamaping(int id) {
    this.selectedCampaigns!.remove(id);
  }

  double getCampaignProgress(Campaign campaign) {
    return numberOfCompletedActionsForCampaign(campaign) /
        campaign.actions.length;
  }

  int numberOfCompletedActionsForCampaign(Campaign campaign) {
    int count = 0;
    List<ListCauseAction> actions = campaign.actions;
    for (int i = 0; i < actions.length; i++) {
      if (this.completedActions!.contains(actions[i].id)) {
        count++;
      }
    }
    return count;
  }

  void completeAction(CampaignAction a, {Function? onCompleteReward}) {
    if (completedActions!.contains(a.id)) {
      return;
    }
    completedActions!.add(a.id);
    completedActionsType!.update(a.type, (int x) => x + 1);
  }

  void rejectAction(CampaignAction a) {
    rejectedActions!.add(a.id);
  }

  bool isCompleted(CampaignAction a) {
    return completedActions!.contains(a.id);
  }

  Map<CampaignActionType?, int> initCompletedAction() {
    Map<CampaignActionType?, int> cas = {};
    List<CampaignActionType> types = CampaignActionType.values;
    for (int i = 0; i < CampaignActionType.values.length; i++) {
      print(i);
      CampaignActionType t = types[i];
      cas[t] = 0;
    }
    print(cas);
    return cas;
  }
}

// TODO this feels very fragile. Find out what happens if I delete/add a CampaignActionType
List<int?> campaignActionTypesEncode(Map<CampaignActionType?, int>? cats) {
  List<int?> encodable = <int?>[];
  List<CampaignActionType> list = CampaignActionType.values;
  for (int i = 0; i < list.length; i++) {
    encodable.add(cats![list[i]]);
  }
  return encodable;
}

Map<CampaignActionType, int> campaignActionTypesDecode(List<int> ints) {
  Map<CampaignActionType, int> cats = {};
  List<CampaignActionType> types = CampaignActionType.values;
  for (int i = 0; i < ints.length; i++) {
    CampaignActionType t = types[i];
    cats[t] = ints[i];
  }
  return cats;
}

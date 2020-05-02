import 'package:app/models/Campaigns.dart';
import 'package:flutter/foundation.dart';

import 'package:app/models/Campaign.dart';
import 'package:app/models/User.dart';
import 'package:app/models/Action.dart';
import 'package:app/models/Reward.dart';
import 'package:app/models/Rewards.dart';

class AppState {
  Campaigns campaigns;
  User user;
  bool loading;
  //final Rewards rewards;

  AppState({
    @required this.user,
    @required this.campaigns,
    @required this.loading,
  });

  AppState.initialState() {
      user = User(
          id: 0,
          fullName: "Andrew",
          username: "Andy123",
          age: 21,
          location: "Bristol",
          monthlyDonationLimit: 20.0,
          homeOwner: false,
        );
        campaigns = Campaigns.init();
        loading = true;
  }

  AppState.fromJson(Map json, AppState state)
    : //campaigns = (json['campaigns'] as List).map((c) => Campaign.fromJson(c)).toList(),
      //user = (User.fromJson(json['user']));
    campaigns = state.campaigns,
    loading = state.loading,
    user = User.fromJson(json['user']);

  Map toJson() => {
    //'campaigns': campaigns, 
    'user': user};
}

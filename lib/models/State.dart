import 'package:flutter/foundation.dart';

import 'package:app/models/Campaign.dart';
import 'package:app/models/User.dart';

class AppState {
  final List<Campaign> campaigns;
  final User user;

  AppState({
    @required this.user,
    @required this.campaigns,
  });

  AppState.initialState() 
      : user = User(
          id: 0,
          fullName: "Andrew",
          username: "Andy123",
          age: 21,
          location: "Bristol",
          monthlyDonationLimit: 20.0,
          homeOwner: false,
        ),
        campaigns = List.unmodifiable(
      <Campaign> [
        Campaign(
            id: 0, 
            title: "Refugees", 
            description: "Help with the things", 
            numberOfCampaigners: 270, 
            headerImage: "https://cdn.pixabay.com/photo/2013/04/16/14/23/eritrea-105081_960_720.jpg", 
        ),
        Campaign(
            id: 1, 
            title: "Corona", 
            description: "Help with the corona things", 
            numberOfCampaigners: 340, 
            headerImage: "https://cdn.pixabay.com/photo/2013/04/16/14/23/eritrea-105081_960_720.jpg", 
        ),
        Campaign(
            id: 2, 
            title: "Other thing", 
            description: "Help with the other things", 
            numberOfCampaigners: 180, 
            headerImage: "https://cdn.pixabay.com/photo/2013/04/16/14/23/eritrea-105081_960_720.jpg", 
        ),
      ]
    );

  AppState.fromJson(Map json, AppState state)
    : //campaigns = (json['campaigns'] as List).map((c) => Campaign.fromJson(c)).toList(),
      //user = (User.fromJson(json['user']));
    campaigns = state.campaigns,
    user = User.fromJson(json['user']);

  Map toJson() => {
    //'campaigns': campaigns, 
    'user': user};
}

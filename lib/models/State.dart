import 'package:flutter/foundation.dart';

import 'package:app/models/Campaign.dart';
import 'package:app/models/User.dart';
import 'package:app/models/Action.dart';

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
            actions: [
              CampaignAction(
                  id: 0,
                  title: "Donate to this",
                  description: "Et ipsum viverra malesuada. Duis luctus. Curabitur adipiscing metus et felis. Vestibulum tortor. Pellentesque purus. Donec pharetra, massa quis malesuada auctor, tortor ipsum lobortis ipsum, eget facilisis ante nisieget lectus. Sed a est. Aliquam nec felis eu sem euismod viverra. Suspendisse felis mi, dictum id, convallis ac, mattis non, nibh. Donec sagittis quam eu mauris. Phasellus et leo at quam dapibus pellentesque. In non lacus. Nullam tristique nunc ut arcu scelerisque aliquam. Nullam viverra magna vitae leo. Vestibulum in lacus sit amet lectus tempus aliquet. Duis cursus nisl ac orci. Donec non nisl. Mauris lacus sapien, congue a, facilisis at.",
                  link: "now-u.com",
                  type: CampaignActionType.Donation,
              ),
              CampaignAction(
                  id: 1,
                  title: "Buy from this shop",
                  description: "Et ipsum viverra malesuada. Duis luctus. Curabitur adipiscing metus et felis. Vestibulum tortor. Pellentesque purus. Donec pharetra, massa quis malesuada auctor, tortor ipsum lobortis ipsum, eget facilisis ante nisieget lectus. Sed a est. Aliquam nec felis eu sem euismod viverra. Suspendisse felis mi, dictum id, convallis ac, mattis non, nibh. Donec sagittis quam eu mauris. Phasellus et leo at quam dapibus pellentesque. In non lacus. Nullam tristique nunc ut arcu scelerisque aliquam. Nullam viverra magna vitae leo. Vestibulum in lacus sit amet lectus tempus aliquet. Duis cursus nisl ac orci. Donec non nisl. Mauris lacus sapien, congue a, facilisis at.",
                  type: CampaignActionType.Shop,
                  link: "now-u.com",
              ),
              CampaignAction(
                  id: 2,
                  title: "Sign petiton for this camp",
                  description: "Et ipsum viverra malesuada. Duis luctus. Curabitur adipiscing metus et felis. Vestibulum tortor. Pellentesque purus. Donec pharetra, massa quis malesuada auctor, tortor ipsum lobortis ipsum, eget facilisis ante nisieget lectus. Sed a est. Aliquam nec felis eu sem euismod viverra. Suspendisse felis mi, dictum id, convallis ac, mattis non, nibh. Donec sagittis quam eu mauris. Phasellus et leo at quam dapibus pellentesque. In non lacus. Nullam tristique nunc ut arcu scelerisque aliquam. Nullam viverra magna vitae leo. Vestibulum in lacus sit amet lectus tempus aliquet. Duis cursus nisl ac orci. Donec non nisl. Mauris lacus sapien, congue a, facilisis at.",
                  link: "now-u.com",
                  type: CampaignActionType.Petition,
              ),
            ]
        ),
        Campaign(
            id: 1, 
            title: "Corona", 
            description: "Help with the corona things", 
            numberOfCampaigners: 340, 
            headerImage: "https://cdn.pixabay.com/photo/2013/04/16/14/23/eritrea-105081_960_720.jpg", 
            actions: [
              CampaignAction(
                  id: 3,
                  title: "Read and share this news article",
                  description: "Et ipsum viverra malesuada. Duis luctus. Curabitur adipiscing metus et felis. Vestibulum tortor. Pellentesque purus. Donec pharetra, massa quis malesuada auctor, tortor ipsum lobortis ipsum, eget facilisis ante nisieget lectus. Sed a est. Aliquam nec felis eu sem euismod viverra. Suspendisse felis mi, dictum id, convallis ac, mattis non, nibh. Donec sagittis quam eu mauris. Phasellus et leo at quam dapibus pellentesque. In non lacus. Nullam tristique nunc ut arcu scelerisque aliquam. Nullam viverra magna vitae leo. Vestibulum in lacus sit amet lectus tempus aliquet. Duis cursus nisl ac orci. Donec non nisl. Mauris lacus sapien, congue a, facilisis at.",
                  link: "now-u.com",
                  type: CampaignActionType.Learn
              ),
              CampaignAction(
                  id: 4,
                  title: "Stay Home",
                  description: "Et ipsum viverra malesuada. Duis luctus. Curabitur adipiscing metus et felis. Vestibulum tortor. Pellentesque purus. Donec pharetra, massa quis malesuada auctor, tortor ipsum lobortis ipsum, eget facilisis ante nisieget lectus. Sed a est. Aliquam nec felis eu sem euismod viverra. Suspendisse felis mi, dictum id, convallis ac, mattis non, nibh. Donec sagittis quam eu mauris. Phasellus et leo at quam dapibus pellentesque. In non lacus. Nullam tristique nunc ut arcu scelerisque aliquam. Nullam viverra magna vitae leo. Vestibulum in lacus sit amet lectus tempus aliquet. Duis cursus nisl ac orci. Donec non nisl. Mauris lacus sapien, congue a, facilisis at.",
                  link: "now-u.com",
                  type: CampaignActionType.Other
              ),
              CampaignAction(
                  id: 5,
                  title: "Protect the NHS",
                  description: "Et ipsum viverra malesuada. Duis luctus. Curabitur adipiscing metus et felis. Vestibulum tortor. Pellentesque purus. Donec pharetra, massa quis malesuada auctor, tortor ipsum lobortis ipsum, eget facilisis ante nisieget lectus. Sed a est. Aliquam nec felis eu sem euismod viverra. Suspendisse felis mi, dictum id, convallis ac, mattis non, nibh. Donec sagittis quam eu mauris. Phasellus et leo at quam dapibus pellentesque. In non lacus. Nullam tristique nunc ut arcu scelerisque aliquam. Nullam viverra magna vitae leo. Vestibulum in lacus sit amet lectus tempus aliquet. Duis cursus nisl ac orci. Donec non nisl. Mauris lacus sapien, congue a, facilisis at.",
                  link: "now-u.com",
                  type: CampaignActionType.Other
              ),
            ]
        ),
        Campaign(
            id: 2, 
            title: "Other thing", 
            description: "Help with the other things", 
            numberOfCampaigners: 180, 
            headerImage: "https://cdn.pixabay.com/photo/2013/04/16/14/23/eritrea-105081_960_720.jpg", 
            actions: [
              CampaignAction(
                  id: 6,
                  title: "Send this email to other",
                  description: "Et ipsum viverra malesuada. Duis luctus. Curabitur adipiscing metus et felis. Vestibulum tortor. Pellentesque purus. Donec pharetra, massa quis malesuada auctor, tortor ipsum lobortis ipsum, eget facilisis ante nisieget lectus. Sed a est. Aliquam nec felis eu sem euismod viverra. Suspendisse felis mi, dictum id, convallis ac, mattis non, nibh. Donec sagittis quam eu mauris. Phasellus et leo at quam dapibus pellentesque. In non lacus. Nullam tristique nunc ut arcu scelerisque aliquam. Nullam viverra magna vitae leo. Vestibulum in lacus sit amet lectus tempus aliquet. Duis cursus nisl ac orci. Donec non nisl. Mauris lacus sapien, congue a, facilisis at.",
                  link: "now-u.com",
                  type: CampaignActionType.Email
              ),
              CampaignAction(
                  id: 7,
                  title: "Send a different email to other",
                  description: "Et ipsum viverra malesuada. Duis luctus. Curabitur adipiscing metus et felis. Vestibulum tortor. Pellentesque purus. Donec pharetra, massa quis malesuada auctor, tortor ipsum lobortis ipsum, eget facilisis ante nisieget lectus. Sed a est. Aliquam nec felis eu sem euismod viverra. Suspendisse felis mi, dictum id, convallis ac, mattis non, nibh. Donec sagittis quam eu mauris. Phasellus et leo at quam dapibus pellentesque. In non lacus. Nullam tristique nunc ut arcu scelerisque aliquam. Nullam viverra magna vitae leo. Vestibulum in lacus sit amet lectus tempus aliquet. Duis cursus nisl ac orci. Donec non nisl. Mauris lacus sapien, congue a, facilisis at.",
                  link: "now-u.com",
                  type: CampaignActionType.Email
              ),
              CampaignAction(
                  id: 8,
                  title: "Sign petiton for other thing",
                  description: "Et ipsum viverra malesuada. Duis luctus. Curabitur adipiscing metus et felis. Vestibulum tortor. Pellentesque purus. Donec pharetra, massa quis malesuada auctor, tortor ipsum lobortis ipsum, eget facilisis ante nisieget lectus. Sed a est. Aliquam nec felis eu sem euismod viverra. Suspendisse felis mi, dictum id, convallis ac, mattis non, nibh. Donec sagittis quam eu mauris. Phasellus et leo at quam dapibus pellentesque. In non lacus. Nullam tristique nunc ut arcu scelerisque aliquam. Nullam viverra magna vitae leo. Vestibulum in lacus sit amet lectus tempus aliquet. Duis cursus nisl ac orci. Donec non nisl. Mauris lacus sapien, congue a, facilisis at.",
                  link: "now-u.com",
                  type: CampaignActionType.Petition
              ),
            ]
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

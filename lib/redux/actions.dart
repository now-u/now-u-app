import 'package:app/models/User.dart';
import 'package:app/models/Action.dart';
import 'package:app/models/Campaign.dart';
import 'package:app/models/Campaigns.dart';
//import 'package:firebase_auth/firebase_auth.dart';

class InitaliseState {}

class InitalisedState {
  InitalisedState();
}

class JoinCampaign {
  final Campaign campaign;
  final Function onSuccess;

  JoinCampaign(this.campaign, this.onSuccess);
}
class JoinedCampaign {
  final int points;
  final List<int> joinedCampaigns;  
  final Function onSuccess;

  JoinedCampaign(this.points, this.joinedCampaigns, this.onSuccess);
}

class UnjoinCampaign {
  final Campaign campaign;

  UnjoinCampaign(this.campaign);
}
class UnjoinedCampaign {
  final int points;
  final List<int> joinedCampaigns;  

  UnjoinedCampaign(this.points, this.joinedCampaigns);
}

class CompleteAction {
  final CampaignAction action;
  final User user;
  final Function onSuccess;

  CompleteAction(this.action, this.user, this.onSuccess);
}

class RejectAction {
  final CampaignAction action;
  final String reason;
  RejectAction(this.action, this.reason);
}

class CreateNewUser {
  final User user;
  CreateNewUser(this.user);
}
class UpdateUserDetails {
  final User user;
  UpdateUserDetails(this.user);
}
class UpdatedUserDetails {
  final User user;
  UpdatedUserDetails(this.user);
}

class GetCampaignsAction {}

class LoadedCampaignsAction {
  final Campaigns campaigns;

  LoadedCampaignsAction(this.campaigns);
}

//class FetchInitState {}
class GetDynamicLink {}

class GetUserDataAction {}

class LoadedUserDataAction {
  final User user;
  LoadedUserDataAction(this.user);
}

// User Actions
class StartLoadingUserAction {}
class LoginSuccessAction {
  final User user; 
  LoginSuccessAction(this.user);
}
class LoginFailedAction {}

class SendingAuthEmail {}
class SentAuthEmail {
  final String email;
  SentAuthEmail(this.email);
}

// Logic called on startup 
class StartUp {}

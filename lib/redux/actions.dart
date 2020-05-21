import 'package:app/models/User.dart';
import 'package:app/models/Action.dart';
import 'package:app/models/Campaigns.dart';
import 'package:firebase_auth/firebase_auth.dart';

class InitaliseState {}

class InitalisedState {
  InitalisedState();
}

class SelectCampaignsAction {
  final User user;
  final Function onSuccess;

  SelectCampaignsAction(this.user, this.onSuccess);
}

class CompleteAction {
  final CampaignAction action;

  CompleteAction(this.action);
}

class UpdateUserDetails {
  final User user;

  UpdateUserDetails(this.user);
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
  final FirebaseUser firebaseUser; 
  LoginSuccessAction(this.firebaseUser);
}
class LoginFailedAction {}

class SendingAuthEmail {}
class SentAuthEmail {
  final String email;
  SentAuthEmail(this.email);
}

// Logic called on startup 
class StartUp {}

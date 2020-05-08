import 'package:app/models/User.dart';
import 'package:app/models/Action.dart';
import 'package:app/models/Campaigns.dart';

class SelectCampaignsAction {
  final User user;

  SelectCampaignsAction(this.user);
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

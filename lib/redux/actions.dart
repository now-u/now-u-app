import 'package:app/models/User.dart';

class SelectCampaignsAction {
  final User user;

  SelectCampaignsAction(this.user);
}

//class GetCampaingsAction {}

//class LoadedCampaignsAction {
//  final List<Campaign> campaigns;
//
//  LoadedCampaignsAction(this.campaigns);
//}

class GetUserDataAction {}

class LoadedUserDataAction {
  final User user;

  LoadedUserDataAction(this.user);
}

import 'package:app/models/Campaign.dart';

class SelectCampaignsAction {
  final List<Campaign> campaigns;

  SelectCampaignsAction(this.campaigns);
}

class GetCampaingsAction {}

class LoadedCampaignsAction {
  final List<Campaign> campaigns;

  LoadedCampaignsAction(this.campaigns);
}

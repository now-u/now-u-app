import 'package:app/models/Campaign.dart';
import 'package:app/models/Action.dart';

class Campaigns {
  List<Campaign> campaigns;

  Campaigns(this.campaigns);

  List<Campaign> getCampaigns() {
    return campaigns; 
  }

  //TODO implement
  List<CampaignAction> getActions() {
    return campaigns[0].getActions();
  }
}

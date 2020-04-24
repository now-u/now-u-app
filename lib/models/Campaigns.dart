import 'package:app/models/Campaign.dart';
import 'package:app/models/Action.dart';
import 'package:app/models/User.dart';

class Campaigns {
  List<Campaign> activeCampaigns;

  Campaigns(this.activeCampaigns);

  List<Campaign> getActiveCampaigns() {
    return activeCampaigns; 
  }

  //TODO shuffle/ return in sesible order
  List<CampaignAction> getActions() {
    List<CampaignAction> actions = [];
    for (int i =0; i < activeCampaigns.length; i++) {
      actions.addAll(activeCampaigns[i].getActions()); 
    }
    return actions;
  }

  int activeLength () {
    return activeCampaigns.length;
  }
}

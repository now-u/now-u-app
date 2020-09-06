import 'package:app/viewmodels/base_model.dart';
import 'package:app/viewmodels/base_campaign_model.dart';

import 'package:app/models/Campaign.dart';

import 'package:app/locator.dart';
import 'package:app/services/campaign_service.dart';

class HomeViewModel extends BaseCampaignViewModel {

  final CampaignService _campaignsService = locator<CampaignService>();
  
  List<Campaign> get campaigns => _campaignsService.campaigns;

  List<Campaign> get campaignsWithSelectedFirst {
    if (currentUser == null) {
      return _campaignsService.campaigns;
    }

    List<Campaign> selectedCs = currentUser.filterSelectedCampaigns(_campaignsService.campaigns);
    List<Campaign> unselectedCs = currentUser.filterUnselectedCampaigns(_campaignsService.campaigns);
    
    // Give some spice to your life
    selectedCs.shuffle();
    unselectedCs.shuffle();

    // Create the new ordered array
    List<Campaign> orderedCampaigns = [];
    orderedCampaigns.addAll(selectedCs);
    orderedCampaigns.addAll(unselectedCs);

    return orderedCampaigns;
  }

  // getSelectedCampaigns
  List<Campaign> get selectedCampaigns {
    return currentUser.filterSelectedCampaigns(_campaignsService.campaigns);
  }
  int get numberOfJoinedCampaigns {
    return currentUser.getSelectedCampaigns().length;
  }
  
  // getCompletedActions
  int get numberOfCompletedActions {
    return currentUser.getCompletedActions().length;
  }

  // getActiveStarredActions
  int get numberOfStarredActions {
    return currentUser.getStarredActions().length;
  }

  // getNotifications
  Future getNotifications() async {
    return [];
  }
}

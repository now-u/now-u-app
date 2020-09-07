import 'package:app/viewmodels/base_model.dart'; 

import 'package:app/models/Campaign.dart';

import 'package:app/locator.dart';
import 'package:app/services/campaign_service.dart';

mixin CampaignRO on BaseModel {
  final CampaignService _campaignsService = locator<CampaignService>();
  
  // Pull the latest campaigns from the db
  void pullCampaings() async {
    setBusy(true);
    await _campaignsService.fetchCampaigns();
    setBusy(false);
    notifyListeners();
  }
  
  // getSelectedCampaigns
  List<Campaign> get selectedCampaigns {
    return currentUser.filterSelectedCampaigns(_campaignsService.campaigns);
  }
  
  // Get campaigns
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
}

class BaseCampaignViewModel extends BaseModel with CampaignRO {
}

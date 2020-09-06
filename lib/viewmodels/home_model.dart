import 'package:app/viewmodels/base_model.dart';

import 'package:app/models/Campaign.dart';
import 'package:app/models/Campaigns.dart';

import 'package:app/locator.dart';
import 'package:app/services/campaign_service.dart';

class HomeViewModel extends BaseModel {

  final CampaignService _campaignsService = locator<CampaignService>();
  
  List<Campaign> _campaigns = [];

  List<Campaign> get campaigns => _campaigns;

  List<Campaign> get campaignsWithSelectedFirst {
    if (currentUser == null) {
      return _campaigns;
    }

    List<Campaign> selectedCs = currentUser.filterSelectedCampaigns(_campaigns);
    List<Campaign> unselectedCs = currentUser.filterUnselectedCampaigns(campaigns);
    
    // Give some spice to your life
    selectedCs.shuffle();
    unselectedCs.shuffle();

    // Create the new ordered array
    List<Campaign> orderedCampaigns = [];
    orderedCampaigns.addAll(selectedCs);
    orderedCampaigns.addAll(unselectedCs);

    return orderedCampaigns;
  }

  // Pull the latest campaigns from the db
  void pullCampaings() async {
    setBusy(true);
    Campaigns updatedCampaigns = await _campaignsService.getCampaigns().catchError(
      (e) {
        // DO SOMETHING TO INDICATE ERROR
        setBusy(false);
        return;
      }
    );
    _campaigns = updatedCampaigns.getActiveCampaigns();
    setBusy(false);
    notifyListeners();
  } 

  // getSelectedCampaigns
  List<Campaign> get selectedCampaigns {
    return currentUser.filterSelectedCampaigns(_campaigns);
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

import 'package:app/viewmodels/base_model.dart';

import 'package:app/locator.dart';
import 'package:app/routes.dart';
import 'package:app/services/campaign_service.dart';
import 'package:app/services/navigation.dart';

import 'package:app/models/Campaign.dart';

class CampaignInfoViewModel extends BaseModel {

  final CampaignService _campaignService = locator<CampaignService>();
  final NavigationService _navigationService = locator<NavigationService>();

  Campaign _campaign;
  Campaign get campaign => _campaign;
  set setCampaign(Campaign campaign) => _campaign = campaign;
  
  Future fetchCampaign(int campaignId) async {
    try {
      _campaign = await _campaignService.getCampaign(campaignId);
      notifyListeners();
    } catch(e) {
      // Some error things (campaign 404)
      _navigationService.navigateTo(Routes.allCampaigns);
    }
  }
}

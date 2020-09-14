import 'package:app/viewmodels/base_model.dart';

import 'package:app/locator.dart';
import 'package:app/services/campaign_service.dart';

import 'package:app/models/Campaign.dart';

class CampaignsAllViewModel extends BaseModel {
  final CampaignService _campaignService = locator<CampaignService>();
  List<Campaign> _pastCampaigns = [];
  List<Campaign> get currentCampaigns {
    return _campaignService.campaigns;
  }

  List<Campaign> get pastCampaigns => _pastCampaigns;

  Future fetchPastCampaigns() async {
    setBusy(true);
    _pastCampaigns = await _campaignService.getPastCampaigns();
    setBusy(false);
    notifyListeners();
  }

  Future fetchCurrentCampaigns() async {
    setBusy(true);
    await _campaignService.fetchCampaigns();
    setBusy(false);
    notifyListeners();
  }

  void fetchAllCampaigns() async {
    await fetchCurrentCampaigns();
    await fetchPastCampaigns();
  }
}

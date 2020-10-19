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
  /// fetches campaigns even without the user being logged in
  ///
  /// It basically does two things
  /// 1.Its tells the campaigns service to update the campaigns it has ( the service does this by getting the current campaigns from the api)
  /// 2.And its updated the past campaigns stored in the view model by getting then from the campaign service
  void fetchAllCampaigns() async {
    await fetchCurrentCampaigns();
    await fetchPastCampaigns();
  }
}

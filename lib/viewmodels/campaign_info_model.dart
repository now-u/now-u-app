import 'package:nowu/services/causes_service.dart';
import 'package:nowu/viewmodels/base_model.dart';

import 'package:nowu/locator.dart';
import 'package:nowu/services/navigation_service.dart';

import 'package:nowu/models/Campaign.dart';
import 'package:nowu/models/SDG.dart';

class CampaignInfoViewModel extends BaseModel {
  final CausesService _causesService = locator<CausesService>();
  final NavigationService _navigationService = locator<NavigationService>();

  Campaign? _campaign;
  Campaign? get campaign => _campaign;
  set setCampaign(Campaign? campaign) => _campaign = campaign;

  Future fetchCampaign(int campaignId) async {
    _campaign = await _causesService.getCampaign(campaignId);
    notifyListeners();
  }

  void openSDGGoals({SDG? sdg}) {
    if (sdg != null) {
      _navigationService.launchLink(sdg.getLink()!);
    } else {
      _navigationService.launchLink("https://sustainabledevelopment.un.org");
    }
  }

  void viewCampaignVideo(Campaign campaign) {
    _navigationService.launchLink(campaign.videoLink);
  }
}

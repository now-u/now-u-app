import 'package:app/viewmodels/base_model.dart';
import 'package:app/viewmodels/base_campaign_model.dart';

import 'package:app/locator.dart';
import 'package:app/services/campaign_service.dart';
import 'package:app/services/navigation_service.dart';

import 'package:app/models/Campaign.dart';
import 'package:app/models/SDG.dart';

class CampaignInfoViewModel extends BaseModel with CampaignWrite {
  final CampaignService? _campaignService = locator<CampaignService>();
  final NavigationService? _navigationService = locator<NavigationService>();

  Campaign? _campaign;
  Campaign? get campaign => _campaign;
  bool get campaignIsJoined =>
      currentUser!.getSelectedCampaigns().contains(_campaign!.id);
  set setCampaign(Campaign? campaign) => _campaign = campaign;

  Future fetchCampaign(int? campaignId) async {
    _campaign = await (_campaignService!.getCampaign(campaignId) as Future<Campaign?>);
    notifyListeners();
  }

  void openSDGGoals({SDG? sdg}) {
    if (sdg != null) {
      _navigationService!.launchLink(sdg.getLink()!);
    } else {
      _navigationService!.launchLink("https://sustainabledevelopment.un.org");
    }
  }

  void viewCampaignVideo(Campaign campaign) {
    _navigationService!.launchLink(campaign.videoLink!);
  }
}

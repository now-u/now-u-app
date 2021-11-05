import 'package:app/viewmodels/base_model.dart';

import 'package:app/models/Campaign.dart';

import 'package:app/locator.dart';
import 'package:app/services/campaign_service.dart';
import 'package:app/services/auth.dart';

mixin CampaignRO on BaseModel {
  final CampaignService? _campaignsService = locator<CampaignService>();

  // Pull the latest campaigns from the db
  void fetchCampaigns() async {
    setBusy(true);
    await _campaignsService!.fetchCampaigns();
    setBusy(false);
    notifyListeners();
  }

  // getSelectedCampaigns
  List<Campaign> get selectedCampaigns {
    return currentUser!.filterSelectedCampaigns(_campaignsService!.campaigns!);
  }

  List<Campaign> get selectedActiveCampaigns {
    return currentUser!.filterSelectedCampaigns(_campaignsService!.campaigns!);
  }

  // Get campaigns
  List<Campaign>? get campaigns => _campaignsService!.campaigns;

  List<Campaign>? get campaignsWithSelectedFirst {
    if (currentUser == null) {
      return _campaignsService!.campaigns;
    }

    List<Campaign> selectedCs =
        currentUser!.filterSelectedCampaigns(_campaignsService!.campaigns!);
    List<Campaign> unselectedCs =
        currentUser!.filterUnselectedCampaigns(_campaignsService!.campaigns!);

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

mixin CampaignWrite on BaseModel {
  final AuthenticationService? _authenticationService =
      locator<AuthenticationService>();

  Future joinCampaign(int? id) async {
    setBusy(true);
    await _authenticationService!.joinCampaign(id);
    setBusy(false);
    notifyListeners();
  }

  Future leaveCampaign(int id) async {
    setBusy(true);
    await _authenticationService!.leaveCampaign(id);
    setBusy(false);
    notifyListeners();
  }

  bool isJoined(int? id) {
    return _authenticationService!.currentUser!
        .getSelectedCampaigns()
        .contains(id);
  }
}

class BaseCampaignViewModel extends BaseModel with CampaignRO {}

class BaseCampaignWriteViewModel extends BaseModel
    with CampaignRO, CampaignWrite {}

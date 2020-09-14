import 'package:app/viewmodels/base_model.dart';

import 'package:app/locator.dart';
import 'package:app/services/campaign_service.dart';

import 'package:app/models/Organisation.dart';

class PartnersViewModel extends BaseModel {
  final CampaignService _campaignService = locator<CampaignService>();
  List<Organisation> _parterns = [];
  List<Organisation> get parterns => _parterns;

  void fetchPartners() async {
    setBusy(true);
    _parterns = await _campaignService.getPartners();
    setBusy(false);
    notifyListeners();
  }
}

import 'package:nowu/locator.dart';
import 'package:nowu/models/Campaign.dart';
import 'package:nowu/services/causes_service.dart';
import 'package:nowu/services/navigation_service.dart';
import 'package:nowu/viewmodels/base_model.dart';

class CampaignViewModel extends BaseModel {
  final _causesService = locator<CausesService>();
  final _navigationService = locator<NavigationService>();

  ListCampaign _listCampaign;
  Campaign? _campaign;
  Campaign? get campaign => _campaign;
  ListCampaign get listCampaign => campaign ?? _listCampaign;

  CampaignViewModel(ListCampaign listCampaign)
      : this._listCampaign = listCampaign;

  void init() {
    fetchCampaign();
  }

  void fetchCampaign() async {
    this._campaign = await _causesService.getCampaign(this._listCampaign.id);
    notifyListeners();
  }

  void back() {
    _navigationService.goBack();
  }
}

import 'package:app/locator.dart';
import 'package:app/models/Campaign.dart';
import 'package:app/services/causes_service.dart';
import 'package:app/services/navigation_service.dart';
import 'package:app/viewmodels/base_model.dart';

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
import 'package:nowu/locator.dart';
import 'package:nowu/services/causes_service.dart';
import 'package:nowu/services/navigation_service.dart';
import 'package:nowu/viewmodels/base_model.dart';

class CampaignViewModel extends BaseModel {
  final _causesService = locator<CausesService>();
  final _navigationService = locator<NavigationService>();

  ListCampaign _listCampaign;
  Campaign? _campaign;
  Campaign? get campaign => _campaign;
  // TODO Fix, how and why is this used? => We should always be using the above if its defined. Previously
  // they extended each other which helped
  ListCampaign get listCampaign => _listCampaign;

  CampaignViewModel(ListCampaign listCampaign)
      : this._listCampaign = listCampaign;

  void init() {
    fetchCampaign();
  }

  void fetchCampaign() async {
    this._campaign = await _causesService.getCampaign(this._listCampaign.id);
    notifyListeners();
  }
	
  bool actionIsComplete(int actionId) {
	return _causesService.actionIsComplete(actionId);
  }
  
  bool learningResourceIsComplete(int learningResourceId) {
	return _causesService.learningResourceIsComplete(learningResourceId);
  }

  void back() {
    _navigationService.goBack();
  }
}

import 'package:nowu/app/app.locator.dart';
import 'package:nowu/services/causes_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class CampaignViewModel extends BaseViewModel {
  final _causesService = locator<CausesService>();
  final _routerService = locator<NavigationService>();

  ListCampaign _listCampaign;
  Campaign? _campaign;

  Campaign? get campaign => _campaign;

  // TODO Fix, how and why is this used? => We should always be using the above if its defined. Previously
  // they extended each other which helped
  // TODO If not using list campaign then just use FutureViewModel
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

  bool? actionIsComplete(int actionId) {
    return _causesService.actionIsComplete(actionId);
  }

  bool? learningResourceIsComplete(int learningResourceId) {
    return _causesService.learningResourceIsComplete(learningResourceId);
  }

  void openLearningResource(LearningResource learningResource) {
    // TODO Look into stream services (which can notify their listens when a resource is completed)
    // _causesService
    //     .completeLearningResource(learningResource.id)
    //     .then((value) => notifyListeners());
    _causesService
        .openLearningResource(learningResource)
        .then((value) => notifyListeners());
  }

  void openAction(ListAction action) {
    _causesService.openAction(action.id);
  }

  void back() {
    _routerService.back();
  }
}

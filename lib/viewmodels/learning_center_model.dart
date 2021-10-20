import 'package:app/viewmodels/base_campaign_model.dart';

import 'package:app/locator.dart';
import 'package:app/services/campaign_service.dart';

import 'package:app/models/Learning.dart';

class LearningCenterViewModel extends BaseCampaignViewModel {
  final CampaignService? _campaignService = locator<CampaignService>();

  LearningCentre? _learningCenter;
  LearningCentre? get learningCenter => _learningCenter;
  List<LearningTopic>? get learningTopics {
    if (learningCenter == null) {
      return [];
    }
    return learningCenter!.getLearningTopics();
  }

  fetchLearningCentre(int id) async {
    setBusy(true);
    _learningCenter = await (_campaignService!.getLearningCentre(id) as FutureOr<LearningCentre?>);
    setBusy(false);
    notifyListeners();
  }
}

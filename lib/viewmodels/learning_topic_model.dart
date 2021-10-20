import 'package:app/viewmodels/base_campaign_model.dart';

import 'package:app/locator.dart';
import 'package:app/services/auth.dart';

class LearningTopicViewModel extends BaseCampaignViewModel {
  final AuthenticationService? _authenticationService =
      locator<AuthenticationService>();

  Future completeLearningResource(int? id) async {
    setBusy(true);
    await _authenticationService!.completeLearningResource(id);
    setBusy(false);
    notifyListeners();
  }

  bool learningResourceIsCompleted(int? id) {
    return currentUser!.getCompletedLearningResources()!.contains(id);
  }
}

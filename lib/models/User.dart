import 'package:causeApiClient/causeApiClient.dart' as Api;

extension UserProfileExtension on Api.UserProfile {
  // TODO Find out why user name can be empty string - that should be impossible at server level
  bool get isInitialised => name != null && name != '';
}

class CausesUser {
  bool get isInitialised => selectedCausesIds.isNotEmpty;

  Set<int> selectedCausesIds;
  Set<int> completedActionIds;
  Set<int> completedCampaignIds;
  Set<int> completedLearningResourceIds;

  CausesUser({
    required this.selectedCausesIds,
    required this.completedActionIds,
    required this.completedCampaignIds,
    required this.completedLearningResourceIds,
  });

  CausesUser.fromApiModel(Api.CausesUser apiModel)
      : selectedCausesIds = apiModel.selectedCausesIds.toSet(),
        completedActionIds = apiModel.completedActionIds.toSet(),
        completedCampaignIds = apiModel.completedCampaignIds.toSet(),
        completedLearningResourceIds =
            apiModel.completedLearningResourceIds.toSet();
}

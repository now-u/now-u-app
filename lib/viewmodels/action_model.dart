import 'package:app/viewmodels/base_campaign_model.dart';

import 'package:app/locator.dart';
import 'package:app/services/campaign_service.dart';

import 'package:app/models/Campaign.dart';
import 'package:app/models/Action.dart';

class ActionViewModel extends BaseCampaignViewModel {
  
  final CampaignService _campaignsService = locator<CampaignService>();
  
  List<CampaignAction> getActions(
      Campaign campaign, Map<String, Map> selections) {
    List<CampaignAction> tmpActions = [];
    if (campaign == null) {
      return tmpActions;
    }
    //tmpActions.addAll(campaign.getActions());
    bool includeCompleted = selections['extras']['completed'];
    bool includeRejected = selections['extras']['rejected'];
    bool includeToDo = selections['extras']['todo'];
    bool includeStarred = selections['extras']['starred'];
    // Get all the actions
    tmpActions.addAll(_campaignsService.getActiveActions(
        includeCompleted: includeCompleted,
        includeRejected: includeRejected,
        includeTodo: includeToDo,
        includeStarred: includeStarred));
    // Filter them for the campaign
    tmpActions.removeWhere((a) => !campaign.getActions().contains(a));
    if (hasSelected(selections['times'])) {
      // Remove the ones with the wrong times
      tmpActions.removeWhere((a) => !selections['times'][a.getTimeText()]);
    }
    if (hasSelected(selections['categories'])) {
      // Remove the ones with the wrong categories
      tmpActions.removeWhere((a) => !selections['categories'][a.getSuperType()]);
    }
    return tmpActions;
  }

  bool hasSelected(Map sel) {
    // If any of the values are true then at least one is selected
    for (final value in sel.values) {
      print("Checking value");
      if (value) {
        print("true value");
        return true;
      }
    }
    // Otherwise we dont care about this filter
    return false;
  }
   
}

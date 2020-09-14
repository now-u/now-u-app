import 'package:app/viewmodels/base_campaign_model.dart';

import 'package:app/locator.dart';
import 'package:app/services/campaign_service.dart';

import 'package:app/models/Campaign.dart';
import 'package:app/models/Action.dart';

class ActionViewModel extends BaseCampaignViewModel {
  
  final CampaignService _campaignsService = locator<CampaignService>();
  
  Map<String, Map> _selections = {
    "times": {},
    "campaigns": {},
    "categories": {},
    "extras": {
      "todo": true,
      "completed": false,
      "rejected": false,
      "starred": true,
    }
  };
  Map<String, Map> get selections => _selections;
  void updateSelections(String key1, String key2, value) {
    selections[key1][key2] = value;
    notifyListeners();
  }
  set setSelections(Map<String, Map> selections) => _selections = selections ?? _selections;

  List<CampaignAction> _actions = [];
  List<CampaignAction> get actions => _actions;
  
  Campaign _campaign;
  Campaign get campaign => _campaign;
  set campaign(Campaign c) { 
    _campaign = c;
    getActions();
  }
  set campaignIndex(int index) {
    if (index == currentUser.getSelectedCampaigns().length) {
      _campaign = null;
    } else {
      _campaign = currentUser.filterSelectedCampaigns(_campaignsService.campaigns)[index];
      getActions();
    }
  }

  initSelections() {
    _campaign = selectedCampaigns.length == 0 ? null : selectedCampaigns[0];
    getActions();

    for (int i = 0; i < timeBrackets.length; i++) {
      _selections['times'][timeBrackets[i]['text']] = false;
    }
    for (int i = 0; i < CampaignActionSuperType.values.length; i++) {
      _selections['categories'][CampaignActionSuperType.values[i]] = false;
    }
  }

  void getActions() {

    if (campaign == null) {
      _actions = [];
    }

    List<CampaignAction> tmpActions = [];
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
      includeStarred: includeStarred)
    );
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

    _actions = tmpActions;
    notifyListeners();
  }

  bool hasSelected(Map sel) {
    // If any of the values are true then at least one is selected
    for (final value in sel.values) {
      if (value) {
        return true;
      }
    }
    // Otherwise we dont care about this filter
    return false;
  }

  void setSelectedToAll() {
    _selections['extras']['starred'] =
        true;
    _selections['extras']['todo'] = true;
    _selections['extras']['rejected'] =
        false;
    _selections['extras']['completed'] =
        false;

    getActions();
  }
  bool selectionIsAll() {
    return selections['extras']['todo'] &&
        selections['extras']['starred'] &&
        !selections['extras']['rejected'] &&
        !selections['extras']['completed'];
  }
  
  void setSelectedToTodo() {
    selections['extras']['starred'] =
        true;
    selections['extras']['todo'] = false;
    selections['extras']['rejected'] =
        false;
    selections['extras']['completed'] =
        false;
    
    getActions();
  }
  bool selectionIsTodo() {
    return !selections['extras']['todo'] &&
      selections['extras']['starred'] &&
      !selections['extras']['rejected'] &&
      !selections['extras']['completed'];
  }

  void setSelectedToCompleted() {
    selections['extras']['starred'] =
        false;
    selections['extras']['todo'] = false;
    selections['extras']['rejected'] =
        false;
    selections['extras']['completed'] =
        true;
    
    getActions();
  }
  bool isSelectionCompleted() {
    return !selections['extras']['todo'] &&
        !selections['extras']['starred'] &&
        !selections['extras']['rejected'] &&
        selections['extras']['completed'];
  }
   
}

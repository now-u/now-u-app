import 'package:app/viewmodels/base_campaign_model.dart';

class HomeViewModel extends BaseCampaignViewModel {

  int get numberOfJoinedCampaigns {
    return currentUser.getSelectedCampaigns().length;
  }
  
  // getCompletedActions
  int get numberOfCompletedActions {
    return currentUser.getCompletedActions().length;
  }

  // getActiveStarredActions
  int get numberOfStarredActions {
    return currentUser.getStarredActions().length;
  }

  // getNotifications
  Future getNotifications() async {
    return [];
  }
}

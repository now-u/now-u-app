import 'package:app/redux/actions.dart';
import 'package:app/models/State.dart';
import 'package:app/models/Campaign.dart';

AppState appStateReducer(AppState state, action) {
  return AppState(
    campaigns: campaignReducer(state.campaigns, action),
  );
}

List<Campaign> campaignReducer(List<Campaign> campaigns, action) {
  switch (action) {
    case SelectCampaignsAction: {
      print(action.campaings[0]);
      print(action.campaings[1]);
      print(action.campaings[2]);
      return action.campaings;
     //return campaigns.map((cam) => cam.getId() == action.campaign.getId() ? cam.setSelected(!cam.isSelected()) : cam);
    } 
    
    default: {
      return campaigns;
    }
  }

}

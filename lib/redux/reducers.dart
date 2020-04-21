import 'package:app/redux/actions.dart';
import 'package:app/models/State.dart';
import 'package:app/models/User.dart';

AppState appStateReducer(AppState state, action) {
  return AppState(
    campaigns: state.campaigns,
    user: userReducer(state.user, action),
  );
}

User userReducer(User user, action) {
  //switch (action) {
  //  case SelectCampaignsAction: {
  //    print("Its doing the slect campiangs action");
  //    print(action.campaings[0]);
  //    print(action.campaings[1]);
  //    print(action.campaings[2]);
  //    return action.campaings;
  //   //return campaigns.map((cam) => cam.getId() == action.campaign.getId() ? cam.setSelected(!cam.isSelected()) : cam);
  //  } 

  //  case LoadedCampaignsAction: {
  //    print("Prinitng from loaded Camapings action");
  //    print(action.campaigns);
  //    print(action.campaigns[0].isSelected());
  //    print("done");
  //    return action.campaigns;
  //  }
  //  
  //  default: {
  //    return campaigns;
  //  }
  //}
  if (action is SelectCampaignsAction) {
    return action.user; 
  }
  if (action is LoadedUserDataAction) {
    return action.user;
  }
  return user;

}

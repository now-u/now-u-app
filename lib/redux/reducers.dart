import 'package:app/redux/actions.dart';
import 'package:app/redux/middleware.dart';
import 'package:app/models/State.dart';
import 'package:app/models/User.dart';
import 'package:app/models/Campaigns.dart';

AppState appStateReducer(AppState state, action) {
  return AppState(
    campaigns: state.campaigns,
    user: userReducer(state.user, action),
    loading: loadingReducer(action) ?? state.loading,
    api: state.api,
  );
}

bool loadingReducer (action) {
  //if(action is LoadedUserDataAction) {
  //  return false;
  //}
  if(action is LoadedCampaignsAction) {
    return false;
  }
  if (action is InitalisedState) {
    return false; 
  }
  return null;
}

Campaigns campaignsReducer(Campaigns campaigns, action) {
  if (action is LoadedCampaignsAction) {
    print("The user that has been loaded is");
    print(action.campaigns.getActiveCampaigns().length);
    return action.campaigns;
  }
  return campaigns;
}

User userReducer(User user, action) {
  if (action is SelectCampaignsAction) {
    return action.user; 
  }
  if (action is CompleteAction) {
    User u = user.copyWith();
    print("Completing action");
    u.completeAction(action.action);
    print("Action completed");
    print(u.getCompletedActions());
    return u;
  }
  if (action is LoadedUserDataAction) {
    print("The user that has been loaded is");
    print(action.user.getName());
    return action.user;
  }
  if (action is UpdateUserDetails) {
    User u = user.copyWith(
      fullName: action.user.getName(),
      email: action.user.getEmail(),
      age: action.user.getAge(),
      location: action.user.getLocation(),
    );
    print("User in UpdateUserDetails is");
    print("UserName is ${ u.getName() }");
    return u; 
  }
  return user;

}


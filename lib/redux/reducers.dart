import 'package:app/redux/actions.dart';
import 'package:app/redux/middleware.dart';
import 'package:app/models/State.dart';
import 'package:app/models/User.dart';

AppState appStateReducer(AppState state, action) {
  return AppState(
    campaigns: state.campaigns,
    user: userReducer(state.user, action),
  );
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
    print(action.user.getCompletedActions());
    return action.user;
  }
  return user;

}

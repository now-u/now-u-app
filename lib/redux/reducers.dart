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
  if (action is SelectCampaignsAction) {
    return action.user; 
  }
  if (action is CompleteAction) {
    User user = action.user;
    user.completeAction(action.action);
    return user;
  }
  if (action is LoadedUserDataAction) {
    return action.user;
  }
  return user;

}

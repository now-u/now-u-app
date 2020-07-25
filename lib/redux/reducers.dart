import 'package:app/redux/actions.dart';
import 'package:app/redux/middleware.dart';
import 'package:app/models/State.dart';
import 'package:app/models/User.dart';
import 'package:app/models/Campaigns.dart';
import 'package:time/time.dart';

import 'package:redux/redux.dart';

AppState appStateReducer(AppState state, action) {
  return AppState(
    campaigns: campaignsReducer(state.campaigns, action),
    userState: userStateReducer(state.userState, action),
    loading: loadingReducer(action) ?? state.loading,
    api: state.api,
    analytics: state.analytics,
  );
}

bool loadingReducer(action) {
  //if(action is LoadedUserDataAction) {
  //  return false;
  //}
  if (action is LoadedCampaignsAction) {
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

//UserState userStateReducer(UserState userState, action) {
//  return UserState(
//    user: userReducer(userState.user, action),
//    isLoading: userLoadingReducer(userState.isLoading, action),
//    loginError: false,
//  );
//}

final userStateReducer = combineReducers<UserState>([
  TypedReducer<UserState, LoginSuccessAction>(_loginSuccess),
  TypedReducer<UserState, LoginFailedAction>(_loginFailed),
  TypedReducer<UserState, StartLoadingUserAction>(_startLoading),
  TypedReducer<UserState, SendingAuthEmail>(_sendingAuthEmail),
  TypedReducer<UserState, SentAuthEmail>(_sentAuthEmail),
  TypedReducer<UserState, JoinedCampaign>(_joinedCampaign),
  TypedReducer<UserState, UnjoinedCampaign>(_unjoinedCampaign),
  TypedReducer<UserState, CompletedAction>(_completedAction),
  TypedReducer<UserState, RejectedAction>(_rejectedAction),
  TypedReducer<UserState, StarredAction>(_starredAction),
  TypedReducer<UserState, RemovedActionStatus>(_removedActionStatus),
  TypedReducer<UserState, LoadedUserDataAction>(_loadedUserData),
  TypedReducer<UserState, UpdatedUserDetails>(_updatedUserDetails),
  TypedReducer<UserState, CreateNewUser>(_createNewUser),
  TypedReducer<UserState, Logout>(_logout),
]);

UserState _loginSuccess(UserState state, LoginSuccessAction action) {
  return state.copyWith(user: action.user, isLoading: false, loginError: false);
}

UserState _loginFailed(UserState state, LoginFailedAction action) {
  return state.copyWith(user: null, isLoading: false, loginError: true);
}

UserState _startLoading(UserState state, StartLoadingUserAction action) {
  return state.copyWith(isLoading: true, loginError: false);
}

UserState _sentAuthEmail(UserState state, SentAuthEmail action) {
  return state.copyWith(
      user: null, isLoading: false, loginError: false, emailSent: true);
}

UserState _sendingAuthEmail(UserState state, SendingAuthEmail action) {
  return state.copyWith(isLoading: true, loginError: false, emailSent: false);
}

UserState _joinedCampaign(UserState state, JoinedCampaign action) {
  return state.copyWith(user: action.user);
}

UserState _unjoinedCampaign(UserState state, UnjoinedCampaign action) {
  User u = state.user.copyWith(
    points: action.points,
    selectedCampaigns: action.joinedCampaigns,
  );
  print("reduced unjoined campaign");
  return state.copyWith(user: u);
}

UserState _completedAction(UserState state, CompletedAction action) {
  return state.copyWith(user: action.user);
}

UserState _rejectedAction(UserState state, RejectedAction action) {
  return state.copyWith(user: action.user);
}

UserState _starredAction(UserState state, StarredAction action) {
  return state.copyWith(user: action.user);
}

UserState _removedActionStatus(UserState state, RemovedActionStatus action) {
  return state.copyWith(user: action.user);
}

UserState _loadedUserData(UserState state, LoadedUserDataAction action) {
  return state.copyWith(user: action.user);
}

UserState _updatedUserDetails(UserState state, UpdatedUserDetails action) {
  //User u = state.user.copyWith();
  //Map attributes = action.user.getAttributes();
  //print("Setting attributes");
  //for (int i = 0; i < attributes.keys.length; i++) {
  //  print("Setting value " + attributes.keys.toList()[i].toString() + " to " + attributes.values.toList()[i].toString());
  //  u.setAttribute(attributes.keys.toList()[i], attributes.values.toList()[i]);
  //}
  //print("Set attributes");
  return state.copyWith(user: action.user);
}

UserState _createNewUser(UserState state, CreateNewUser action) {
  return state.copyWith(user: action.user);
}

UserState _logout(UserState state, Logout action) {
  print("Setting user token to null");
  return state.copyWith(
      user: state.user.copyWith(
    token: "",
  ));
}

import 'package:app/redux/actions.dart';
import 'package:app/redux/middleware.dart';
import 'package:app/models/State.dart';
import 'package:app/models/User.dart';
import 'package:app/models/Campaigns.dart';

import 'package:redux/redux.dart';

AppState appStateReducer(AppState state, action) {
  return AppState(
    campaigns: state.campaigns,
    userState: userStateReducer(state.userState, action),
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
  TypedReducer<UserState, SelectCampaignsAction>(_selectCampaign),
  TypedReducer<UserState, CompleteAction>(_completeAction),
  TypedReducer<UserState, LoadedUserDataAction>(_loadedUserData),
  TypedReducer<UserState, UpdateUserDetails>(_updateUserDetails),
]);

UserState _loginSuccess(UserState state, LoginSuccessAction action) {
  // Add token to copy with
  //User u = state.user.copyWith(token: action.token);
  User u = state.user.copyWith(token: action.token);
  return state.copyWith(user: u, isLoading: false, loginError: false);
}

UserState _loginFailed(UserState state, LoginFailedAction action) {
  return state.copyWith(user: null, isLoading: false, loginError: true);
}

UserState _startLoading(UserState state, StartLoadingUserAction action) {
  return state.copyWith(isLoading: true, loginError: false);
}

UserState _sentAuthEmail(UserState state, SentAuthEmail action) {
  return state.copyWith(user: null, isLoading: false, loginError: false, emailSent: true);
}

UserState _sendingAuthEmail(UserState state, SendingAuthEmail action) {
  return state.copyWith(isLoading: true, loginError: false, emailSent: false);
}
UserState _selectCampaign(UserState state, SelectCampaignsAction action) {
  return state.copyWith(user: action.user);
}
UserState _completeAction(UserState state, CompleteAction action) {
    User u = state.user.copyWith();
    u.completeAction(action.action);
    return state.copyWith(user: u);
}
UserState _loadedUserData(UserState state, LoadedUserDataAction action) {
  return state.copyWith(user: action.user);
}
UserState _updateUserDetails(UserState state, UpdateUserDetails action) {
    User u = state.user.copyWith(
      fullName: action.user.getName(),
      email: action.user.getEmail(),
      age: action.user.getAge(),
      location: action.user.getLocation(),
    );
    return state.copyWith(user: u);
}


import 'package:app/redux/actions.dart';
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
    print('The user that has been loaded is');
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


User userReducer(User user, action) {
  if (action is SelectCampaignsAction) {
    return action.user; 
  }
  if (action is CompleteAction) {
    User u = user.copyWith();
    print('Completing action');
    u.completeAction(action.action);
    print('Action completed');
    print(u.getCompletedActions());
    return u;
  }
  if (action is LoadedUserDataAction) {
    print('The user that has been loaded is');
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
    print('User in UpdateUserDetails is');
    print('UserName is ${ u.getName() }');
    return u; 
  }
  return user;

}

final userStateReducer = combineReducers<UserState>([
  TypedReducer<UserState, LoginSuccessAction>(_loginSuccess),
  TypedReducer<UserState, LoginFailedAction>(_loginFailed),
  TypedReducer<UserState, StartLoadingUserAction>(_startLoading),
  TypedReducer<UserState, SendingAuthEmail>(_sendingAuthEmail),
  TypedReducer<UserState, SentAuthEmail>(_sentAuthEmail),
]);

UserState _loginSuccess(UserState state, LoginSuccessAction action) {
  User u = state.user.copyWith(firebaseUser: action.firebaseUser);
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

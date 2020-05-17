import 'dart:async';
import 'dart:convert';

import 'package:redux/redux.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:app/models/State.dart';
import 'package:app/models/User.dart';
import 'package:app/models/Campaigns.dart';
import 'package:app/redux/actions.dart';

void saveUserToPrefs(User u) async {
  print('Saving json to shared prefs');
  SharedPreferences preferences = await SharedPreferences.getInstance();
  var string = json.encode(u.toJson());
  await preferences.setString('user', string);
}

void saveCampaignsToPrefs(Campaigns cs) async {
  print('Saving Campaigns json to shared prefs');
  SharedPreferences preferences = await SharedPreferences.getInstance();
  var string = json.encode(cs.toJson());
  await preferences.setString('user', string);
}

Future<User> loadUserFromPrefs(User u) async {
  print('Loading User from shared prefs');
  final SharedPreferences preferences = await SharedPreferences.getInstance();
  var string = preferences.getString('user');
  print(string);
  
  if (string != null) {
    //print(string);
    //print('Decoding json from state');
    Map map = json.decode(string);
    //print('Decoded json');
    User u = User.fromJson(map);
    print('Loaded user from shared pref is');
    print(u.getName());
    print(u.completedActionsType);
    return u;
  }
  print('User.empty is being returned');
  return User.empty();
}

void appStateMiddleware (Store<AppState> store, action, NextDispatcher next) async {
  next(action);

  if (action is InitaliseState) {
     store.dispatch(GetCampaignsAction).then(() {
        store.dispatch(GetUserDataAction).then(
          store.dispatch(InitalisedState())
        );
      }
     );
  }
  
  if (action is SelectCampaignsAction) {
    saveUserToPrefs(store.state.userState.user);
  }
  if (action is UpdateUserDetails) {
    saveUserToPrefs(store.state.userState.user);
  }
  //if (action is GetCampaingsAction) {
  //  print('the middleware is happening for get Campaings');
  //  await loadFromPrefs().then((state) { 
  //        print('The state at the get Camapings middelware is');
  //        print(state.campaigns[0].isSelected());
  //        //TODO FIND OUT WHY THIS IS NEVER CALLED / DOESNT WORK
  //        print('Gonna do the dispatch');
  //        store.dispatch(LoadedCampaignsAction(state.campaigns)); 
  //        print('Thinks its done the loadedcampaignsaction');
  //        // It thinks its done the dispatch
  //      });
  //
  //if (action is FetchInitState) {
  //  await loadFromPrefs(store.state).then((state) { 
  //        print('The user being loaded is:');
  //        print(state.user.getName());
  //        store.dispatch(LoadedUserDataAction(state.user)); 
  //  });

  //}

  
  if (action is GetCampaignsAction) {
    await store.state.api.getCampaigns().then(
      (Campaigns cs) {
        print(cs.getActiveCampaigns());
        store.dispatch(LoadedCampaignsAction(cs));
      }, onError: (e, st) {
        print(e);
        return store.state.campaigns;
        //loadCampaignsFromPrefs()
      } 
    );
  }

  if (action is GetUserDataAction) {
    await loadUserFromPrefs(store.state.userState.user).then((user) { 
          print("The user being loaded is:");
          print(user.getName());
          store.dispatch(LoadedUserDataAction(user)); 
    });
  }
  if (action is CompleteAction) {
    print('In middleware of completed Action user is');
    print(store.state.userState.user.getCompletedActions());
    saveUserToPrefs(store.state.userState.user);
  }
  if (action is GetDynamicLink) {
  }
}

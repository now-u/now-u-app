import 'dart:async';
import 'dart:convert';

import 'package:redux/redux.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:app/models/State.dart';
import 'package:app/redux/actions.dart';

void saveToPrefs(AppState state) async {
  print("Saving json to shared prefs");
  SharedPreferences preferences = await SharedPreferences.getInstance();
  var string = json.encode(state.toJson());
  await preferences.setString('userState', string);
}

Future<AppState> loadFromPrefs(AppState state) async {
  print("Loading from shared prefs");
  final SharedPreferences preferences = await SharedPreferences.getInstance();
  var string = preferences.getString('userState');
  
  if (string != null) {
    print(string);
    print("Decoding json from state");
    Map map = json.decode(string);
    print("Decoded json");
    return AppState.fromJson(map, state);
  }
  return AppState.initialState();
}

void appStateMiddleware (Store<AppState> store, action, NextDispatcher next) async {
  next(action);
  
  if (action is SelectCampaignsAction) {
    saveToPrefs(store.state);
  }
  //if (action is GetCampaingsAction) {
  //  print("the middleware is happening for get Campaings");
  //  await loadFromPrefs().then((state) { 
  //        print("The state at the get Camapings middelware is");
  //        print(state.campaigns[0].isSelected());
  //        //TODO FIND OUT WHY THIS IS NEVER CALLED / DOESNT WORK
  //        print("Gonna do the dispatch");
  //        store.dispatch(LoadedCampaignsAction(state.campaigns)); 
  //        print("Thinks its done the loadedcampaignsaction");
  //        // It thinks its done the dispatch
  //      });
  //
  if (action is GetUserDataAction) {
    await loadFromPrefs(store.state).then((state) { 
          print("The user being loaded is:");
          print(state.user.getCompletedActions());
          store.dispatch(LoadedUserDataAction(state.user)); 
    });
  }
  if (action is CompleteAction) {
    print("In middleware of completed Action user is");
    print(store.state.user.getCompletedActions());
    saveToPrefs(store.state);
  }
}

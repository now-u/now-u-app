import 'dart:async';
import 'dart:convert';

import 'package:app/assets/routes/customRoute.dart';
import 'package:redux/redux.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:redux_thunk/redux_thunk.dart';

import 'package:app/models/State.dart';
import 'package:app/models/User.dart';
import 'package:app/models/Campaigns.dart';
import 'package:app/models/ViewModel.dart';
import 'package:app/redux/actions.dart';

import 'package:app/pages/login/emailSentPage.dart';

import 'package:app/main.dart';

Future<void> saveUserToPrefs(User u) async {
  print("Saving json to shared prefs");
  SharedPreferences preferences = await SharedPreferences.getInstance();
  var string = json.encode(u.toJson());
  await preferences.setString('user', string);
}

Future<void> saveCampaignsToPrefs(Campaigns cs) async {
  print("Saving Campaigns json to shared prefs");
  SharedPreferences preferences = await SharedPreferences.getInstance();
  var string = json.encode(cs.toJson());
  await preferences.setString('user', string);
}

Future<User> loadUserFromPrefs(User u) async {
  print("Loading User from shared prefs");
  final SharedPreferences preferences = await SharedPreferences.getInstance();
  var string = preferences.getString('user');
  print(string);
  
  if (string != null) {
    //print(string);
    //print("Decoding json from state");
    Map map = json.decode(string);
    //print("Decoded json");
    User u = User.fromJson(map);
    print("Loaded user from shared pref is");
    print(u.getName());
    print(u.completedActionsType);
    return u;
  }
  print("User.empty is being returned");
  // TODO this should be null
  return User.empty();
}

void appStateMiddleware (Store<AppState> store, action, NextDispatcher next) async {
  next(action);

  if (action is InitaliseState) {
  }
  
  if (action is SelectCampaignsAction) {
    saveUserToPrefs(store.state.userState.user).then(
      (dynamic d) {
        print("Campaign has been selected now running onSuccess");
        action.onSuccess(10, 40);
      }
    );
  }
  if (action is UpdateUserDetails) {
    saveUserToPrefs(store.state.userState.user);
  }
  
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
    print("In middleware of completed Action user is");
    print(store.state.userState.user.getCompletedActions());
    saveUserToPrefs(store.state.userState.user);
  }
  if (action is GetDynamicLink) {
  }
}

ThunkAction<AppState> emailUser (String email) {
  return (Store<AppState> store) async {
    Future (() async {
      print("In thunk action");
      print(store.state.userState.auth);
      store.state.userState.auth.sendSignInWithEmailLink(email).then((loginResponse) {
        print("Trying to send email");
        store.dispatch(SentAuthEmail(email));
        print("Trying to nav");
        Keys.navKey.currentState.push(
          CustomRoute(builder: (context) => EmailSentPage(UserViewModel.create(store), email))
        );
      }, onError: (error) {
        store.dispatch(new LoginFailedAction());
      });
    });
  };
}

ThunkAction loginUser (String email, String link) {
  return (Store store) async {
    Future (() async {
      store.dispatch(StartLoadingUserAction());
      store.state.userState.auth.signInWithEmailLink(email, link).then((loginResponse) {
        // TODO add token to LoginSuccessAction
        store.dispatch(LoginSuccessAction());
        Keys.navKey.currentState.pushNamed(Routes.intro);
      }, onError: (error) {
        store.dispatch(new LoginFailedAction());
      });
    });
  };
}

ThunkAction initStore (Uri deepLink) {
  print("DEEP LINK IN INIT | " + deepLink.toString());
  if (deepLink != null) {
    print("DEEP LINK PATH | " + deepLink.path);
    print("DEEP LINK PATH | " + deepLink.query);
  }
  return (Store store) async {
    Future (() async {
     print("We are initing");
     store.dispatch(GetUserDataAction()).then(
      (dynamic u) {
        store.dispatch(GetCampaignsAction()).then(
          (dynamic r) {
            // A user id of -1 means the user is the placeholder and therefore does not exist, well get rid of this eventually and keep it as null, but for now useful as when we go to homepage after login we have the placeholder user
            //if (store.state.userState.user == null || store.state.userState.user.getId() == -1) {
            // Skip Login Screen
            if (store.state.userState.user == null) {
              if (deepLink != null && deepLink.path == "/loginMobile") {
                print("The path is the thing");
                print(deepLink.path);
                store.state.userState.repository.getEmail().then((email) {
                  store.state.userState.auth.signInWithEmailLink(email, deepLink.queryParameters['token']).then((User r) {
                    print("Signed in ish");
                    //print(r.user.email);
                    //print(r.user.hashCode)
                    // TODO if new user 
                    // intro
                    Keys.navKey.currentState.pushNamed(Routes.intro);
                    // else home cause theyve already done the intro
                    // Keys.navKey.currentState.pushNamed(Routes.home);
                  });
                });
              } else {
                Keys.navKey.currentState.pushNamed(Routes.login);
              }
            }
            else {
              Keys.navKey.currentState.pushNamed(Routes.home);
            }
          }
        );
      }
     );
    });
  };
}


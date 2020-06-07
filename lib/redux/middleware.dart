import 'dart:async';
import 'dart:convert';
import 'package:get/get.dart';

import 'package:app/assets/routes/customRoute.dart';
import 'package:redux/redux.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:redux_thunk/redux_thunk.dart';

import 'package:app/models/State.dart';
import 'package:app/models/User.dart';
import 'package:app/models/Campaigns.dart';
import 'package:app/models/ViewModel.dart';
import 'package:app/models/Badge.dart';
import 'package:app/redux/actions.dart';

import 'package:app/assets/components/pointsNotifier.dart';

import 'package:app/pages/login/emailSentPage.dart';

import 'package:app/routes.dart';
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
  print("Returning null user is being returned");
  // TODO this should be null
  return null;
}

void appStateMiddleware (Store<AppState> store, action, NextDispatcher next) async {
  next(action);

  if (action is InitaliseState) {
  }

  if (action is JoinCampaign) {
    User responseUser = await store.state.userState.auth.joinCampaign(store.state.userState.user.getToken(), action.campaign.getId());
    store.dispatch(JoinedCampaign(
      responseUser.getPoints(),
      responseUser.getSelectedCampaigns(),
      action.onSuccess,
    ));
  }
  if (action is JoinedCampaign) {
    saveUserToPrefs(store.state.userState.user.copyWith(
      points: action.points,
      selectedCampaigns: action.joinedCampaigns,
            )).then(
      (dynamic d) {
        print("Campaign has been selected now running onSuccess");
        print("The user has ${store.state.userState.user.getPoints()} points");
        // If adding the 10 points earnt you a badge then dont do the thing
        if (getNextBadge(store.state.userState.user.getPoints()) == action.points) {
          action.onSuccess(10, getNextBadge(action.points), false);
        }
        // Instead to the popup
        else {
          action.onSuccess(10, getNextBadge(action.points), true);
        }
      }
    );
  }

  if (action is UpdateUserDetails) {
    User newUser = await store.state.userState.auth.updateUserDetails(
      action.user
    );

    // Update the users attributes to match those returned by the api
    Map attributes = newUser.getAttributes();
    for (int i = 0; i < attributes.keys.length; i++) {
      action.user.setAttribute(attributes.keys.toList()[i], attributes.values.toList()[i]);
    }

    // Save the user locally
    saveUserToPrefs(action.user);
  }
  
  if (action is LoginSuccessAction) {
    // This might be the old user
    print(store.state.userState.user);
    print(store.state.userState.user.getName());
    print("The logged in users token is");
    print(action.user.getToken());
    saveUserToPrefs(action.user);
  }
  
  if (action is GetCampaignsAction) {
    await store.state.api.getCampaigns().then(
      (Campaigns cs) {
        print(cs.getActiveCampaigns());
        store.dispatch(LoadedCampaignsAction(cs));
      }, onError: (e, st) {
        print(e);
        // TODO lol whats going on here
        return store.state.campaigns;
        //loadCampaignsFromPrefs()
      } 
    );
  }

  if (action is GetUserDataAction) {
    await loadUserFromPrefs(store.state.userState.user).then((user) { 
      store.dispatch(LoadedUserDataAction(user)); 
    });
  }

  if (action is CompleteAction) {
    print("In middleware of completed Action user is");
    print(store.state.userState.user.getCompletedActions());
    print(action.action.getId());
    if (store.state.userState.user.getCompletedActions().contains(action.action.getId())) {
      print("This action has already been completed");
      return;
    } 
    User responseUser = await store.state.userState.auth.completeAction(
      store.state.userState.user.getToken(),
      action.action.getId(),
    );
    print(store.state.userState.user.getCompletedActions());
    
    action.user.setPoints(
      responseUser.getPoints(),
    );

    List newlyCompletedActions = responseUser.getCompletedActions().where((a) => !store.state.userState.user.getCompletedActions().contains(a)).toList();
    for (int i = 0; i < newlyCompletedActions.length; i++ ) {
      action.user.completeAction(newlyCompletedActions[i]);
    }

    int newPoints = action.user.getPoints();
    int oldPoints = store.state.userState.user.getPoints();

    saveUserToPrefs(action.user).then((_) {
      if (getNextBadge(newPoints) > getNextBadge(oldPoints)) {
        // Do the new badge popup
        action.onSuccess(5, getNextBadge(newPoints), true);
      }
      else {
        // Do the points notifier
        action.onSuccess(5, getNextBadge(newPoints), false);
      }
      //action.onSuccess(5, getNextBadge(store.state.userState.user.getPoints()));
    //  if (getNextBadge(store.state.userState.user.getPoints()) == getNextBadge(store.state.userState.user.getPoints() + 5)) {
    //    action.onSuccess(5, getNextBadge(store.state.userState.user.getPoints()), false);
    //  }
    //  // Instead do the popup
    //  else {
    //    action.onSuccess(5, getNextBadge(store.state.userState.user.getPoints()), true);
    //  }
    }
    );
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
      User user = await store.state.userState.auth.signInWithEmailLink(email, link);

      print("The loging response here is");
      print(user);
      // TODO add token to LoginSuccessAction
      if (user != null) {
        store.dispatch(LoginSuccessAction(user));
          print("New user is ");
          print(user.getName());
          print(user.getToken());
          Keys.navKey.currentState.pushNamed(Routes.intro);
        }
      }
    );
  };
}

ThunkAction skipLoginAction () {
  return (Store store) async {
    Future (() async {
      User u = User.empty();
      u.setToken(null);
      store.dispatch(CreateNewUser(u)).then(
        (_) {
          Keys.navKey.currentState.pushNamed(Routes.intro);
        }
      );
      
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
            if (store.state.userState.user == null || store.state.userState.user.getToken() == null) {
            // Skip Login Screen
            //if (store.state.userState.user == null) {
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
              // Go home
              print("Going home");
              Keys.navKey.currentState.pushNamed(Routes.home);
            }
          }
        );
      }
     );
    });
  };
}


import 'dart:async';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:redux/redux.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:redux_thunk/redux_thunk.dart';

import 'package:app/models/State.dart';
import 'package:app/models/User.dart';
import 'package:app/models/Campaigns.dart';
import 'package:app/models/Campaign.dart';
import 'package:app/models/ViewModel.dart';
import 'package:app/models/Action.dart';
import 'package:app/models/Badge.dart';
import 'package:app/models/Reward.dart';
import 'package:app/models/Learning.dart';
import 'package:app/redux/actions.dart';

import 'package:app/services/auth.dart';
import 'package:app/services/analytics.dart';

import 'package:app/assets/components/pointsNotifier.dart';

import 'package:app/pages/login/emailSentPage.dart';
import 'package:app/pages/other/RewardComplete.dart';

import 'package:app/routes.dart';
import 'package:app/main.dart';

Future<void> saveUserToPrefs(User u) async {
  print("Saving json to shared prefs");
  SharedPreferences preferences = await SharedPreferences.getInstance();
  print("saved");
  var string = json.encode(u.toJson());
  print("saved 2");
  await preferences.setString('user', string);
  print("saved 3");
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

void appStateMiddleware(
    Store<AppState> store, action, NextDispatcher next) async {
  next(action);

  if (action is InitaliseState) {}

  if (action is UnjoinCampaign) {
    // TODO Here we are assuming the user is not attempting to unjoin a campaign that hasnt been joined (shouldnt be possible but probably worth checking

    User responseUser = await store.state.userState.auth.unjoinCampaign(
        store.state.userState.user.getToken(), action.campaign.getId());
    print("new user points ${responseUser.getPoints()}");

    store.state.analytics.logCampaignStatusUpdate(action.campaign, CampaignStatus.leave);

    store.dispatch(UnjoinedCampaign(
      responseUser.getPoints(),
      responseUser.getSelectedCampaigns(),
    ));
  }
  if (action is UnjoinedCampaign) {
    saveUserToPrefs(store.state.userState.user.copyWith(
      points: action.points,
      selectedCampaigns: action.joinedCampaigns,
    ));
  }

  if (action is UpdateUserDetails) {
    print("In update user details middleware");
    User newUser =
        await store.state.userState.auth.updateUserDetails(action.user);

    // Update the users attributes to match those returned by the api
    Map attributes = newUser.getAttributes();
    for (int i = 0; i < attributes.keys.length; i++) {
      print("Setting value " +
          attributes.keys.toList()[i].toString() +
          " to " +
          attributes.values.toList()[i].toString());
      action.user.setAttribute(
          attributes.keys.toList()[i], attributes.values.toList()[i]);
    }

    // Save the user locally
    saveUserToPrefs(action.user);
    store.dispatch(UpdatedUserDetails(action.user));
  }

  if (action is LoginSuccessAction) {
    // This might be the old user
    print("In Lgoin Success reducer");
    print(action.user);
    saveUserToPrefs(action.user);
    print("Completed reducer");
  }

  if (action is GetCampaignsAction) {
    await store.state.api.getCampaigns().then((Campaigns cs) {
      print("Getting campaigns");
      print(cs.getActiveCampaigns());
      store.dispatch(LoadedCampaignsAction(cs));
    }, onError: (e, st) {
      print(e);
      return store.state.campaigns;
    });
  }

  if (action is GetUserDataAction) {
    await loadUserFromPrefs(store.state.userState.user).then((user) {
      store.dispatch(LoadedUserDataAction(user));
    });
  }

  if (action is GetDynamicLink) {}

  if (action is RejectAction) {
    var responseUser = await store.state.userState.auth.rejectAction(
        store.state.userState.user.getToken(),
        action.action.getId(),
        action.reason);
    User newUser = store.state.userState.user.copyWith(
      points: responseUser.getPoints(),
      rejectedActions: responseUser.getRejectedActions(),
    );

    saveUserToPrefs(newUser).then((_) {
      store.dispatch(RejectedAction(newUser));
    });
  }

  if (action is Logout) {
    print("Updating user in shared pref with empty token");
    User u = store.state.userState.user.copyWith(
      token: "",
    );
    saveUserToPrefs(u).then((_) {
      Keys.navKey.currentState.pushNamed(Routes.login);
    });
  }
}

ThunkAction<AppState> joinCampaign(Campaign campaign, BuildContext context) {
  return (Store<AppState> store) async {
    Future(() async {
      if (store.state.userState.user
          .getSelectedCampaigns()
          .contains(campaign.getId())) {
        print("This campaigns has already been joined");
        return;
      }
      User responseUser = await store.state.userState.auth.joinCampaign(
          store.state.userState.user.getToken(), campaign.getId());

      print("new user points ${responseUser.getPoints()}");

      User newUser = store.state.userState.user.copyWith(
        points: responseUser.getPoints(),
        selectedCampaigns: responseUser.getSelectedCampaigns(),
      );
    
      store.state.analytics.logCampaignStatusUpdate(campaign, CampaignStatus.join);

      //viewModel.userModel.user.addSelectedCamaping(campaign.getId());
      int newPoints = newUser.getPoints();
      int oldPoints = store.state.userState.user.getPoints();

      print("Points");
      print(newPoints);
      print(oldPoints);

      saveUserToPrefs(newUser).then((_) {
        store.dispatch(JoinedCampaign(newUser));
        // If the users new next badge is different to their current badge
        // Then they must have earnt a new badge
        if (getNextBadge(newPoints) > getNextBadge(oldPoints)) {
          print("New badge");
          // Do the new badge popup
          // If you did get a new badge then show that popup
          gotBadgeNotifier(
            badge: getNextBadgeFromInt(oldPoints),
            context: context,
          );
        } else {
          pointsNotifier(newPoints, 10, getNextBadge(newPoints), context)
            ..show(context);
        }
      });
    });
  };
}

ThunkAction<AppState> starAction(CampaignAction action) {
  return (Store<AppState> store) async {
    Future(() async {
      if (store.state.userState.user
          .getStarredActions()
          .contains(action.getId())) {
        print("This action has already been starred");
        return;
      }
      if (store.state.userState.user
          .getCompletedActions()
          .contains(action.getId())) {
        print("This action has already been completed");
        return;
      }
      if (store.state.userState.user
          .getRejectedActions()
          .contains(action.getId())) {
        print("This action has already been rejected");
        return;
      }

      // If not already complete/rejected/starred
      User userResponse = await store.state.userState.auth
          .starAction(
        store.state.userState.user.getToken(),
        action.getId(),
      )
          .catchError((error) {
        if (error == AuthError.unauthorized) onAuthError();
      });
      
      store.state.analytics.logActionStatusUpdate(action, ActionStatus.favourite);

      User newUser = store.state.userState.user.copyWith(
        starredActions: userResponse.getStarredActions(),
      );

      saveUserToPrefs(newUser).then((_) {
        store.dispatch(StarredAction(newUser));
      });
    });
  };
}

ThunkAction<AppState> removeActionStatus(CampaignAction action) {
  return (Store<AppState> store) async {
    Future(() async {
      // If not already complete/rejected/starred
      User userResponse = await store.state.userState.auth
          .removeActionStatus(
        store.state.userState.user.getToken(),
        action.getId(),
      )
          .catchError((error) {
        if (error == AuthError.unauthorized) onAuthError();
      });

      User newUser = store.state.userState.user.copyWith(
        starredActions: userResponse.getStarredActions(),
        rejectedActions: userResponse.getRejectedActions(),
        completedActions: userResponse.getCompletedActions(),
      );

      saveUserToPrefs(newUser).then((_) {
        store.dispatch(RemovedActionStatus(newUser));
      });
    });
  };
}

// If the action is already completed then dont do anything
ThunkAction<AppState> completeAction(
    CampaignAction action, BuildContext context) {
  return (Store<AppState> store) async {
    Future(() async {
      // If the action is already completed then dont do anything
      if (store.state.userState.user
          .getCompletedActions()
          .contains(action.getId())) {
        print("This action has already been completed");
        return;
      }

      // Else complete the action
      // Make complete action request
      User completeResponse = await store.state.userState.auth
          .completeAction(
        store.state.userState.user.getToken(),
        action.getId(),
      )
          .catchError((error) {
        if (error.obs == AuthError.unauthorized) onAuthError();
      });
      // Take the response and update the users points
      print("new user points ${completeResponse.getPoints()}");
      User newUser = store.state.userState.user.copyWith(
        points: completeResponse.getPoints(),
      );
      print("Doing fancy list thing");
      // Get all the actions that the user has now completed (that they hadnt completed before)
      List<int> newlyCompletedActions = completeResponse
          .getCompletedActions()
          .where((a) =>
              !store.state.userState.user.getCompletedActions().contains(a))
          .toList();

      // Complete all those new actions for the user
      for (int i = 0; i < newlyCompletedActions.length; i++) {
        if (newlyCompletedActions[i] == action.getId()) {
          newUser.completeAction(action);
          print("Completed action");
          store.state.analytics.logActionStatusUpdate(action, ActionStatus.complete);
          print("Logged completion");
        } else {
          // TODO make it so if there are completed action is actually users the complete action function -- need to wait for /actions request
          //CampaignAction a = await store.state.api.getAction(action.action.getId());
          //action.user.completeAction(a);
        }
      }

      // This is where you say "but James why do you not just copyWith completedCampaigns as the new completed campaigns"
      // And I would respond excellent question
      // The logic is that currently the server does no keep track of completed type, this can easily change at somepoint and will probably be updated to be a server side thing soon but for now its not, so we need to keep track of which type of actions the user has completed
      // Then youd say "yes but what about when a user logs in for the first time do we keep track of the completed aciton types then"
      // And I would respond no
      // TODO fix the above / just get the server to keep track of completed action type

      int newPoints = newUser.getPoints();
      int oldPoints = store.state.userState.user.getPoints();

      print("Points");
      print(newPoints);
      print(oldPoints);

      saveUserToPrefs(newUser).then((_) {
        store.dispatch(CompletedAction(newUser));
        // If the users new next badge is different to their current badge
        // Then they must have earnt a new badge
        if (getNextBadge(newPoints) > getNextBadge(oldPoints)) {
          print("New badge");
          // Do the new badge popup
          // If you did get a new badge then show that popup
          gotBadgeNotifier(
            badge: getNextBadgeFromInt(oldPoints),
            context: context,
          );
        } else {
          // TODO fix this rewards notification part
          // Rewards
          //List<Reward> newlyCompletedRewards =
          //    store.state.userState.user.newlyCompletedRewards(action);
          // If you did get a new reward
          //if (newlyCompletedRewards.length > 0) {
          //  Navigator.push(
          //      context,
          //      CustomRoute(
          //          builder: (context) =>
          //              RewardCompletePage(newlyCompletedRewards)));
          //} else {
          // Points Notifier
          pointsNotifier(newPoints, 5, getNextBadge(newPoints), context)
            ..show(context);
          //}
        }
      });
    });
  };
}
// Once we get the new user

ThunkAction<AppState> emailUser(String email, String name) {
  return (Store<AppState> store) async {
    Future(() async {
      print("In thunk action");
      print(store.state.userState.auth);
      store.state.userState.auth.sendSignInWithEmailLink(email, name).then(
          (loginResponse) {
        print("Trying to send email");
        store.dispatch(SentAuthEmail(email));
        print("Trying to nav");
        Keys.navKey.currentState.pushNamed(Routes.emailSent, arguments: EmailSentPageArguments(email: email, model: UserViewModel.create(store)));
      }, onError: (error) {
        store.dispatch(new LoginFailedAction());
      });
    });
  };
}

ThunkAction loginUser(String email, String link,) {
  return (Store store) async {
    Future(() async {
      store.dispatch(StartLoadingUserAction());
      User user =
          await store.state.userState.auth.signInWithEmailLink(email, link);

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
    });
  };
}

ThunkAction skipLoginAction() {
  return (Store store) async {
    Future(() async {
      User u = User.empty();
      u.setToken(null);
      store.dispatch(CreateNewUser(u)).then((_) {
        Keys.navKey.currentState.pushNamed(Routes.intro);
      });
    });
  };
}

ThunkAction initStore(Uri deepLink) {
  print("DEEP LINK IN INIT | " + deepLink.toString());
  if (deepLink != null) {
    print("DEEP LINK PATH | " + deepLink.path);
    print("DEEP LINK PATH | " + deepLink.query);
  }
  return (Store store) async {
    Future(() async {
      print("We are initing");
      store.dispatch(GetUserDataAction()).then((dynamic u) {
        if (store.state.userState.user != null && store.state.userState.user.isStagingUser()) {
          store.state.api.toggleStagingApi();
        }
        store.dispatch(GetCampaignsAction()).then((dynamic r) {
          // A user id of -1 means the user is the placeholder and therefore does not exist, well get rid of this eventually and keep it as null, but for now useful as when we go to homepage after login we have the placeholder user
          if (store.state.userState.user == null ||
              store.state.userState.user.getToken() == null ||
              store.state.userState.user.getToken() == "") {
            // Skip Login Screen
            //if (store.state.userState.user == null) {
            if (deepLink != null && deepLink.path == "/loginMobile") {
              print("The path is the thing");
              print(deepLink.path);
              store.state.userState.repository.getEmail().then((email) {
                store.dispatch(loginUser(email, deepLink.queryParameters['token']));
                //store.state.userState.auth
                //    .signInWithEmailLink(
                //        email, deepLink.queryParameters['token'])
                //    .then((User r) {
                //  print("Signed in ish");
                //  //print(r.user.email);
                //  //print(r.user.hashCode)
                //  // TODO if new user
                //  // intro
                //  Keys.navKey.currentState.pushNamed(Routes.intro);
                //  // else home cause theyve already done the intro
                //  // Keys.navKey.currentState.pushNamed(Routes.home);
                //});
              });
            } else {
              Keys.navKey.currentState.pushNamed(Routes.login);
            }
          } else {
            // Go home
            print("Going home");
            Keys.navKey.currentState.pushNamed(Routes.home);
          }
        });
      });
    });
  };
}

ThunkAction<AppState> completeLearningResource(LearningResource resource) {
  return (Store<AppState> store) async {
    Future(() async {
      print("Completing LearningResource");
      if (store.state.userState.user
          .getCompletedLearningResources()
          .contains(resource.getId())) {
        return;
      }

      // If not already complete/rejected/starred
      User userResponse = await store.state.userState.auth
          .completeLearningResource(
        store.state.userState.user.getToken(),
        resource.getId(),
      )
          .catchError((error) {
        if (error == AuthError.unauthorized) onAuthError();
      });
      
      store.state.analytics.logLearningResourceClicked(resource);
      
      User newUser = store.state.userState.user.copyWith(
        completedLearningResources: userResponse.getCompletedLearningResources(),
      );

      saveUserToPrefs(newUser).then((_) {
        store.dispatch(CompletedLearningResource(newUser));
      });
    });
  };
}


void onAuthError() {
  Keys.navKey.currentState.pushNamed(Routes.login);
}

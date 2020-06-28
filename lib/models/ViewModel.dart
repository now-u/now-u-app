import 'package:flutter/material.dart';

import 'package:app/models/Campaigns.dart';
import 'package:app/models/Campaign.dart';
import 'package:app/models/Action.dart';
import 'package:app/models/User.dart';
import 'package:app/services/api.dart';
import 'package:app/services/auth.dart';
import 'package:app/services/storage.dart';

import 'package:app/models/State.dart';
import 'package:redux/redux.dart';
import 'package:app/redux/actions.dart';
import 'package:app/redux/middleware.dart';

class ViewModel {
  final Campaigns campaigns;
  final UserViewModel userModel;
  //final User user;
  final Api api;
  final Function(Campaign, BuildContext) onJoinCampaign;
  final Function(Campaign) onUnjoinCampaign;
  final Function(User) onUpdateUserDetails;
  final Function(CampaignAction, BuildContext) onCompleteAction;
  final Function(CampaignAction, String) onRejectAction;
  final Function(CampaignAction) onStarAction;
  final Function(CampaignAction) onRemoveActionStatus;
  final Function() onLogout;

  // Helper functions
  final Function() getActiveSelectedCampaings;
  final Function() getActiveCompletedActions;
  final Function(
      {bool includeCompleted,
      bool includeRejected,
      bool includeTodo,
      bool includeStarred}) getActiveActions; // Non-rejected, non-completed

  ViewModel({
    this.campaigns,
    this.userModel,
    //this.user,
    this.api,
    this.onJoinCampaign,
    this.onUnjoinCampaign,
    this.onCompleteAction,
    this.onRejectAction,
    this.onRemoveActionStatus,
    this.onStarAction,
    this.onUpdateUserDetails,
    this.onLogout,

    // Helper functions
    this.getActiveSelectedCampaings,
    this.getActiveCompletedActions,
    this.getActiveActions,
  });

  factory ViewModel.create(Store<AppState> store) {
    _onJoinCampaign(Campaign campaign, BuildContext context) {
      store.dispatch(joinCampaign(campaign, context));
    }

    _onUnjoinCampaign(Campaign c) {
      store.dispatch(UnjoinCampaign(c));
    }

    //_onCompleteAction(CampaignAction action, Function onSuccess) {
    //  //store.dispatch(CompleteAction(action, store.state.userState.user.copyWith(), onSuccess));
    //}
    _onCompleteAction(CampaignAction action, BuildContext context) {
      //store.dispatch(CompleteAction(action, store.state.userState.user.copyWith(), onSuccess));
      store.dispatch(completeAction(action, context));
    }

    _onRejectAction(CampaignAction action, String reason) {
      store.dispatch(RejectAction(action, reason));
    }

    _onStarAction(CampaignAction action) {
      store.dispatch(starAction(action));
    }

    _onRemoveActionStatus(CampaignAction action) {
      store.dispatch(removeActionStatus(action));
    }

    _onUpdateUserDetails(User user) {
      print("_onUpdateUserDetails");
      store.dispatch(UpdateUserDetails(user));
    }

    _onLogout() {
      store.dispatch(Logout());
    }

    // Helper Functions
    Campaigns _getActiveSelectedCampaigns() {
      return Campaigns(store.state.userState.user
          .filterSelectedCampaigns(store.state.campaigns.getActiveCampaigns()));
    }
    List<CampaignAction> _getActiveCompletedActions() {
      return store.state.campaigns.getActions()
                .where((a) => 
                  store.state.userState.user.getCompletedActions()
                    .contains(a.getId())).toList();
    }

    //List<Campaign> _getActiveUnselectedCampaigns() {
    //  List<Campaign> campaigns = [];
    //  campaigns.addAll(store.state.campaigns.getActiveCampaigns());
    //  campaigns.removeWhere((c) => store.state.userState.user.getSelectedCampaigns().contains(c.getId()));S
    //  return campaigns;
    //}
    List<CampaignAction> _getActiveActions(
        {bool includeCompleted,
        bool includeRejected,
        bool onlySelectedCampaigns,
        bool includeTodo, // Todo actions are unstarred and uncompleted
        bool includeStarred}) {
      print("Getting actions");
      List<CampaignAction> actions = [];
      actions.addAll(store.state.campaigns.getActions());
      if (!(includeRejected ?? false)) {
        actions.removeWhere((a) => store.state.userState.user
            .getRejectedActions()
            .contains(a.getId()));
      }
      // If dont include todo actions then get rid of those todo
      if (!(includeTodo ?? true)) {
        actions.removeWhere((a) =>
            !store.state.userState.user
                .getCompletedActions()
                .contains(a.getId()) &&
            !store.state.userState.user
                .getStarredActions()
                .contains(a.getId()));
      }
      if (!(includeCompleted ?? false)) {
        actions.removeWhere((a) => store.state.userState.user
            .getCompletedActions()
            .contains(a.getId()));
      }
      if (!(includeStarred ?? true)) {
        actions.removeWhere((a) =>
            store.state.userState.user.getStarredActions().contains(a.getId()));
      }
      if (onlySelectedCampaigns ?? false) {
        // If action is not in the selected campaings then get rid
        Campaigns activeSelectedCampaigns = _getActiveSelectedCampaigns();
        actions.removeWhere(
            (action) => !activeSelectedCampaigns.getActions().contains(action));
      }
      return actions;
    }

    return ViewModel(
      campaigns: store.state.campaigns,
      userModel: UserViewModel.create(store),
      //user: store.state.userState.user,
      api: store.state.api,
      onJoinCampaign: _onJoinCampaign,
      onUnjoinCampaign: _onUnjoinCampaign,
      onCompleteAction: _onCompleteAction,
      onRejectAction: _onRejectAction,
      onRemoveActionStatus: _onRemoveActionStatus,
      onStarAction: _onStarAction,
      onUpdateUserDetails: _onUpdateUserDetails,
      onLogout: _onLogout,

      // Helper Functions
      getActiveSelectedCampaings: _getActiveSelectedCampaigns,
      getActiveCompletedActions: _getActiveCompletedActions,
      getActiveActions: _getActiveActions,
    );
  }
}

class UserViewModel {
  final bool isLoading;
  final bool loginError;
  final User user;
  final AuthenticationService auth;
  final SecureStorageService repository;

  final Function(String, String) login;
  final Function(String) email;
  final Function() skipLogin;

  UserViewModel({
    this.isLoading,
    this.loginError,
    this.user,
    this.login,
    this.email,
    this.auth,
    this.repository,
    this.skipLogin,
  });
  factory UserViewModel.create(Store<AppState> store) {
    print("In login ViewModel create");
    print(store.state.userState.auth);
    return UserViewModel(
        isLoading: store.state.userState.isLoading,
        loginError: store.state.userState.loginError,
        user: store.state.userState.user,
        auth: store.state.userState.auth,
        repository: store.state.userState.repository,
        login: (String email, String link) {
          store.dispatch(loginUser(email, link));
        },
        email: (String email) {
          print("Dispatching send email action | " + email);
          store.dispatch(emailUser(email));
        },
        skipLogin: () {
          store.dispatch(skipLoginAction());
        });
  }
}

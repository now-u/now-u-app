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
  final Function(Campaign, Function) onJoinCampaign;
  final Function(Campaign) onUnjoinCampaign;
  final Function(User) onUpdateUserDetails;
  final Function(CampaignAction, Function) onCompleteAction;
  final Function(CampaignAction, String) onRejectAction;

  // Helper functions
  final Function() getActiveSelectedCampaings;

  ViewModel({
    this.campaigns,
    this.userModel,
    //this.user,
    this.api,
    this.onJoinCampaign,
    this.onUnjoinCampaign,
    this.onCompleteAction,
    this.onRejectAction,
    this.onUpdateUserDetails,

    // Helper functions
    this.getActiveSelectedCampaings,
  });

  factory ViewModel.create(Store<AppState> store) {
    _onJoinCampaign(Campaign c, Function onSuccess) {
      store.dispatch(JoinCampaign(c, onSuccess));
    }
    _onUnjoinCampaign(Campaign c) {
      store.dispatch(UnjoinCampaign(c));
    }

    _onCompleteAction(CampaignAction action, Function onSuccess) {
      store.dispatch(CompleteAction(action, store.state.userState.user.copyWith(), onSuccess));
    }
    _onRejectAction(CampaignAction action, String reason) {
      store.dispatch(RejectAction(action, reason));
    }

    _onUpdateUserDetails(User user) {
      print("_onUpdateUserDetails");
      store.dispatch(UpdateUserDetails(user));
    }

    // Helper Functions
    _getActiveSelectedCampaigns() {
      return store.state.userState.user.filterSelectedCampaigns(store.state.campaigns.getActiveCampaigns());
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
      onUpdateUserDetails: _onUpdateUserDetails,

      // Helper Functions
      getActiveSelectedCampaings: _getActiveSelectedCampaigns,
    );
  }
}

class UserViewModel {
  final bool isLoading;
  final bool loginError;
  final User user;
  final AuthenticationService auth;
  final SecureStorageService repository;

  final Function (String, String) login;
  final Function (String) email;
  final Function () skipLogin;

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
      }
    );
  }
}

import 'package:app/models/Campaigns.dart';
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
  final UserState userState;
  final User user;
  final Api api;
  final Function(User) onSelectCampaigns;
  final Function(User) onUpdateUserDetails;
  final Function(CampaignAction) onCompleteAction;

  ViewModel({
    this.campaigns,
    this.userState,
    this.user,
    this.api,
    this.onSelectCampaigns,
    this.onCompleteAction,
    this.onUpdateUserDetails,
  });

  factory ViewModel.create(Store<AppState> store) {
    _onSelectCampaigns(User u) {
      store.dispatch(SelectCampaignsAction(u));
    }

    _onCompleteAction(CampaignAction action) {
      store.dispatch(CompleteAction(action));
    }

    _onUpdateUserDetails(User user) {
      store.dispatch(UpdateUserDetails(user));
    }

    return ViewModel(
      campaigns: store.state.campaigns,
      userState: store.state.userState,
      user: store.state.userState.user,
      api: store.state.api,
      onSelectCampaigns: _onSelectCampaigns,
      onCompleteAction: _onCompleteAction,
      onUpdateUserDetails: _onUpdateUserDetails,
    );
  }
}

class LoginViewModel {
  final bool isLoading;
  final bool loginError;
  final User user;
  final AuthenticationService auth;
  final SecureStorageService repository;

  final Function (String, String) login;
  final Function (String) email;

  LoginViewModel({
    this.isLoading,
    this.loginError,
    this.user,
    this.login,
    this.email,
    this.auth,
    this.repository,
  });
  factory LoginViewModel.create(Store<AppState> store) {

    print("In login ViewModel create");
    print(store.state.userState.auth);
    return LoginViewModel(
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
      }
    );
  }
}

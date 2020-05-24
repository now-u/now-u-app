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
  final UserViewModel userModel;
  //final User user;
  final Api api;
  final Function(User, Function) onSelectCampaigns;
  final Function(User) onUpdateUserDetails;
  final Function(CampaignAction, Function) onCompleteAction;

  ViewModel({
    this.campaigns,
    this.userModel,
    //this.user,
    this.api,
    this.onSelectCampaigns,
    this.onCompleteAction,
    this.onUpdateUserDetails,
  });

  factory ViewModel.create(Store<AppState> store) {
    _onSelectCampaigns(User u, Function onSuccess) {
      store.dispatch(SelectCampaignsAction(u, onSuccess));
    }

    _onCompleteAction(CampaignAction action, Function onSuccess) {
      store.dispatch(CompleteAction(action, onSuccess));
    }

    _onUpdateUserDetails(User user) {
      store.dispatch(UpdateUserDetails(user));
    }

    return ViewModel(
      campaigns: store.state.campaigns,
      userModel: UserViewModel.create(store),
      //user: store.state.userState.user,
      api: store.state.api,
      onSelectCampaigns: _onSelectCampaigns,
      onCompleteAction: _onCompleteAction,
      onUpdateUserDetails: _onUpdateUserDetails,
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

  UserViewModel({
    this.isLoading,
    this.loginError,
    this.user,
    this.login,
    this.email,
    this.auth,
    this.repository,
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
      }
    );
  }
}

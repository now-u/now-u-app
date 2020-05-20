import 'package:flutter/foundation.dart';

import 'package:app/models/Campaign.dart';
import 'package:app/models/User.dart';
import 'package:app/models/Action.dart';
import 'package:app/models/Reward.dart';
import 'package:app/models/Campaigns.dart';

import 'package:app/services/api.dart';
import 'package:app/services/auth.dart';
import 'package:app/services/storage.dart';
import 'package:app/locator.dart';


class AppState {
  Campaigns campaigns;
  UserState userState;
  bool loading;
  Api api;
  
  //final Rewards rewards;

  AppState({
    @required this.userState,
    @required this.campaigns,
    @required this.loading,
    this.api,
  });

  AppState.initialState() {
      userState = UserState.init();
      campaigns = Campaigns.init();
      loading = true;
      api = locator<Api>();
  }

  //AppState.fromJson(Map json, AppState state)
  //  : //campaigns = (json['campaigns'] as List).map((c) => Campaign.fromJson(c)).toList(),
  //    //user = (User.fromJson(json['user']));
  //  campaigns = state.campaigns,
  //  loading = state.loading,
  //  userState = UserState.fromJson(json['user']);

  //Map toJson() => {
  //  //'campaigns': campaigns, 
  //  'user': user};
}

class UserState {
  AuthenticationService auth;
  final bool isLoading;
  final bool loginError;
  final bool emailSent;
  final User user;
  final SecureStorageService repository;
  //final FirebaseUser firebaseUser;

  UserState({
    @required this.isLoading,
    @required this.loginError,
    @required this.user,
    @required this.emailSent,
    this.auth,
    this.repository,
  });

  factory UserState.init() {
    return new UserState(
        isLoading: false, 
        loginError: false, 
        emailSent: false, 
        auth: locator<AuthenticationService>(),
        repository: locator<SecureStorageService>(),
        //firebaseUser: null,
        user: null,
          //User(
          //  id: 0,
          //  fullName: "Andrew",
          //  email: "andy@gmail.com",
          //  age: 21,
          //  location: "Bristol",
          //  monthlyDonationLimit: 20.0,
          //  homeOwner: false,
          //)
    );
  }

  UserState.fromJson(Map json, AppState state)
    : user = User.fromJson(json['user']),
      isLoading = false,
      loginError = false,
      auth = state.userState.auth,
      repository = state.userState.repository,
      emailSent = false;

  UserState copyWith({bool isLoading, bool loginError, User user, bool emailSent}) {
    return new UserState(
      isLoading: isLoading ?? this.isLoading, loginError: loginError ?? this.loginError, user: user ?? this.user, emailSent: emailSent ?? this.emailSent, repository: this.repository
    );
  }
}

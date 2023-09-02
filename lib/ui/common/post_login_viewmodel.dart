import 'dart:async';

import 'package:logging/logging.dart';
import 'package:nowu/app/app.locator.dart';
import 'package:nowu/models/User.dart';
import 'package:nowu/services/auth.dart';
import 'package:nowu/services/causes_service.dart';
import 'package:nowu/services/dialog_service.dart';
import 'package:nowu/services/router_service.dart';
import 'package:nowu/services/user_service.dart';
import 'package:stacked/stacked.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

mixin PostLoginViewModelMixin on BaseViewModel implements Initialisable {
  final _userService = locator<UserService>();
  final _routerService = locator<RouterService>();
  final _causesService = locator<CausesService>();
  final _dialogService = locator<DialogService>();
  final _authenticationService = locator<AuthenticationService>();
  final _logger = Logger('PostLoginViewModelMixin');

  void initialise() {
    _logger.info('Initialised PostLoginViewModelMixin');
    setupNavigatePostLogin();
  }

  StreamSubscription<AuthState>? _authStateSubscription;

  Future<void> setupNavigatePostLogin() async {
    _authStateSubscription =
        _authenticationService.onAuthStateChange((data) async {
      _logger.info('Auth state changed');
      if (data.event == AuthChangeEvent.signedIn && data.session != null) {
        handleSignedIn();
      }
    });
  }

  void handleSignedIn() async {
    _authStateSubscription?.cancel();
    await fetchUserAndNavigatePostLogin();
  }

  @override
  void dispose() {
    _authStateSubscription?.cancel();
    super.dispose();
  }

  Future<void> fetchUserAndNavigatePostLogin() async {
    _logger.info('Fetching user info');
    final currentUser = await _userService.fetchUser();

    _logger.info('Fetching causes user info');
    final userCausesInfo = await _causesService.fetchUserInfo();

    if (currentUser == null || userCausesInfo == null) {
      _logger.severe('Login failed: $currentUser, $userCausesInfo');
      _dialogService.showErrorDialog(
        title: 'Login failed',
        description: 'Login failed please try again',
      );
    }

    if (!currentUser!.isInitialised) {
      return _routerService.clearStackAndShow(const ProfileSetupViewRoute());
    }

    if (!userCausesInfo!.isInitialised) {
      return _routerService
          .clearStackAndShow(const OnboardingSelectCausesViewRoute());
    }

    return _routerService.navigateToHome(clearHistory: true);
  }
}

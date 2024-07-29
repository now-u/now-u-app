import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';
import 'package:nowu/services/auth.dart';
import 'package:nowu/services/causes_service.dart';
import 'package:nowu/services/user_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../services/storage.dart';
import './authentication_state.dart';

class AuthenticationBloc extends Cubit<AuthenticationState> {
  final AuthenticationService _authenticationService;
  final CausesService _causesService;
  final UserService _userService;
  final SecureStorageService storageService;
  final Logger _logger = Logger('AuthenticationBloc');

  AuthenticationBloc({
    required UserService userService,
    required AuthenticationService authenticationService,
    required CausesService causesService,
    required this.storageService,
  })  : _userService = userService,
        _authenticationService = authenticationService,
        _causesService = causesService,
        super(const AuthenticationState.unknown()) {
    authenticationService.authState.listen((event) {
      switch (event.event) {
        case AuthChangeEvent.signedIn:
        case AuthChangeEvent.tokenRefreshed:
        case AuthChangeEvent.initialSession
            when event.session?.isExpired == false:
          _onSignIn();
          break;
        case AuthChangeEvent.signedOut:
          _onSignOut();
          break;
        default:
          break;
      }
    });

    userService.currentUserStream.listen((user) {
      if (user != null) {
        emit(AuthenticationState.authenticated(user: user));
      } else {
        // TODO This probably needs handling?
        _logger.warning('No user during user update...');
      }
    });
  }

  Future<void> _onSignIn() async {
    try {
      final (user, _) = await (
        _userService.fetchUser(),
        _causesService.fetchUserInfo(),
      ).wait;
      if (user != null) {
        emit(AuthenticationState.authenticated(user: user));
        return;
      }
      throw Exception('No user during fetch');
    } catch (e) {
      await _onUnauthenticated();
    }
  }

  Future<void> _onSignOut() async {
    // TODO Should we clear user from user service here?
    await _onUnauthenticated();
  }

  Future<void> signOut() async {
    _authenticationService.logout();
  }

  Future<void> _onUnauthenticated() async {
    emit(
      AuthenticationState.unauthenticated(
        hasShownIntro: (await storageService.getIntroShown()),
      ),
    );
  }
}

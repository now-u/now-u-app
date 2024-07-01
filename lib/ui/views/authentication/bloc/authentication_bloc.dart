import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nowu/services/auth.dart';
import 'package:nowu/services/causes_service.dart';
import 'package:nowu/services/user_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../services/storage.dart';
import './authentication_event.dart';
import './authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationService _authenticationService;
  final CausesService _causesService;
  final UserService _userService;
  final SecureStorageService storageService;

  AuthenticationBloc({
    required UserService userService,
    required AuthenticationService authenticationService,
    required CausesService causesService,
    required this.storageService,
  })  : _userService = userService,
        _authenticationService = authenticationService,
        _causesService = causesService,
        super(const AuthenticationState.unknown()) {
    on<AuthenticationSignIn>(_onSignIn);
    on<AuthenticationSignOut>(_onSignOut);
    on<AuthenticationSignOutRequested>(_onSignOutRequested);

    authenticationService.authState.listen((event) {
      switch (event.event) {
        case AuthChangeEvent.signedIn:
          add(const AuthenticationSignIn());
          break;
        case AuthChangeEvent.signedOut:
          add(const AuthenticationSignOut());
          break;
        default:
          break;
      }
    });
  }

  Future<void> _onSignIn(
    AuthenticationSignIn event,
    Emitter<AuthenticationState> emit,
  ) async {
    final (user, _) = await (
      _userService.fetchUser(),
      _causesService.fetchUserInfo(),
    ).wait;
    if (user != null) {
      emit(AuthenticationState.authenticated(user: user));
    } else {
      await _onUnauthenticated(emit);
    }
  }

  Future<void> _onSignOut(
    AuthenticationSignOut event,
    Emitter<AuthenticationState> emit,
  ) async {
    // TODO Should we clear user from user service here?
    await _onUnauthenticated(emit);
  }

  Future<void> _onSignOutRequested(
    AuthenticationSignOutRequested event,
    Emitter<AuthenticationState> emit,
  ) async {
    _authenticationService.logout();
  }

  Future<void> _onUnauthenticated(Emitter<AuthenticationState> emit) async {
    emit(
      AuthenticationState.unauthenticated(
        hasShownIntro: (await storageService.getIntroShown()),
        // TODO Remember if login has previously been skipped
        hasSkippedLogin: false,
      ),
    );
  }
}

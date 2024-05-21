import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nowu/services/auth.dart';
import 'package:nowu/services/causes_service.dart';
import 'package:nowu/services/user_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import './authentication_event.dart';
import './authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationService authenticationService;
  final CausesService causesService;
  final UserService userService;

  AuthenticationBloc({
    required this.userService,
    required this.authenticationService,
    required this.causesService,
  }) : super(const AuthenticationState.unknown()) {
    on<AuthenticationSignIn>(_onSignIn);
    on<AuthenticationSignOut>(_onSignOut);
    on<AuthenticationSignOutRequested>(_onSignOutRequested);

    authenticationService.authState.listen((event) {
      switch (event.event) {
        case AuthChangeEvent.signedIn:
        case AuthChangeEvent.initialSession:
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
      userService.fetchUser(),
      causesService.fetchUserInfo(),
    ).wait;
    if (user != null) {
      emit(AuthenticationState.authenticated(user: user));
    } else {
      emit(const AuthenticationState.unauthenticated());
    }
  }

  Future<void> _onSignOut(
    AuthenticationSignOut event,
    Emitter<AuthenticationState> emit,
  ) async {
    // TODO Should we clear user from user service here?
    emit(const AuthenticationState.unauthenticated());
  }

  Future<void> _onSignOutRequested(
    AuthenticationSignOutRequested event,
    Emitter<AuthenticationState> emit,
  ) async {
    authenticationService.logout();
  }
}

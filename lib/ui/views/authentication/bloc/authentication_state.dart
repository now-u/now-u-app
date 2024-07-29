import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nowu/models/user.dart';

part 'authentication_state.freezed.dart';

@freezed
sealed class AuthenticationState with _$AuthenticationState {
  const factory AuthenticationState.unknown() = AuthenticationStateUnknown;
  const factory AuthenticationState.unauthenticated({
    required bool hasShownIntro,
  }) = AuthenticationStateUnauthenticated;
  const factory AuthenticationState.authenticated({
    // TODO Make user model
    required UserProfile user,
  }) = AuthenticationStateAuthenticated;
}

import 'package:causeApiClient/causeApiClient.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'authentication_state.freezed.dart';

@freezed
sealed class AuthenticationState with _$AuthenticationState {
  const factory AuthenticationState.unknown() = AuthenticationStateUnknown;
  const factory AuthenticationState.unauthenticated() =
      AuthenticationStateUnauthenticated;
  const factory AuthenticationState.authenticated({
    // TODO Make user model
    required UserProfile user,
  }) = AuthenticationStateAuthenticated;

  const factory AuthenticationState.intro() = AuthenticationStateIntro;
}

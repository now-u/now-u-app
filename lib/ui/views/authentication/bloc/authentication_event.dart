import 'package:freezed_annotation/freezed_annotation.dart';

part 'authentication_event.freezed.dart';

@freezed
sealed class AuthenticationEvent with _$AuthenticationEvent {
  const factory AuthenticationEvent.signedIn() = AuthenticationSignIn;
  const factory AuthenticationEvent.signedOut() = AuthenticationSignOut;
  const factory AuthenticationEvent.signOutRequested() =
      AuthenticationSignOutRequested;
}

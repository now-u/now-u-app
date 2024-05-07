import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nowu/services/auth.dart';
part 'login_event.freezed.dart';

@freezed
sealed class LoginEvent with _$LoginEvent {
  const factory LoginEvent.loginWithOAuth({
	required AuthProvider provider,
  }) = LoginEventLoginWithOAuth;

  const factory LoginEvent.emailChanged({
	required String email,
  }) = LoginEventEmailedChanged;
  const factory LoginEvent.loginWithEmail() = LoginEventLoginWithEmail;
}

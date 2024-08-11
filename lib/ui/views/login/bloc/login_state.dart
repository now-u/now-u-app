import 'package:formz/formz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../models/email.dart';

part 'login_state.freezed.dart';

enum SocialMediaLoginStatus {
  initial,
  loading,
  failure,
  success,
}

@freezed
class LoginState with _$LoginState {
  factory LoginState({
    @Default(SocialMediaLoginStatus.initial) socialMediaLoginStatus,
    @Default(FormzSubmissionStatus.initial)
    FormzSubmissionStatus emailFormStatus,
    @Default(false) bool emailFormIsValid,
    @Default(false) bool showValidation,
    required Email email,
  }) = _LoginState;
}

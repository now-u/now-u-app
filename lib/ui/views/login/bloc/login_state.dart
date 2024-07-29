import 'package:formz/formz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../models/email.dart';

part 'login_state.freezed.dart';

@freezed
class LoginState with _$LoginState {
  factory LoginState({
    @Default(FormzSubmissionStatus.initial) FormzSubmissionStatus status,
    @Default(false) bool isValid,
    @Default(false) bool showValidation,
    required Email email,
  }) = _LoginState;
}

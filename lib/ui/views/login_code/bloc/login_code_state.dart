import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nowu/models/user.dart';
import 'package:nowu/ui/views/login_code/model/login_code.dart';

part 'login_code_state.freezed.dart';

@freezed
sealed class LoginCodeSubmissionState with _$LoginCodeSubmissionState {
  const factory LoginCodeSubmissionState.initial() =
      LoginCodeSubmissionStateInitial;
  const factory LoginCodeSubmissionState.inProgress() =
      LoginCodeSubmissionStateInProgress;
  const factory LoginCodeSubmissionState.failure() =
      LoginCodeSubmissionStateFailure;
  const factory LoginCodeSubmissionState.success({
    required UserProfile user,
  }) = LoginCodeSubmissionStateSuccess;
}

@freezed
class LoginCodeState with _$LoginCodeState {
  factory LoginCodeState({
    @Default(LoginCodeSubmissionState.initial())
    LoginCodeSubmissionState status,
    @Default(false) bool isValid,
    required LoginCode loginCode,
    required String email,
  }) = _LoginCodeState;
}

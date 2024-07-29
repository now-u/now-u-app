import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nowu/models/user.dart';

part 'user_progress_state.freezed.dart';

@freezed
sealed class UserProgressState with _$UserProgressState {
  const factory UserProgressState.loading() = Loading;
  const factory UserProgressState.noUser() = NoUser;
  const factory UserProgressState.loaded({required CausesUser userInfo}) =
      Loaded;
  const factory UserProgressState.error(String message) = Error;
}

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:formz/formz.dart';
import 'package:nowu/ui/views/profile_setup/model/tsAndCsAcceptInput.dart';

import '../model/name.dart';

part 'profile_setup_state.freezed.dart';

@freezed
class ProfileSetupState with _$ProfileSetupState {
  factory ProfileSetupState({
    @Default(FormzSubmissionStatus.initial) FormzSubmissionStatus status,
    @Default(false) bool isValid,
    required Name name,
    required bool shouldSubscribeToNewsLetter,
    required TsAndCsAcceptInput tsAndCsAccepted,
  }) = _ProfileSetupState;
}

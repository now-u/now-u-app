import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:nowu/services/user_service.dart';
import 'package:nowu/ui/views/profile_setup/model/tsAndCsAcceptInput.dart';

import './profile_setup_state.dart';
import '../model/name.dart';

class ProfileSetupBloc extends Cubit<ProfileSetupState> {
  final UserService _userSerivce;

  ProfileSetupBloc({
    required UserService userService,
  })  : _userSerivce = userService,
        super(
          ProfileSetupState(
            name: Name.pure(),
            shouldSubscribeToNewsLetter: false,
            tsAndCsAccepted: TsAndCsAcceptInput.pure(),
          ),
        );

  void updateName(String name) {
    emit(
      state.copyWith(
        name: Name.dirty(name),
        isValid: Formz.validate([state.name]),
      ),
    );
  }

  void updateShouldSubscribeToNewsLetter(bool shouldSubscribeToNewsLetter) {
    emit(
      state.copyWith(
        shouldSubscribeToNewsLetter: shouldSubscribeToNewsLetter,
      ),
    );
  }

  void updateTsAndCsAccepted(bool value) {
    emit(
      state.copyWith(
        tsAndCsAccepted: TsAndCsAcceptInput.dirty(value),
        isValid: Formz.validate([state.tsAndCsAccepted]),
      ),
    );
  }

  Future<void> submit() async {
    final isValid = Formz.validate([state.name, state.tsAndCsAccepted]);
    if (isValid == false) {
      emit(
        state.copyWith(
          isValid: isValid,
          name: Name.dirty(state.name.value),
          tsAndCsAccepted:
              TsAndCsAcceptInput.dirty(state.tsAndCsAccepted.value),
        ),
      );
      return;
    }

    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    await _userSerivce.updateUser(
      name: state.name.value,
      newsLetterSignup: state.shouldSubscribeToNewsLetter,
    );
    emit(state.copyWith(status: FormzSubmissionStatus.success));
  }
}

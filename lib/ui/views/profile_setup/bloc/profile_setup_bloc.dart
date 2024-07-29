import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:nowu/services/user_service.dart';

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

  Future<void> submit() async {
    final isValid = Formz.validate([state.name]);
    if (isValid == false) {
      emit(state.copyWith(isValid: isValid));
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

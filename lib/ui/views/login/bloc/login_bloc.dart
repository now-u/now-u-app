import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:nowu/services/auth.dart';
import 'package:nowu/utils/require.dart';

import '../models/email.dart';
import './login_state.dart';

class LoginBloc extends Cubit<LoginState> {
  AuthenticationService _authenticationService;

  LoginBloc({
    required AuthenticationService authenticationService,
  })  : _authenticationService = authenticationService,
        super(LoginState(email: Email.pure()));

  void onEmailChanged(String email) {
    final emailState = Email.dirty(email);
    emit(
      state.copyWith(
        email: emailState,
        isValid: Formz.validate([emailState]),
      ),
    );
  }

  Future<void> onLoginWithEmail() async {
    require(state.isValid, 'Cannot login when email is invalid');
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    try {
      await _authenticationService.sendSignInEmail(state.email.value);
      emit(state.copyWith(status: FormzSubmissionStatus.success));
    } catch (e) {
      emit(state.copyWith(status: FormzSubmissionStatus.failure));
    }
  }

  Future<void> onLoginWithOAuth(AuthProvider provider) async {
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    try {
      await _authenticationService.signInWithOAuth(provider);
      emit(state.copyWith(status: FormzSubmissionStatus.success));
    } catch (_) {
      emit(state.copyWith(status: FormzSubmissionStatus.failure));
    }
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:nowu/services/auth.dart';

import '../models/email.dart';
import './login_state.dart';

class LoginBloc extends Cubit<LoginState> {
  AuthenticationService _authenticationService;

  LoginBloc({
    required AuthenticationService authenticationService,
  })  : _authenticationService = authenticationService,
        super(LoginState(email: Email.pure()));

  void onEmailChanged(String email) {
    emit(
      state.copyWith(
        email: Email.dirty(email),
      ),
    );
  }

  Future<void> onLoginWithEmail() async {
    final isValid = Formz.validate([state.email]);
    if (isValid == false) {
      emit(state.copyWith(emailFormIsValid: isValid, showValidation: true));
      return;
    }
    emit(state.copyWith(emailFormStatus: FormzSubmissionStatus.inProgress));
    try {
      await _authenticationService.sendSignInEmail(state.email.value);
      emit(state.copyWith(emailFormStatus: FormzSubmissionStatus.success));
    } catch (e) {
      emit(state.copyWith(emailFormStatus: FormzSubmissionStatus.failure));
    }
  }

  Future<void> onLoginWithOAuth(AuthProvider provider) async {
    emit(
      state.copyWith(socialMediaLoginStatus: SocialMediaLoginStatus.loading),
    );
    try {
      await _authenticationService.signInWithOAuth(provider);
      emit(
        state.copyWith(
          socialMediaLoginStatus: SocialMediaLoginStatus.success,
        ),
      );
    } catch (_) {
      emit(
        state.copyWith(
          socialMediaLoginStatus: SocialMediaLoginStatus.failure,
        ),
      );
    }
  }
}

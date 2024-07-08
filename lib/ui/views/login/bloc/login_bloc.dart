import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:nowu/router.gr.dart';
import 'package:nowu/services/auth.dart';

import '../models/email.dart';
import './login_state.dart';

class LoginBloc extends Cubit<LoginState> {
  AuthenticationService _authenticationService;
  StackRouter _appRouter;

  LoginBloc({
    required AuthenticationService authenticationService,
    required StackRouter appRouter,
  })  : _authenticationService = authenticationService,
        _appRouter = appRouter,
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
      emit(state.copyWith(isValid: isValid, showValidation: true));
      return;
    }
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    try {
      await _authenticationService.sendSignInEmail(state.email.value);
      emit(state.copyWith(status: FormzSubmissionStatus.success));
      _appRouter.push(LoginEmailSentRoute(email: state.email.value));
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

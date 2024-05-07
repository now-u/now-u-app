import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:nowu/services/auth.dart';
import 'package:nowu/utils/require.dart';

import '../models/email.dart';
import './login_event.dart';
import './login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
	AuthenticationService _authenticationService;

	LoginBloc({
		required AuthenticationService authenticationService,
	}) : 
		_authenticationService = authenticationService,
		super(LoginState(email: Email.pure()))
	{
		on<LoginEventEmailedChanged>(_onEmailChanged);
		on<LoginEventLoginWithOAuth>(_onLoginWithOAuth);
		on<LoginEventLoginWithEmail>(_onLoginWithEmail);
	}

	void _onEmailChanged(
		LoginEventEmailedChanged event,
		Emitter<LoginState> emit,
	) {
		final email = Email.dirty(event.email);
		emit(
			state.copyWith(
				email: email,
				isValid: Formz.validate([email]),
			),
		);
	}

	Future<void> _onLoginWithEmail(
		LoginEventLoginWithEmail event,
		Emitter<LoginState> emit,
	) async {
		require(state.isValid, 'Cannot login when email is invalid');
		emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
		try {
			await _authenticationService.sendSignInEmail(state.email.value);
			emit(state.copyWith(status: FormzSubmissionStatus.success));
		} catch (e) {
			emit(state.copyWith(status: FormzSubmissionStatus.failure));
		}
	}

	Future<void> _onLoginWithOAuth(
		LoginEventLoginWithOAuth event,
		Emitter<LoginState> emit,
	) async {
		emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
		try {
			await _authenticationService.signInWithOAuth(event.provider);
			emit(state.copyWith(status: FormzSubmissionStatus.success));
		} catch (_) {
			emit(state.copyWith(status: FormzSubmissionStatus.failure));
		}
	}
}

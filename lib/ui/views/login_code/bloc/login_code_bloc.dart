import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:nowu/services/auth.dart';
import 'package:nowu/services/user_service.dart';
import 'package:nowu/ui/views/login_code/bloc/login_code_state.dart';
import 'package:nowu/ui/views/login_code/model/login_code.dart';

class LoginCodeBloc extends Cubit<LoginCodeState> {
  final AuthenticationService _authenticationService;
  final UserService _userService;

  LoginCodeBloc({
    required AuthenticationService authenticationService,
    required UserService userService,
    required String email,
  })  : _authenticationService = authenticationService,
        _userService = userService,
        super(LoginCodeState(loginCode: LoginCode.pure(), email: email));

  void updateLoginCode(String code) {
    final loginCode = LoginCode.dirty(code);
    emit(
      state.copyWith(
        loginCode: loginCode,
        isValid: Formz.validate([loginCode]),
      ),
    );
  }

  Future<void> loginWithCode() async {
    if (state.isValid != true) return;

    emit(state.copyWith(status: const LoginCodeSubmissionState.inProgress()));
    try {
      await _authenticationService.signInWithCode(
        state.email,
        state.loginCode.value,
      );
      final user = await _userService.fetchUser();
      if (user == null) {
        emit(state.copyWith(status: const LoginCodeSubmissionState.failure()));
        return;
      }
      emit(
        state.copyWith(status: LoginCodeSubmissionState.success(user: user)),
      );
    } catch (e) {
      emit(state.copyWith(status: const LoginCodeSubmissionState.failure()));
    }
  }

  void onErrorDialogShown() {
    emit(state.copyWith(status: const LoginCodeSubmissionState.initial()));
  }
}

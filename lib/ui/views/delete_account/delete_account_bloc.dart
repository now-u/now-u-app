import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nowu/router.gr.dart';
import 'package:nowu/ui/views/delete_account/delete_account_state.dart';

import '../../../services/auth.dart';
import '../../../services/user_service.dart';

class DeleteAccountBloc extends Cubit<DeleteAccountState> {
  AuthenticationService _authenticationService;
  StackRouter _appRouter;
  UserService _userService;

  DeleteAccountBloc({
    required AuthenticationService authenticationService,
    required StackRouter appRouter,
    required UserService userService,
  })  : _authenticationService = authenticationService,
        _appRouter = appRouter,
        _userService = userService,
        super(const DeleteAccountState());

  void updateInputName(String name) {
    emit(
      state.copyWith(
        name: name,
        isNameValid: name == _userService.currentUser?.name,
      ),
    );
  }

  Future<void> deleteAccount() async {
    if (!state.isNameValid) return;

    await _userService.deleteUser();
    await _authenticationService.logout();
    _appRouter.pushAndPopUntil(const LoginRoute(), predicate: (r) => false);
  }
}

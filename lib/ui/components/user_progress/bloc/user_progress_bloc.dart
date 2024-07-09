import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nowu/services/causes_service.dart';

import './user_progress_state.dart';

// TODO Update to subscribe to repository instead - so it changes when a user completes a resource
class UserProgressBloc extends Cubit<UserProgressState> {
  final CausesService _causesService;

  UserProgressBloc({
    required CausesService causesService,
  })  : _causesService = causesService,
        super(const UserProgressState.loading());

  void fetchUserState() async {
    try {
      final userInfo = await _causesService.getUserInfo();
      emit(UserProgressState.loaded(userInfo: userInfo));
    } catch (e) {
      emit(const UserProgressState.error('Failed to fetch user progress'));
    }
  }
}

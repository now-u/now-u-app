import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nowu/services/causes_service.dart';

import './user_progress_state.dart';

class UserProgressBloc extends Cubit<UserProgressState> {
  final CausesService _causesService;

  UserProgressBloc({
    required CausesService causesService,
  })  : _causesService = causesService,
        super(const UserProgressState.loading()) {
    causesService.userInfoStream.listen((userInfo) {
      if (userInfo != null) {
        emit(UserProgressState.loaded(userInfo: userInfo));
      } else {
        emit(const UserProgressState.noUser());
      }
    });
  }

  void fetchUserState() async {
    try {
      final userInfo = await _causesService.getUserInfo();
      if (userInfo == null) {
        emit(const UserProgressState.noUser());
        return;
      }
      emit(UserProgressState.loaded(userInfo: userInfo));
    } catch (e) {
      emit(const UserProgressState.error('Failed to fetch user progress'));
    }
  }
}

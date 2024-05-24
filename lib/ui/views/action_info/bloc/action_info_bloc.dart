import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nowu/services/causes_service.dart';

import 'action_info_state.dart';

class ActionInfoBloc extends Cubit<ActionInfoState> {
  final CausesService _causesService;
  final int _actionId;

  ActionInfoBloc({required int actionId, required CausesService causesService})
      : _causesService = causesService,
        _actionId = actionId,
        super(const ActionInfoState.initial()) {}

  Future<void> fetchAction() async {
    try {
      final action = await _causesService.getAction(_actionId);
      emit(
        ActionInfoState.success(action: action),
      );
    } catch (_) {
      emit(
        const ActionInfoState.fetchFailure(),
      );
    }
  }

  Future<void> markActionComplete() async {
    final state = requireSuccessState();
    try {
      await _causesService.completeAction(state.action);
    } catch (err) {
      // TODO Google how dialogs are done in bloc.
      // Either add a state for this (which I guess is cleared after the dialog is closed?), or make it so we can emit and event and listen for it in the UI (without a state change)
      emit(
        ActionInfoStateUpdateFailed(
          action: state.action,
        ),
      );
    }
  }

  Future<void> clearActionStatus() async {
    final state = requireSuccessState();
    // TODO Handle error here.
    await _causesService.removeActionStatus(state.action);
  }

  ActionInfoStateSuccess requireSuccessState() {
    switch (state) {
      case ActionInfoStateSuccess():
        return state as ActionInfoStateSuccess;
      default:
        throw Exception('Mark complete can only be done in completed state');
    }
  }
}

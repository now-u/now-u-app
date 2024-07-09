import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nowu/models/action.dart';

part 'action_info_state.freezed.dart';

@freezed
sealed class ActionInfoStatusUpdateState {
  const factory ActionInfoStatusUpdateState.initial() =
      ActionInfoStatusUpdateStateInitial;
  const factory ActionInfoStatusUpdateState.failed() =
      ActionInfoStatusUpdateStateFailed;
  const factory ActionInfoStatusUpdateState.markCompleteSuccess() =
      ActionInfoStatusUpdateStateMarkCompleteSuccess;
  const factory ActionInfoStatusUpdateState.clearStatusSuccess() =
      ActionInfoStatusUpdateStateClearStatusSuccess;
}

@freezed
sealed class ActionInfoState {
  const factory ActionInfoState.initial() = ActionInfoStateInitial;
  const factory ActionInfoState.fetchFailure() = ActionInfoStateFetchFailure;
  const factory ActionInfoState.success({
    required Action action,
    required ActionInfoStatusUpdateState statusUpdateState,
  }) = ActionInfoStateSuccess;
}

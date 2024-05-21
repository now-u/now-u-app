import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nowu/models/action.dart';

part 'action_info_state.freezed.dart';

@freezed
class ActionInfoState {
  const factory ActionInfoState.initial() = ActionInfoStateInitial;
  const factory ActionInfoState.fetchFailure() = ActionInfoStateFetchFailure;
  const factory ActionInfoState.success({
    required Action action,
  }) = ActionInfoStateSuccess;
  const factory ActionInfoState.statusUpdateFailed({
    required Action action,
  }) = ActionInfoStateUpdateFailed;
}

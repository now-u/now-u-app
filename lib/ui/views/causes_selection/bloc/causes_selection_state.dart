import 'package:freezed_annotation/freezed_annotation.dart';

part 'causes_selection_state.freezed.dart';

@freezed
class CausesSelectionSubmissionState with _$CausesSelectionSubmissionState {
  const factory CausesSelectionSubmissionState.none() =
      CausesSelectionSubmissionStateNone;
  const factory CausesSelectionSubmissionState.submitting() =
      CausesSelectionSubmissionStateSubmitting;
  const factory CausesSelectionSubmissionState.submitted() =
      CausesSelectionSubmissionStateSubmitted;
  const factory CausesSelectionSubmissionState.error(String message) =
      CausesSelectionSubmissionStateError;
}

@freezed
class CausesSelectionState with _$CausesSelectionState {
  factory CausesSelectionState({
    required Set<int> selectedCausesIds,
    required CausesSelectionSubmissionState submissionState,
  }) = _CausesSelectionState;
}

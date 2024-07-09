import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';
import 'package:nowu/services/causes_service.dart';

import 'causes_selection_state.dart';

class CausesSelectionBloc extends Cubit<CausesSelectionState> {
  final logger = Logger('CausesSelectionBloc');
  final CausesService _causesService;

  CausesSelectionBloc({
    required CausesService causesService,
    required Set<int> initialSelectedCausesIds,
  })  : _causesService = causesService,
        super(
          CausesSelectionState(
            selectedCausesIds: initialSelectedCausesIds,
            submissionState: const CausesSelectionSubmissionState.none(),
          ),
        );

  void toggleCauseSelection(int causeId) {
    switch (state.submissionState) {
      case CausesSelectionSubmissionStateSubmitting():
      case CausesSelectionSubmissionStateSubmitted():
        logger.warning('Cannot toggle cause selection when not in form state');
        return;
      case CausesSelectionSubmissionStateError():
      case CausesSelectionSubmissionStateNone():
        {
          Set<int> selectedCausesIds = {...state.selectedCausesIds};
          if (selectedCausesIds.contains(causeId)) {
            selectedCausesIds.remove(causeId);
          } else {
            selectedCausesIds.add(causeId);
          }
          emit(state.copyWith(selectedCausesIds: selectedCausesIds));
        }
    }
  }

  Future<void> selectCauses(Set<int> selectedCausesIds) async {
    emit(
      state.copyWith(
        selectedCausesIds: selectedCausesIds,
        submissionState: const CausesSelectionSubmissionState.submitting(),
      ),
    );
    try {
      await _causesService.selectCauses(selectedCausesIds);
      emit(
        state.copyWith(
          selectedCausesIds: selectedCausesIds,
          submissionState: const CausesSelectionSubmissionState.submitted(),
        ),
      );
    } catch (e) {
      logger.severe('Failed to update causes selection', e);
      emit(
        state.copyWith(
          selectedCausesIds: selectedCausesIds,
          submissionState: const CausesSelectionSubmissionState.error(
            'Failed to update causes selection',
          ),
        ),
      );
    }
  }
}

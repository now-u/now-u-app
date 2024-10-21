import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nowu/services/causes_service.dart';

import 'causes_state.dart';

class CausesBloc extends Cubit<CausesState> {
  final CausesService _causesService;

  CausesBloc({required CausesService causesService})
      : _causesService = causesService,
        super(const CausesState.loading()) {
    _causesService.causesStream.listen((causes) {
      if (causes != null) {
        emit(CausesState.loaded(causes: causes));
      }
    });
  }

  void fetchCauses() async {
    emit(const CausesState.loading());
    try {
      final causes = await _causesService.listCauses();
      emit(CausesState.loaded(causes: causes));
    } catch (e) {
      // Handle error
      emit(const CausesState.error('Failed to fetch causes'));
    }
  }
}

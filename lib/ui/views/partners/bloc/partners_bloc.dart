import 'package:nowu/services/causes_service.dart';

import './partners_event.dart';
import './partners_state.dart';

import 'package:bloc/bloc.dart';

class PartnersBloc extends Bloc<PartnersEvent, PartnersState> {
  final CausesService causesService;

  PartnersBloc({required this.causesService})
      : super(const PartnersState.initial()) {
    on<PartnersFetched>(_onPartnersFetched);
  }

  Future<void> _onPartnersFetched(
    PartnersFetched event,
    Emitter<PartnersState> emit,
  ) async {
    switch (state) {
	  // If we already have the partners then we don't need to refetch (this might not be true if we want to support refresh)
      case PartnersStateSuccess():
        return;
      case PartnersStateFailure():
      case PartnersStateInitial():
        {
          try {
            final partners = await causesService.getPartners();
            return emit(PartnersStateSuccess(partners: partners));
          } catch (_) {
            emit(const PartnersStateFailure());
          }
        }
    }
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nowu/services/causes_service.dart';

import 'explore_filter_state.dart';

class ExploreFilterBloc extends Cubit<ExploreFilterState> {
  // TODO Fix this - ideally we should remember if any change to causes has been made
  // and if not update the set of causes whenever the user selection changes
  // or maybe not? Maybe we should just listen to any changes and override the filter 
  // when it changes? (It wont happen very often)
  ExploreFilterBloc({
    required CausesService causesService,
  }) : super(
          ExploreFilterState(
            filterCauseIds: causesService.userInfo?.selectedCausesIds ?? {},
          ),
        );

  void updateFilter(ExploreFilterState filterState) async {
    emit(
      filterState,
    );
  }
}

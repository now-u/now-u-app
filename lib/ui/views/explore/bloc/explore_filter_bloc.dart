import 'package:flutter_bloc/flutter_bloc.dart';

import 'explore_filter_state.dart';

class ExploreFilterBloc extends Cubit<ExploreFilterState> {
  ExploreFilterBloc({
    required Set<int> selectedCausesIds,
  }) : super(
          ExploreFilterState(
            filterCauseIds: selectedCausesIds,
          ),
        );

  void updateFilter(ExploreFilterState filterState) async {
    emit(
      filterState,
    );
  }
}

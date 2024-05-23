import 'package:flutter_bloc/flutter_bloc.dart';

import 'explore_filter_state.dart';

class ExploreFilterBloc extends Cubit<ExploreFilterState> {
  ExploreFilterBloc() : super(const ExploreFilterState());

  void updateFilter(ExploreFilterState filterState) async {
    emit(
      filterState,
    );
  }
}

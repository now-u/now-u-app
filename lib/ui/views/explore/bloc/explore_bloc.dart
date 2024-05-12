import 'package:flutter_bloc/flutter_bloc.dart';

import 'explore_state.dart';

class ExploreBloc extends Cubit<ExploreState> {
	ExploreBloc() : super(const ExploreState());

	void updateFilter(ExploreFilterState filterState) {
		emit(
			state.copyWith(
				filterState: filterState,
			),
		);

		// Fetch the data

		// Emit with new data
	}
}

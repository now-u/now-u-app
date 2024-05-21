import 'package:nowu/services/causes_service.dart';
import 'package:nowu/services/model/search/search_response.dart';
import 'package:nowu/services/search_service.dart';
import 'package:nowu/ui/paging/paging_state.dart';
import 'package:nowu/ui/views/explore/bloc/explore_filter_state.dart';
import 'package:nowu/utils/new_since.dart';

import './explore_tab_bloc.dart';

class ExploreActionTabBloc extends ExploreTabBloc<ListAction> {
  ExploreActionTabBloc({
    required SearchService searchService,
  }) : super(
          initialState: const ExploreTabState<ListAction>(
            data: const InitialLoading<ListAction>(),
          ),
          searchService: searchService,
        );

  Future<SearchResponse<ListAction>> searchImpl(
    ExploreFilterState filterState,
    int? offset,
  ) async {
    return searchService.searchActions(
      filter: _getActionsFilter(filterState),
      offset: offset ?? 0,
    );
  }

  ActionSearchFilter _getActionsFilter(ExploreFilterState filterState) {
    return ActionSearchFilter(
      causeIds: filterState.filterCauseIds.isEmpty
          ? null
          : filterState.filterCauseIds.toList(),
      timeBrackets: filterState.filterTimeBrackets.isEmpty
          ? null
          : filterState.filterTimeBrackets.toList(),
      types: filterState.filterActionTypes.isEmpty
          ? null
          : filterState.filterActionTypes.toList(),
      completed: filterState.filterCompleted == true ? true : null,
      recommended: filterState.filterRecommended == true ? true : null,
      releasedSince: filterState.filterNew == true ? newSinceDate() : null,
      query: filterState.queryText,
    );
  }
}

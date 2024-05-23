import 'package:nowu/services/causes_service.dart';
import 'package:nowu/services/model/search/search_response.dart';
import 'package:nowu/services/search_service.dart';
import 'package:nowu/ui/paging/paging_state.dart';
import 'package:nowu/ui/views/explore/bloc/explore_filter_state.dart';
import 'package:nowu/utils/new_since.dart';

import './explore_tab_bloc.dart';

class ExploreLearningResourceTabBloc extends ExploreTabBloc<LearningResource> {
  ExploreLearningResourceTabBloc({
    required SearchService searchService,
  }) : super(
          initialState: const ExploreTabState<LearningResource>(
            data: const InitialLoading<LearningResource>(),
          ),
          searchService: searchService,
        );

  Future<SearchResponse<LearningResource>> searchImpl(
    ExploreFilterState filterState,
    int? offset,
  ) async {
    return searchService.searchLearningResources(
      filter: _getLearningResourcesFilter(filterState),
      offset: offset ?? 0,
    );
  }

  LearningResourceSearchFilter _getLearningResourcesFilter(
    ExploreFilterState filterState,
  ) {
    return LearningResourceSearchFilter(
      causeIds: filterState.filterCauseIds.isEmpty
          ? null
          : filterState.filterCauseIds.toList(),
      timeBrackets: filterState.filterTimeBrackets.isEmpty
          ? null
          : filterState.filterTimeBrackets.toList(),
      // TODO Add learning resource types
      // types:
      //this.filterActionTypes.isEmpty ? null : filterActionTypes.toList(),
      completed: filterState.filterCompleted == true ? true : null,
      recommended: filterState.filterRecommended == true ? true : null,
      releasedSince: filterState.filterNew == true ? newSinceDate() : null,
      query: filterState.queryText,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:nowu/services/causes_service.dart';
import 'package:nowu/services/model/search/search_response.dart';
import 'package:nowu/services/search_service.dart';
import 'package:nowu/ui/views/explore/bloc/explore_filter_state.dart';
import 'package:nowu/ui/views/explore/bloc/tabs/explore_all_tab_bloc.dart';
import 'package:nowu/utils/new_since.dart';

import './explore_tab_bloc.dart';

abstract class ExploreLearningResourceSectionBloc<TSearchContext> extends ExploreSectionBloc<LearningResource, TSearchContext> {
  ExploreLearningResourceSectionBloc({
    required SearchService searchService,
    required CausesService causesService,
  }) : super(
          initialState: ExploreTabState.initial(),
          searchService: searchService,
          causesService: causesService,
        );

  Logger _logger = Logger('ExploreLearningResourceSectionBloc');

  @override
  Future<SearchResponse<LearningResource>> searchImpl(
    TSearchContext searchContext,
    int? offset,
  ) async {
    _logger.info('Searching learning resources searchContext=$searchContext offset=$offset');

    return await searchService.searchLearningResources(
      filter: getLearningResourcesFilter(searchContext),
      offset: offset ?? 0,
    );
  }

  @protected
  LearningResourceSearchFilter getLearningResourcesFilter(TSearchContext filterState);
}

class ExploreLearningResourceTabBloc extends ExploreLearningResourceSectionBloc<ExploreFilterState> {
  ExploreLearningResourceTabBloc({
    required SearchService searchService,
    required CausesService causesService,
  }) : super(
          searchService: searchService,
          causesService: causesService,
        );

  @override
  LearningResourceSearchFilter getLearningResourcesFilter(
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

class ExploreAllTabLearningResourceSectionBloc extends ExploreLearningResourceSectionBloc<ExploreFilterState> {
  ExploreAllTabLearningResourceSectionBloc({
    required SearchService searchService,
    required CausesService causesService,
  }) : super(
          searchService: searchService,
          causesService: causesService,
        );

  LearningResourceSearchFilter getLearningResourcesFilter(
    ExploreFilterState filterState,
  ) {
    final baseFilter = getAllTabFilterState(filterState);
    return LearningResourceSearchFilter(
      causeIds: baseFilter.causeIds, 
      query: baseFilter.query,
      releasedSince: baseFilter.releasedSince,
    );
  }
}

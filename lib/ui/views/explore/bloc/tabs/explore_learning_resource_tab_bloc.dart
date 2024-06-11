import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:nowu/services/causes_service.dart';
import 'package:nowu/services/model/search/search_response.dart';
import 'package:nowu/services/search_service.dart';
import 'package:nowu/ui/paging/paging_state.dart';
import 'package:nowu/ui/views/explore/bloc/explore_filter_state.dart';
import 'package:nowu/ui/views/explore/bloc/tabs/explore_all_tab_bloc.dart';
import 'package:nowu/ui/views/explore/explore_page_viewmodel.dart';
import 'package:nowu/utils/new_since.dart';

import './explore_tab_bloc.dart';

abstract class ExploreLearningResourceSectionBloc extends ExploreTabBloc<LearningResource> {
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
  Future<SearchResponse<ExploreTileData<LearningResource>>> searchImpl(
    ExploreFilterState filterState,
    int? offset,
  ) async {
    _logger.info('Searching learning resources filterState=$filterState offset=$offset');

    final result = await searchService.searchLearningResources(
      filter: getLearningResourcesFilter(filterState),
      offset: offset ?? 0,
    );

    return SearchResponse(
      items: result.items
          .map(
            (item) => ExploreTileData<LearningResource>(
              item: item,
              isCompleted: causesService.actionIsComplete(item.id),
            ),
          )
          .toList(),
      hasReachedMax: result.hasReachedMax,
    );
  }

  @protected
  LearningResourceSearchFilter getLearningResourcesFilter(ExploreFilterState filterState);
}

class ExploreLearningResourceTabBloc extends ExploreLearningResourceSectionBloc {
  ExploreLearningResourceTabBloc({
    required SearchService searchService,
    required CausesService causesService,
  }) : super(
          searchService: searchService,
          causesService: causesService,
        );

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

class ExploreAllTabLearningResourceSectionBloc extends ExploreLearningResourceSectionBloc {
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

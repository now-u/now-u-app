import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:nowu/services/causes_service.dart';
import 'package:nowu/services/model/search/search_response.dart';
import 'package:nowu/services/search_service.dart';
import 'package:nowu/ui/views/explore/bloc/explore_filter_state.dart';
import 'package:nowu/ui/views/explore/bloc/tabs/explore_all_tab_bloc.dart';
import 'package:nowu/utils/new_since.dart';

import './explore_tab_bloc.dart';

abstract class ExploreActionSectionBloc extends ExploreTabBloc<ListAction> {
  ExploreActionSectionBloc({
    required SearchService searchService,
    required CausesService causesService,
  }) : super(
          initialState: ExploreTabState.initial(),
          searchService: searchService,
          causesService: causesService,
        );

  Logger _logger = Logger('ExploreActionSectionBloc');

  @override
  Future<SearchResponse<ListAction>> searchImpl(
    ExploreFilterState filterState,
    int? offset,
  ) async {
    _logger.info('Searching actions filterState=$filterState offset=$offset');

    return await searchService.searchActions(
      filter: getActionsFilter(filterState),
      offset: offset ?? 0,
    );
  }

  @protected
  ActionSearchFilter getActionsFilter(ExploreFilterState filterState);
}

class ExploreActionTabBloc extends ExploreActionSectionBloc {
  ExploreActionTabBloc({
    required SearchService searchService,
    required CausesService causesService,
  }) : super(
          searchService: searchService,
          causesService: causesService,
        );

  ActionSearchFilter getActionsFilter(ExploreFilterState filterState) {
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

class ExploreAllTabActionSectionBloc extends ExploreActionSectionBloc {
  Logger _logger = Logger('ExploreAllTabActionSectionBloc');

  ExploreAllTabActionSectionBloc({
    required SearchService searchService,
    required CausesService causesService,
  }) : super(
          searchService: searchService,
          causesService: causesService,
        );

  ActionSearchFilter getActionsFilter(ExploreFilterState filterState) {
    final baseFilter = getAllTabFilterState(filterState);
    return ActionSearchFilter(
      causeIds: baseFilter.causeIds,
      query: baseFilter.query,
      releasedSince: baseFilter.releasedSince,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:nowu/services/causes_service.dart';
import 'package:nowu/services/model/search/search_response.dart';
import 'package:nowu/services/search_service.dart';
import 'package:nowu/ui/views/explore/bloc/explore_filter_state.dart';
import 'package:nowu/ui/views/explore/bloc/tabs/explore_all_tab_bloc.dart';
import 'package:nowu/utils/new_since.dart';

import './explore_tab_bloc.dart';

abstract class ExploreActionSectionBloc<TSearchContext> extends ExploreSectionBloc<ListAction, TSearchContext> {
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
    TSearchContext filterState,
    int? offset,
  ) async {
    _logger.info('Searching actions filterState=$filterState offset=$offset');

    return await searchService.searchActions(
      filter: await getActionsFilter(searchContext: filterState),
      offset: offset ?? 0,
    );
  }

  @protected
  Future<ActionSearchFilter> getActionsFilter({ required TSearchContext searchContext });
}

class ExploreActionTabBloc extends ExploreActionSectionBloc<ExploreFilterState> {
  ExploreActionTabBloc({
    required SearchService searchService,
    required CausesService causesService,
  }) : super(
          searchService: searchService,
          causesService: causesService,
        );

  Future<ActionSearchFilter> getActionsFilter({ required searchContext }) async {
    return ActionSearchFilter(
      causeIds: searchContext.filterCauseIds.isEmpty
          ? null
          : searchContext.filterCauseIds.toList(),
      timeBrackets: searchContext.filterTimeBrackets.isEmpty
          ? null
          : searchContext.filterTimeBrackets.toList(),
      types: searchContext.filterActionTypes.isEmpty
          ? null
          : searchContext.filterActionTypes.toList(),
      completed: searchContext.filterCompleted == true ? true : null,
      recommended: searchContext.filterRecommended == true ? true : null,
      releasedSince: searchContext.filterNew == true ? newSinceDate() : null,
      query: searchContext.queryText,
    );
  }
}

class ExploreAllTabActionSectionBloc extends ExploreActionSectionBloc<ExploreFilterState> {
  Logger _logger = Logger('ExploreAllTabActionSectionBloc');

  ExploreAllTabActionSectionBloc({
    required SearchService searchService,
    required CausesService causesService,
  }) : super(
          searchService: searchService,
          causesService: causesService,
        );

  Future<ActionSearchFilter> getActionsFilter({ required searchContext }) async {
    final baseFilter = getAllTabFilterState(searchContext);
    return ActionSearchFilter(
      causeIds: baseFilter.causeIds,
      query: baseFilter.query,
      releasedSince: baseFilter.releasedSince,
    );
  }
}

class HomeActionSectionBloc extends ExploreActionSectionBloc<void> {
  HomeActionSectionBloc({
    required SearchService searchService,
    required CausesService causesService,
  }) : super(
          searchService: searchService,
          causesService: causesService,
        );

  @override
  Future<ActionSearchFilter> getActionsFilter({ void searchContext = null }) async {
    return ActionSearchFilter(
      causeIds: (await causesService.getUserInfo())?.selectedCausesIds,
      completed: false,
    );
  }
}

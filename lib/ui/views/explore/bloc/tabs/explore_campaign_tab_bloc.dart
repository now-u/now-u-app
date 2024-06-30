import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:nowu/services/causes_service.dart';
import 'package:nowu/services/model/search/search_response.dart';
import 'package:nowu/services/search_service.dart';
import 'package:nowu/ui/views/explore/bloc/explore_filter_state.dart';
import 'package:nowu/ui/views/explore/bloc/tabs/explore_all_tab_bloc.dart';
import 'package:nowu/utils/new_since.dart';

import './explore_tab_bloc.dart';

abstract class ExploreCampaignSectionBloc<TSearchContext> extends ExploreSectionBloc<ListCampaign, TSearchContext> {
  ExploreCampaignSectionBloc({
    required SearchService searchService,
    required CausesService causesService,
  }) : super(
          initialState: ExploreTabState.initial(),
          searchService: searchService,
          causesService: causesService,
        );

  Logger _logger = Logger('ExploreCampaignSectionBloc');

  @override
  Future<SearchResponse<ListCampaign>> searchImpl(
    TSearchContext searchContext,
    int? offset,
  ) async {
    _logger.info('Searching campaigns filterState=$searchContext offset=$offset');

    return await searchService.searchCampaigns(
      filter: await getCampaignsFilter(searchContext: searchContext),
      offset: offset ?? 0,
    );
  }

  @protected
  Future<CampaignSearchFilter> getCampaignsFilter({ required TSearchContext searchContext });
}

class ExploreCampaignTabBloc extends ExploreCampaignSectionBloc<ExploreFilterState> {
  ExploreCampaignTabBloc({
    required SearchService searchService,
    required CausesService causesService,
  }) : super(
          searchService: searchService,
          causesService: causesService,
        );

  Future<CampaignSearchFilter> getCampaignsFilter({ required ExploreFilterState searchContext }) async {
    return CampaignSearchFilter(
      causeIds: searchContext.filterCauseIds.isEmpty
          ? null
          : searchContext.filterCauseIds.toList(),
      completed: searchContext.filterCompleted == true ? true : null,
      recommended: searchContext.filterRecommended == true ? true : null,
      releasedSince: searchContext.filterNew == true ? newSinceDate() : null,
      query: searchContext.queryText,
    );
  }
}

class ExploreAllTabCampaignSectionBloc extends ExploreCampaignSectionBloc<ExploreFilterState> {
  ExploreAllTabCampaignSectionBloc({
    required SearchService searchService,
    required CausesService causesService,
  }) : super(
          searchService: searchService,
          causesService: causesService,
        );

  Future<CampaignSearchFilter> getCampaignsFilter({ required ExploreFilterState searchContext }) async {
    final baseFilter = getAllTabFilterState(searchContext);
    return CampaignSearchFilter(
      causeIds: baseFilter.causeIds, 
      query: baseFilter.query,
      releasedSince: baseFilter.releasedSince,
    );
  }
}

class HomePageSearchContext {
  Set<String> selectedCausesIds;

  HomePageSearchContext({
    required this.selectedCausesIds,
  });
}

class HomeOfTheMonthCampaignSectionBloc extends ExploreCampaignSectionBloc<void> {

  HomeOfTheMonthCampaignSectionBloc({
    required SearchService searchService,
    required CausesService causesService,
  }) : super(
          searchService: searchService,
          causesService: causesService,
        );

  @override
  Future<CampaignSearchFilter> getCampaignsFilter({ void searchContext = null }) async {
    return CampaignSearchFilter(
      // TODO Should we take this in as context (and re call search from the view listening to the CausesBloc) 
      // or should we listen to the causes service repository and internally recall search?
      causeIds: (await causesService.getUserInfo())?.selectedCausesIds,
      ofTheMonth: true,
      completed: false,
    );
  }
}

class HomeRecommenedCampaignSectionBloc extends ExploreCampaignSectionBloc<void> {
  HomeRecommenedCampaignSectionBloc({
    required SearchService searchService,
    required CausesService causesService,
  }) : super(
          searchService: searchService,
          causesService: causesService,
        );

  @override
  Future<CampaignSearchFilter> getCampaignsFilter({ void searchContext = null }) async {
    return CampaignSearchFilter(
      causeIds: (await causesService.getUserInfo())?.selectedCausesIds,
      completed: false,
      ofTheMonth: false,
    );
  }
}

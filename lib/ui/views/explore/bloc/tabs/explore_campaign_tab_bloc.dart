import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:nowu/services/causes_service.dart';
import 'package:nowu/services/model/search/search_response.dart';
import 'package:nowu/services/search_service.dart';
import 'package:nowu/ui/views/explore/bloc/explore_filter_state.dart';
import 'package:nowu/ui/views/explore/bloc/tabs/explore_all_tab_bloc.dart';
import 'package:nowu/ui/views/explore/explore_page_viewmodel.dart';
import 'package:nowu/utils/new_since.dart';

import './explore_tab_bloc.dart';

abstract class ExploreCampaignSectionBloc extends ExploreTabBloc<ListCampaign> {
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
  Future<SearchResponse<ExploreTileData<ListCampaign>>> searchImpl(
    ExploreFilterState filterState,
    int? offset,
  ) async {
    _logger.info('Searching campaigns filterState=$filterState offset=$offset');

    final result = await searchService.searchCampaigns(
      filter: getCampaignsFilter(filterState),
      offset: offset ?? 0,
    );

    return SearchResponse(
      items: result.items
          .map(
            (item) => ExploreTileData<ListCampaign>(
              item: item,
              isCompleted: causesService.campaignIsComplete(item.id),
            ),
          )
          .toList(),
      hasReachedMax: result.hasReachedMax,
    );
  }

  @protected
  CampaignSearchFilter getCampaignsFilter(ExploreFilterState filterState);
}

class ExploreCampaignTabBloc extends ExploreCampaignSectionBloc {
  ExploreCampaignTabBloc({
    required SearchService searchService,
    required CausesService causesService,
  }) : super(
          searchService: searchService,
          causesService: causesService,
        );

  CampaignSearchFilter getCampaignsFilter(ExploreFilterState filterState) {
    return CampaignSearchFilter(
      causeIds: filterState.filterCauseIds.isEmpty
          ? null
          : filterState.filterCauseIds.toList(),
      completed: filterState.filterCompleted == true ? true : null,
      recommended: filterState.filterRecommended == true ? true : null,
      releasedSince: filterState.filterNew == true ? newSinceDate() : null,
      query: filterState.queryText,
    );
  }
}

class ExploreAllTabCampaignSectionBloc extends ExploreCampaignSectionBloc {
  ExploreAllTabCampaignSectionBloc({
    required SearchService searchService,
    required CausesService causesService,
  }) : super(
          searchService: searchService,
          causesService: causesService,
        );

  CampaignSearchFilter getCampaignsFilter(ExploreFilterState filterState) {
    final baseFilter = getAllTabFilterState(filterState);
    return CampaignSearchFilter(
      causeIds: baseFilter.causeIds, 
      query: baseFilter.query,
      releasedSince: baseFilter.releasedSince,
    );
  }
}

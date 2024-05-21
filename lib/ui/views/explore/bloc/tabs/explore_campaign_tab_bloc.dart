import 'package:nowu/services/causes_service.dart';
import 'package:nowu/services/model/search/search_response.dart';
import 'package:nowu/services/search_service.dart';
import 'package:nowu/ui/paging/paging_state.dart';
import 'package:nowu/ui/views/explore/bloc/explore_filter_state.dart';
import 'package:nowu/utils/new_since.dart';

import './explore_tab_bloc.dart';

class ExploreCampaignTabBloc extends ExploreTabBloc<ListCampaign> {
  ExploreCampaignTabBloc({
    required SearchService searchService,
  }) : super(
          initialState: const ExploreTabState<ListCampaign>(
            data: const InitialLoading<ListCampaign>(),
          ),
          searchService: searchService,
        );

  Future<SearchResponse<ListCampaign>> searchImpl(
    ExploreFilterState filterState,
    int? offset,
  ) async {
    return searchService.searchCampaigns(
      filter: _getCampaignsFilter(filterState),
      offset: offset ?? 0,
    );
  }

  CampaignSearchFilter _getCampaignsFilter(ExploreFilterState filterState) {
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

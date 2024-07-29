import 'package:nowu/services/search_service.dart';
import 'package:nowu/ui/views/explore/bloc/explore_filter_state.dart';
import 'package:nowu/utils/new_since.dart';

// Explore all tab only filters on causes, news and search
BaseResourceSearchFilter getAllTabFilterState(ExploreFilterState filterState) {
  return BaseResourceSearchFilter(
    causeIds: filterState.filterCauseIds.isEmpty
        ? null
        : filterState.filterCauseIds.toList(),
    query: filterState.queryText,
    releasedSince: filterState.filterNew == true ? newSinceDate() : null,
  );
}

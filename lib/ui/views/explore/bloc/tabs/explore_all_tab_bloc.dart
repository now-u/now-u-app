import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';
import 'package:nowu/models/action.dart';
import 'package:nowu/models/exploreable.dart';
import 'package:nowu/services/causes_service.dart';
import 'package:nowu/services/model/search/search_response.dart';
import 'package:nowu/services/search_service.dart';
import 'package:nowu/services/user_service.dart';
import 'package:nowu/ui/paging/paging_state.dart';
import 'package:nowu/ui/views/explore/bloc/explore_filter_state.dart';
import 'package:nowu/ui/views/explore/bloc/tabs/explore_tab_bloc.dart';
import 'package:nowu/ui/views/explore/explore_page_viewmodel.dart';
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

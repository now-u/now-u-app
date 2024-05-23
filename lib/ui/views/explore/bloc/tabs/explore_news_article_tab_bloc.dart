import 'package:nowu/models/article.dart';
import 'package:nowu/services/model/search/search_response.dart';
import 'package:nowu/services/search_service.dart';
import 'package:nowu/ui/paging/paging_state.dart';
import 'package:nowu/ui/views/explore/bloc/explore_filter_state.dart';
import 'package:nowu/utils/new_since.dart';

import './explore_tab_bloc.dart';

class ExploreNewsArticleTabBloc extends ExploreTabBloc<NewsArticle> {
  ExploreNewsArticleTabBloc({
    required SearchService searchService,
  }) : super(
          initialState: const ExploreTabState<NewsArticle>(
            data: const InitialLoading<NewsArticle>(),
          ),
          searchService: searchService,
        );

  Future<SearchResponse<NewsArticle>> searchImpl(
    ExploreFilterState filterState,
    int? offset,
  ) async {
    return searchService.searchNewsArticles(
      filter: _getNewsArticlesFilter(filterState),
      offset: offset ?? 0,
    );
  }

  NewsArticleSearchFilter _getNewsArticlesFilter(
    ExploreFilterState filterState,
  ) {
    return NewsArticleSearchFilter(
      causeIds: filterState.filterCauseIds.isEmpty
          ? null
          : filterState.filterCauseIds.toList(),
      releasedSince: filterState.filterNew == true ? newSinceDate() : null,
      query: filterState.queryText,
    );
  }
}

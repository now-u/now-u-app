import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:nowu/models/article.dart';
import 'package:nowu/services/causes_service.dart';
import 'package:nowu/services/model/search/search_response.dart';
import 'package:nowu/services/search_service.dart';
import 'package:nowu/ui/views/explore/bloc/explore_filter_state.dart';
import 'package:nowu/ui/views/explore/bloc/tabs/explore_all_tab_bloc.dart';
import 'package:nowu/utils/new_since.dart';

import './explore_tab_bloc.dart';

abstract class ExploreNewsArticleSectionBloc<TSearchContext> extends ExploreSectionBloc<NewsArticle, TSearchContext> {
  ExploreNewsArticleSectionBloc({
    required SearchService searchService,
    required CausesService causesService,
  }) : super(
          initialState: ExploreTabState.initial(),
          searchService: searchService,
          causesService: causesService,
        );

  Logger _logger = Logger('ExploreNewsArticleTabBloc');

  @override
  Future<SearchResponse<NewsArticle>> searchImpl(
    TSearchContext filterState,
    int? offset,
  ) async {
    _logger.info('Searching news articles filterState=$filterState offset=$offset');

    return await searchService.searchNewsArticles(
      filter: await getNewsArticlesFilter(searchContext: filterState),
      offset: offset ?? 0,
    );
  }

  @protected
  Future<NewsArticleSearchFilter> getNewsArticlesFilter({ required TSearchContext searchContext });
}

class ExploreNewsArticleTabBloc extends ExploreNewsArticleSectionBloc<ExploreFilterState> {
  ExploreNewsArticleTabBloc({
    required SearchService searchService,
    required CausesService causesService,
  }) : super(
          searchService: searchService,
          causesService: causesService,
        );

  Future<NewsArticleSearchFilter> getNewsArticlesFilter({
    required searchContext,
  }) async {
    return NewsArticleSearchFilter(
      causeIds: searchContext.filterCauseIds.isEmpty
          ? null
          : searchContext.filterCauseIds.toList(),
      releasedSince: searchContext.filterNew == true ? newSinceDate() : null,
      query: searchContext.queryText,
    );
  }
}

class ExploreAllTabNewsArticleSectionBloc extends ExploreNewsArticleSectionBloc<ExploreFilterState> {
  ExploreAllTabNewsArticleSectionBloc({
    required SearchService searchService,
    required CausesService causesService,
  }) : super(
          searchService: searchService,
          causesService: causesService,
        );

  Future<NewsArticleSearchFilter> getNewsArticlesFilter({
    required searchContext,
  }) async {
    final baseFilter = getAllTabFilterState(searchContext);
    return NewsArticleSearchFilter(
      causeIds: baseFilter.causeIds,
      query: baseFilter.query,
      releasedSince: baseFilter.releasedSince,
    );
  }
}

class HomeNewsArticleSectionBloc extends ExploreNewsArticleSectionBloc<void> {
  HomeNewsArticleSectionBloc({
    required SearchService searchService,
    required CausesService causesService,
  }) : super(
          searchService: searchService,
          causesService: causesService,
        );

  @override
  Future<NewsArticleSearchFilter> getNewsArticlesFilter({ void searchContext = null }) async {
    return NewsArticleSearchFilter(
      causeIds: (await causesService.getUserInfo())?.selectedCausesIds,
    );
  }
}

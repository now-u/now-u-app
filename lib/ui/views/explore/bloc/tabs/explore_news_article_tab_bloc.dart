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
      filter: getNewsArticlesFilter(filterState),
      offset: offset ?? 0,
    );
  }

  @protected
  NewsArticleSearchFilter getNewsArticlesFilter(TSearchContext filterState);
}

class ExploreNewsArticleTabBloc extends ExploreNewsArticleSectionBloc<ExploreFilterState> {
  ExploreNewsArticleTabBloc({
    required SearchService searchService,
    required CausesService causesService,
  }) : super(
          searchService: searchService,
          causesService: causesService,
        );

  NewsArticleSearchFilter getNewsArticlesFilter(
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

class ExploreAllTabNewsArticleSectionBloc extends ExploreNewsArticleSectionBloc<ExploreFilterState> {
  ExploreAllTabNewsArticleSectionBloc({
    required SearchService searchService,
    required CausesService causesService,
  }) : super(
          searchService: searchService,
          causesService: causesService,
        );

  NewsArticleSearchFilter getNewsArticlesFilter(
    ExploreFilterState filterState,
  ) {
    final baseFilter = getAllTabFilterState(filterState);
    return NewsArticleSearchFilter(
      causeIds: baseFilter.causeIds,
      query: baseFilter.query,
      releasedSince: baseFilter.releasedSince,
    );
  }
}

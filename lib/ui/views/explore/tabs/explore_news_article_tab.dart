import 'package:flutter/material.dart';
import 'package:nowu/assets/components/explore_tiles.dart';
import 'package:nowu/locator.dart';
import 'package:nowu/models/article.dart';
import 'package:nowu/services/causes_service.dart';
import 'package:nowu/services/search_service.dart';
import 'package:auto_route/auto_route.dart';

import '../bloc/tabs/explore_news_article_tab_bloc.dart';
import '../filters/explore_filter_chip.dart';
import 'explore_tab.dart';

@RoutePage()
class ExploreNewsArticleTab extends ExploreTab<NewsArticle> {
  const ExploreNewsArticleTab({Key? key}) : super(key: key);

  @override
  createBloc(context) {
    return ExploreNewsArticleTabBloc(searchService: locator<SearchService>(), causesService: locator<CausesService>());
  }

  @override
  buildFilterChips() {
    return [
      const CausesFilter(),
      const CompletedFilter(),
    ];
  }

  @override
  Widget itemBuilder(newsArticle) {
    return Container(
      // TODO Create shared constant for these/ pull. from ExploreSectionArgs
      height: 400,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: ExploreNewsArticleTile(newsArticle),
      ),
    );
  }
}

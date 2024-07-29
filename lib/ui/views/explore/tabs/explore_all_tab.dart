import 'package:flutter/material.dart';
import 'package:nowu/assets/components/explore_tiles.dart';
import 'package:nowu/locator.dart';
import 'package:nowu/models/article.dart';
import 'package:nowu/router.gr.dart';
import 'package:nowu/services/causes_service.dart';
import 'package:nowu/services/search_service.dart';
import 'package:nowu/ui/views/explore/bloc/tabs/explore_action_tab_bloc.dart';
import 'package:nowu/ui/views/explore/bloc/tabs/explore_campaign_tab_bloc.dart';
import 'package:nowu/ui/views/explore/bloc/tabs/explore_learning_resource_tab_bloc.dart';
import 'package:nowu/ui/views/explore/bloc/tabs/explore_news_article_tab_bloc.dart';
import 'package:nowu/ui/views/explore/explore_section_view.dart';
import 'package:auto_route/auto_route.dart';

import '../filters/explore_filter_chip.dart';
import 'explore_tab_horizontal.dart';

@RoutePage()
class ExploreAllTab extends StatelessWidget {
  const ExploreAllTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExploreTabHorizontal(
      filterChips: [
        const CausesFilter(),
        const NewFilter(),
      ],
      exploreSections: [
        ExploreSection<ListCampaign>(
          title: 'Campaigns',
          description:
              'Join members of the now-u community in coordinated campaigns to make a difference',
          titleOnClick: () => context.router.push(
            TabsRoute(
              children: [
                ExploreRoute(
                  children: [
                    const ExploreCampaignRoute(),
                  ],
                ),
              ],
            ),
          ),
          buildTile: (item) => ExploreCampaignTile(item),
          buildBloc: () => ExploreAllTabCampaignSectionBloc(
            searchService: locator<SearchService>(),
            causesService: locator<CausesService>(),
          ),
          tileHeight: CAMPIGN_TILE_HEIGHT,
        ),
        ExploreSection<ListAction>(
          title: 'Actions',
          description:
              'Take a wide range of actions to drive lasting change for issues you care about',
          titleOnClick: () => context.router.push(
            TabsRoute(
              children: [
                ExploreRoute(
                  children: [
                    const ExploreActionRoute(),
                  ],
                ),
              ],
            ),
          ),
          buildTile: (item) => ExploreActionTile(item),
          buildBloc: () => ExploreAllTabActionSectionBloc(
            searchService: locator<SearchService>(),
            causesService: locator<CausesService>(),
          ),
          tileHeight: RESOURCE_TILE_HEIGHT,
        ),
        ExploreSection<LearningResource>(
          title: 'Learn',
          description:
              'Learn more about key topics of pressing social and environmental issues',
          titleOnClick: () => context.router.push(
            TabsRoute(
              children: [
                ExploreRoute(
                  children: [
                    const ExploreLearningResourceRoute(),
                  ],
                ),
              ],
            ),
          ),
          buildTile: (item) => ExploreLearningResourceTile(item),
          buildBloc: () => ExploreAllTabLearningResourceSectionBloc(
            searchService: locator<SearchService>(),
            causesService: locator<CausesService>(),
          ),
          tileHeight: RESOURCE_TILE_HEIGHT,
        ),
        ExploreSection<NewsArticle>(
          title: 'News',
          description:
              'Find out what’s going on in the world this week in relation to your chosen causes',
          titleOnClick: () => context.router.push(
            TabsRoute(
              children: [
                ExploreRoute(
                  children: [
                    const ExploreNewsArticleRoute(),
                  ],
                ),
              ],
            ),
          ),
          buildTile: (item) => ExploreNewsArticleTile(item),
          buildBloc: () => ExploreAllTabNewsArticleSectionBloc(
            searchService: locator<SearchService>(),
            causesService: locator<CausesService>(),
          ),
          tileHeight: ARTICLE_TILE_HEIGHT,
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:nowu/ui/views/explore/explore_page_view.dart';
import 'package:nowu/ui/views/explore/explore_section_view.dart';

import '../explore_page_viewmodel.dart';
import '../filters/explore_filter_chip.dart';
import 'explore_tab_horizontal.dart';

class ExploreAllTab extends StatelessWidget {
  final ExplorePageViewModel viewModel;
  final void Function(ExploreTabKey tab) changeTab;

  const ExploreAllTab(this.viewModel, this.changeTab, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExploreTabHorizontal(
      filterChips: [
        const CausesFilter(),
        const NewFilter(),
      ],
      filterResults: [
        CampaignExploreSection(
          title: 'Campaigns',
          description:
              'Join members of the now-u community in coordinated campaigns to make a difference',
          titleOnClick: () => changeTab(ExploreTabKey.CAMPAIGN),
          tiles: viewModel.allSearchResult?.campaigns.map(
            (campaign) => CampaignExploreTileData(
              campaign,
              viewModel.isCampaignComplete(campaign),
            ),
          ),
          // TODO Handle loading state
          isLoading: viewModel.allSearchResult == null,
        ),
        ActionExploreSection(
          title: 'Actions',
          description:
              'Take a wide range of actions to drive lasting change for issues you care about',
          titleOnClick: () => changeTab(ExploreTabKey.ACTIONS),
          tiles: viewModel.allSearchResult?.actions.map(
            (action) => ActionExploreTileData(
              action,
              viewModel.isActionComplete(action),
            ),
          ),
          // TODO Handle loading state
          isLoading: viewModel.allSearchResult == null,
        ),
        LearningResourceExploreSection(
          title: 'Learn',
          description:
              'Learn more about key topics of pressing social and environmental issues',
          titleOnClick: () => changeTab(ExploreTabKey.LEARN),
          tileOnClick: (tileData) =>
              viewModel.openLearningResource(tileData.learningResource),
          tiles: viewModel.allSearchResult?.learningResources.map(
            (learningResource) => LearningResourceExploreTileData(
              learningResource,
              viewModel.isLearningResourceComplete(learningResource),
            ),
          ),
          // TODO Handle loading state
          isLoading: viewModel.allSearchResult == null,
        ),
        NewsArticleExploreSection(
          title: 'News',
          description:
              'Find out what’s going on in the world this week in relation to your chosen causes',
          // TODO Link to actions tab
          tiles: viewModel.allSearchResult?.newsArticles
              .map((newsArticle) => NewsArticleExploreTileData(newsArticle)),
          // TODO Handle loading state
          isLoading: viewModel.allSearchResult == null,
        ),
      ],
    );
  }
}

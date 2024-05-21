import 'package:flutter/material.dart';
import 'package:nowu/assets/components/explore_tiles.dart';
import 'package:nowu/locator.dart';
import 'package:nowu/services/search_service.dart';
import 'package:nowu/ui/views/explore/bloc/tabs/explore_learning_resource_tab_bloc.dart';

import '../explore_page_viewmodel.dart';
import '../filters/explore_filter_chip.dart';
import 'explore_tab.dart';

class ExploreLearningResourceTab extends StatelessWidget {
  final ExplorePageViewModel viewModel;

  const ExploreLearningResourceTab(this.viewModel, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExploreTab(
      createBloc: (context) => ExploreLearningResourceTabBloc(
          searchService: locator<SearchService>()),
      filterChips: [
        const CausesFilter(),
        const TimeFilter(),
        const NewFilter(),
        const RecommendedFilter(),
        const CompletedFilter(),
      ],
      itemBuilder: (learningResource) => Container(
        height: 160,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: ExploreLearningResourceTile(
            LearningResourceExploreTileData(
              learningResource,
              viewModel.isLearningResourceComplete(learningResource),
            ),
            onTap: () => viewModel.openLearningResource(learningResource),
          ),
        ),
      ),
    );
  }
}

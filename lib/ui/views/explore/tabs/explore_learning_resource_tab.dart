import 'package:flutter/material.dart';
import 'package:nowu/assets/components/explore_tiles.dart';

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
      filterChips: [
        CausesFilter(viewModel: viewModel),
        TimeFilter(viewModel: viewModel),
        NewFilter(viewModel: viewModel),
        RecommendedFilter(viewModel: viewModel),
        CompletedFilter(viewModel: viewModel),
      ],
      filterResults: viewModel.learningResources.map<Widget>(
        (learningResource) => Container(
          height: 160,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: ExploreLearningResourceTile(
              LearningResourceExploreTileData(learningResource,
                  viewModel.isLearningResourceComplete(learningResource)),
              onTap: () => viewModel.openLearningResource(learningResource),
            ),
          ),
        ),
      ),
    );
  }
}

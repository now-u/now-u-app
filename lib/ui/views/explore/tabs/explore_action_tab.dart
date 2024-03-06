import 'package:flutter/material.dart';
import 'package:nowu/assets/components/explore_tiles.dart';

import '../explore_page_viewmodel.dart';
import '../filters/explore_filter_chip.dart';
import 'explore_tab.dart';

class ExploreActionTab extends StatelessWidget {
  final ExplorePageViewModel viewModel;

  const ExploreActionTab(this.viewModel, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExploreTab(
      filterChips: [
        CausesFilter(viewModel: viewModel),
        TimeFilter(viewModel: viewModel),
        ExploreFilterChip(
          onSelected: (_) => viewModel.openActionTypesFilterSheet(),
          label: 'Type',
          isSelected: viewModel.filterData.filterActionTypes.isNotEmpty,
        ),
        NewFilter(viewModel: viewModel),
        RecommendedFilter(viewModel: viewModel),
        CompletedFilter(viewModel: viewModel),
      ],
      onBottomReached: () => {
        viewModel.loadMoreActions(),
      },
      pagingState: viewModel.actions,
      itemBuilder: (action) => Container(
        height: 160,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: ExploreActionTile(
            ActionExploreTileData(action, viewModel.isActionComplete(action)),
            onTap: () => viewModel.openAction(action),
          ),
        ),
      ),
    );
  }
}

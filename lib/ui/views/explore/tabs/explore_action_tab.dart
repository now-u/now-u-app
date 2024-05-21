import 'package:flutter/material.dart';
import 'package:nowu/assets/components/explore_tiles.dart';
import 'package:nowu/locator.dart';
import 'package:nowu/models/Action.dart';
import 'package:nowu/services/search_service.dart';
import 'package:nowu/ui/views/explore/bloc/tabs/explore_action_tab_bloc.dart';

import '../explore_page_viewmodel.dart';
import '../filters/explore_filter_chip.dart';
import 'explore_tab.dart';

class ExploreActionTab extends StatelessWidget {
  final ExplorePageViewModel viewModel;

  const ExploreActionTab(this.viewModel, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExploreTab<ListAction>(
      createBloc: (context) =>
          ExploreActionTabBloc(searchService: locator<SearchService>()),
      filterChips: [
        const CausesFilter(),
        const TimeFilter(),
        const ActionTypeFilter(),
        const NewFilter(),
        const RecommendedFilter(),
        const CompletedFilter(),
      ],
      itemBuilder: (action) => Container(
        height: 160,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: ExploreActionTile(
            ActionExploreTileData(action, viewModel.isActionComplete(action)),
          ),
        ),
      ),
    );
  }
}

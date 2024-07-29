import 'package:flutter/material.dart';
import 'package:nowu/assets/components/explore_tiles.dart';
import 'package:nowu/locator.dart';
import 'package:nowu/services/causes_service.dart';
import 'package:nowu/services/search_service.dart';
import 'package:nowu/ui/views/explore/bloc/tabs/explore_action_tab_bloc.dart';
import 'package:auto_route/auto_route.dart';

import '../filters/explore_filter_chip.dart';
import 'explore_tab.dart';

@RoutePage()
class ExploreActionTab extends ExploreTab<ListAction> {
  const ExploreActionTab({Key? key}) : super(key: key);

  @override
  createBloc(context) {
    return ExploreActionTabBloc(
      searchService: locator<SearchService>(),
      causesService: locator<CausesService>(),
    );
  }

  @override
  buildFilterChips() {
    return [
      const CausesFilter(),
      const TimeFilter(),
      const ActionTypeFilter(),
      const NewFilter(),
      const RecommendedFilter(),
      const CompletedFilter(),
    ];
  }

  @override
  Widget itemBuilder(data) {
    return Container(
      height: 160,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: ExploreActionTile(data),
      ),
    );
  }
}

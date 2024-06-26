import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nowu/models/exploreable.dart';
import 'package:nowu/ui/paging/paging_state.dart';
import 'package:nowu/ui/views/explore/bloc/explore_filter_bloc.dart';
import 'package:nowu/ui/views/explore/bloc/explore_filter_state.dart';
import 'package:nowu/ui/views/explore/bloc/tabs/explore_tab_bloc.dart';
import 'package:nowu/ui/views/explore/explore_section_view.dart';
import 'package:nowu/ui/views/explore/filters/explore_filter_chip.dart';

import 'filters_container.dart';

class ExploreSection<T extends Explorable> {
  double tileHeight;
  ExploreSectionBloc<T, ExploreFilterState> Function() buildBloc;
  Widget Function(T item) buildTile;

  void Function()? titleOnClick;

  String title;
  String description;

  ExploreSection({
    required this.tileHeight,
    required this.buildBloc,
    required this.buildTile,
    required this.title,
    required this.description,
    required this.titleOnClick,
  });

  Widget build(BuildContext context, ExploreFilterState filterState) {
    return BlocProvider(
      create: (_) => buildBloc()..search(filterState),
      child: BlocListener<ExploreFilterBloc, ExploreFilterState>(
        listener: (context, filterState) {
          context.read<ExploreSectionBloc<T, ExploreFilterState>>().search(filterState);
        },
        child: BlocBuilder<ExploreSectionBloc<T, ExploreFilterState>, ExploreTabState<T>>(
          builder: (context, state) {
            return ExploreSectionWidget(
              title: title,
              description: description,
              tileData: state.data.map((item) => buildTile(item as T)),
              titleOnClick: titleOnClick,
              tileHeight: tileHeight,
            );
          },
        ),
      ),
    );
  }
}

class ExploreTabHorizontal extends StatelessWidget {
  final Iterable<FilterConfig> filterChips;

  // TODO Update to take in list of blocs and then build and call list here
  final Iterable<ExploreSection> exploreSections;

  const ExploreTabHorizontal({
    required this.filterChips,
    required this.exploreSections,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExploreFilterBloc, ExploreFilterState>(
      builder: (context, filterState) {
        return ListView(
          children: [
            FiltersContainer(filterChips: filterChips),
            ...exploreSections
                .map((section) => section.build(context, filterState)),
          ],
        );
      },
    );
  }
}

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
  ExploreTabBloc<T> Function() buildBloc;
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
          context.read<ExploreTabBloc<T>>().search(filterState);
        },
        child: BlocBuilder<ExploreTabBloc<T>, ExploreTabState<T>>(
          builder: (context, state) {
            switch (state.data) {
              case InitialLoading():
                return ExploreSectionWidget(
                  tiles: [],
                  tileHeight: tileHeight,
                  titleOnClick: titleOnClick,
                  title: title,
                  description: description,
                  isLoading: true,
                );
              case Data(:final items):
                return ExploreSectionWidget(
                  // TODO Work out why this cast is needed??
                  tiles: items
                      .map((item) => buildTile(item as T)),
                  tileHeight: tileHeight,
                  titleOnClick: titleOnClick,
                  title: title,
                  description: description,
                  isLoading: false,
                );
            }
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

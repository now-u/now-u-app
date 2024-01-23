import 'package:flutter/material.dart';

import 'filters_container.dart';

class ExploreTabHorizontal extends StatelessWidget {
  final Iterable<Widget> filterChips;
  final Iterable<Widget> filterResults;

  const ExploreTabHorizontal({
    required this.filterChips,
    required this.filterResults,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: filterResults.length + 1,
      itemBuilder: (BuildContext context, int index) {
        if (index == 0) {
          return FiltersContainer(filterChips: filterChips);
        } else {
          return filterResults.toList()[index - 1];
        }
      },
    );
  }
}

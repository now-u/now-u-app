import 'package:flutter/material.dart';
import 'package:nowu/ui/views/explore/filters/explore_filter_chip.dart';
import 'package:nowu/utils/intersperse.dart';

class FiltersContainer extends StatelessWidget {
  const FiltersContainer({
    super.key,
    required this.filterChips,
  });

  final Iterable<FilterConfig> filterChips;

  @override
  Widget build(BuildContext context) {
    return Container(
      // TODO Do min height possible if possible
      height: 60,
      child: Align(
        alignment: Alignment.centerLeft,
        child: ListView(
          //TODO Not working and probbaly wrong place to define
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          children: filterChips
              .map<Widget>((config) => ExploreFilterChip(config))
              .intersperseOuter(const SizedBox(width: 8))
              .toList(),
        ),
      ),
    );
  }
}

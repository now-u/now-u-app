import 'package:flutter/material.dart';
import 'package:nowu/utils/intersperse.dart';

class ExploreTab extends StatelessWidget {
  final Iterable<Widget> filterChips;
  final Iterable<Widget> filterResults;

  const ExploreTab({required this.filterChips, required this.filterResults});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          // TODO Do min height possible if possible
          height: 60,
          child: Align(
            alignment: Alignment.centerLeft,
            child: ListView(
              //TODO Not working and probbaly wrong place to define
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              children: filterChips
                  .intersperseOuter(const SizedBox(width: 8))
                  .toList(),
            ),
          ),
        ),
        ...filterResults
            .intersperse(
              const SizedBox(
                height: 8,
              ),
            )
            .toList(),
        const SizedBox(
          height: 8,
        ),
      ],
    );
  }
}


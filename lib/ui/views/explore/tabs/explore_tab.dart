import 'package:flutter/material.dart';

import '../../../paging/paging_state.dart';
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

class ExploreTab<T> extends StatelessWidget {
  final Iterable<Widget> filterChips;
  final PagingState<T> pagingState;
  final VoidCallback onBottomReached;
  final Function(T) itemBuilder;

  const ExploreTab({
    required this.filterChips,
    required this.pagingState,
    required this.onBottomReached,
    required this.itemBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: itemCount(),
      itemBuilder: (BuildContext context, int index) {
        if (pagingState is Data && index == itemCount() - 1) {
          onBottomReached();
        }

        if (index == 0) {
          return FiltersContainer(filterChips: filterChips);
        } else if (pagingState is InitialLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (pagingState is LoadingMore && index == itemCount() - 1) {
          return Container(
            height: 60,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          return Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: itemBuilder(pagingState.items.toList()[index - 1]),
          );
        }
      },
    );
  }

  int itemCount() => pagingState.itemsCount() + 1;
}

import 'package:flutter/material.dart';

import '../../../paging/paging_state.dart';
import 'filters_container.dart';

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

  // +1 for the filter chips, +1 for the loading indicator if state is LoadingMore
  int itemCount() =>
      pagingState.items.length + (pagingState is LoadingMore ? 1 : 2);
}

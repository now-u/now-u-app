import 'package:flutter/material.dart';
import 'package:nowu/utils/intersperse.dart';

class ExploreTab extends StatelessWidget {
  final Iterable<Widget> filterChips;
  final Iterable<Widget> filterResults;
  final VoidCallback onBottomReached;

  const ExploreTab({
    required this.filterChips,
    required this.filterResults,
    required this.onBottomReached,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: filterResults.length + 1,
      itemBuilder: (BuildContext context, int index) {
        if (index == filterResults.length - 0) {
          onBottomReached();
        }

        if (index == 0) {
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
                    .intersperseOuter(const SizedBox(width: 8))
                    .toList(),
              ),
            ),
          );
        } else {
          // TODO: Pass list or map before
          return filterResults.toList()[index - 1];

          const SizedBox(height: 8);
        }
      },
    );
  }
}

class ExploreTabNew<T> extends StatelessWidget {
  final Iterable<Widget> filterChips;
  final PagingState<T> pagingState;
  final VoidCallback onBottomReached;
  final Function(T) itemBuilder;

  const ExploreTabNew({
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
        if (pagingState is Data && index == pagingState.items.length) {
          onBottomReached();
        }

        if (index == 0) {
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
                    .intersperseOuter(const SizedBox(width: 8))
                    .toList(),
              ),
            ),
          );
        } else {
          // TODO: Pass list or map before
          return itemBuilder(pagingState.items.toList()[index - 1]);

          const SizedBox(height: 8);
        }
      },
    );
  }

  int itemCount() {
    switch (pagingState.runtimeType) {
      case InitialLoading:
        return 1;
      case Data:
        return pagingState.items.length + 1;
      case LoadingMore:
        return pagingState.items.length + 2;
      default:
        throw Exception('Unknown state');
    }
  }
}

sealed class PagingState<T> {
  final List<T> items;
  final bool hasReachedMax;

  PagingState(this.items, this.hasReachedMax);

  int offset() => items.length;

  bool canLoadMore() => this is Data && !hasReachedMax;
}

class InitialLoading extends PagingState {
  InitialLoading() : super([], false);
}

class Data<T> extends PagingState {
  final List<T> items;
  final bool hasReachedMax;

  Data({
    required this.items,
    required this.hasReachedMax,
  }) : super(
          items,
          hasReachedMax,
        );
}

class LoadingMore<T> extends PagingState {
  final List<T> items;

  LoadingMore({required this.items}) : super(items, false);
}

// class Error extends PagingState {
//   final List<String> items;
//   final bool hasReachedMax;
//
//   Error(this.items, this.hasReachedMax) : super(items, hasReachedMax);
// }

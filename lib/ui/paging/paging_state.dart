sealed class PagingState<T> {
  final List<T> items;
  final bool hasReachedMax;

  PagingState(this.items, this.hasReachedMax);

  int offset() => items.length;

  bool canLoadMore() =>
      (this is InitialLoading || this is Data) && !hasReachedMax;

  int itemsCount() => this is LoadingMore ? items.length + 1 : items.length;
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

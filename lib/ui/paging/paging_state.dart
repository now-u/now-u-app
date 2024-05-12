sealed class PagingState<T> {}
sealed class PagingStateWithData<T> extends PagingState {
  final List<T> items;
  final bool hasReachedMax;

  PagingStateWithData({ required this.items, required this.hasReachedMax } );

  int offset() => items.length;
  int itemsCount() => items.length;

  bool canLoadMore() =>
      (this is InitialLoading || this is Data) && !hasReachedMax;
}

class InitialLoading<T> extends PagingState<T> {
  InitialLoading() : super();
}

class Data<T> extends PagingStateWithData {
  Data({
    required List<T> items,
    bool hasReachedMax = false,
  }) : super(
          items: items,
          hasReachedMax: hasReachedMax,
        );
}

class LoadingMore<T> extends PagingStateWithData {
  LoadingMore({
    required List<T> items,
  }) : super(
	items: items,
	hasReachedMax: false,
  );

  int offset() => items.length;
  int itemsCount() => items.length;

  bool canLoadMore() =>
      (this is InitialLoading || this is Data) && !hasReachedMax;
}

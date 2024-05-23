sealed class PagingState<T> {
  const PagingState();
}

class InitialLoading<T> extends PagingState<T> {
  const InitialLoading() : super();
}

class Data<T> extends PagingState<T> {
  final List<T> items;
  final bool hasReachedMax;
  final bool isLoadingMore;

  Data({
    required this.items,
    this.hasReachedMax = false,
    this.isLoadingMore = false,
  }) : super();
}

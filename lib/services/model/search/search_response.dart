class SearchResponse<T> {
  final List<T> items;
  final bool hasReachedMax;

  SearchResponse({
    required this.items,
    required this.hasReachedMax,
  });
}

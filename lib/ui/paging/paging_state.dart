import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nowu/services/model/search/search_response.dart';

part 'paging_state.freezed.dart';

sealed class PagingState<T> {
  const PagingState();
}

class InitialLoading<T> extends PagingState<T> {
  const InitialLoading() : super();
}

@freezed
class Data<T> extends PagingState<T> with _$Data<T> {
  const factory Data({
    required List<T> items,
    @Default(false) bool hasReachedMax,
    @Default(false) bool isLoadingMore,
  }) = _Data;

  factory Data.fromSearchResponse(SearchResponse<T> searchResponse) {
    return Data(
      items: searchResponse.items,
      hasReachedMax: searchResponse.hasReachedMax,
    );
  }
}

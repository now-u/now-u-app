import 'package:freezed_annotation/freezed_annotation.dart';

part 'search_response.freezed.dart';

@freezed
sealed class SearchResponse<T> with _$SearchResponse<T> {
  const factory SearchResponse({
    required List<T> items,
    required bool hasReachedMax,
  }) = _SearchResponse;
}

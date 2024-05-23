import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nowu/services/model/search/search_response.dart';
import 'package:nowu/services/search_service.dart';
import 'package:nowu/ui/paging/paging_state.dart';
import 'package:nowu/ui/views/explore/bloc/explore_filter_state.dart';

part 'explore_tab_bloc.freezed.dart';

@freezed
class ExploreTabState<T> with _$ExploreTabState {
  const factory ExploreTabState({
    required PagingState data,
  }) = _ExploreTabState;
}

abstract class ExploreTabBloc<T> extends Cubit<ExploreTabState<T>> {
  // TODO Protected
  SearchService searchService;

  ExploreTabBloc({
    required SearchService searchService,
    required ExploreTabState<T> initialState,
  })  : searchService = searchService,
        super(initialState);

  // TODO Protected
  Future<SearchResponse<T>> searchImpl(
    ExploreFilterState filterState,
    int? offset,
  );

  int _getSearchOffset() {
    switch (state.data) {
      case InitialLoading():
        return 0;
      case Data(:final items):
        return items.length;
    }
  }

  void search(ExploreFilterState filterState) async {
    final response = await searchImpl(filterState, _getSearchOffset());
    emit(
      state.copyWith(
        data: Data(
          items: response.items,
          hasReachedMax: response.hasReachedMax,
        ),
      ) as ExploreTabState<T>,
    );
  }
}

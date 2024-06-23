import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nowu/models/exploreable.dart';
import 'package:nowu/services/causes_service.dart';
import 'package:nowu/services/model/search/search_response.dart';
import 'package:nowu/services/search_service.dart';
import 'package:nowu/ui/paging/paging_state.dart';
import 'package:nowu/ui/views/explore/bloc/explore_filter_state.dart';

part 'explore_tab_bloc.freezed.dart';

@freezed
class ExploreTabState<T extends Explorable> with _$ExploreTabState {
  const factory ExploreTabState({
    required PagingState<T> data,
  }) = _ExploreTabState;

  factory ExploreTabState.initial() {
    return const ExploreTabState(data: const InitialLoading());
  }
}

abstract class ExploreTabBloc<T extends Explorable>
    extends Cubit<ExploreTabState<T>> {
  @protected
  SearchService searchService;

  @protected
  CausesService causesService;

  ExploreTabBloc({
    required this.searchService,
    required this.causesService,
    required ExploreTabState<T> initialState,
  }) : super(initialState);

  @protected
  Future<SearchResponse<T>> searchImpl(
    ExploreFilterState filterState,
    int? offset,
  );

  int _getSearchOffset(PagingState pagingState) {
    switch (pagingState) {
      case Data(:final items):
        return items.length;
      case InitialLoading():
        return 0;
    }
  }

  void search(
    ExploreFilterState filterState, {
    bool extendCurrentSearch = false,
  }) async {
    // Update the state showing so loading is happening
    switch (state.data) {
      case Data<T> dataState:
        {
          emit(
            state.copyWith(
              data: dataState.copyWith(
                isLoadingMore: true,
              ),
            ) as ExploreTabState<T>,
          );
        }
      default:
        break;
    }

    final response = await searchImpl(
      filterState,
      extendCurrentSearch ? _getSearchOffset(state.data) : 0,
    );

    emit(
      ExploreTabState(
        data: Data.fromSearchResponse(response),
      ),
    );
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nowu/models/exploreable.dart';
import 'package:nowu/services/causes_service.dart';
import 'package:nowu/services/model/search/search_response.dart';
import 'package:nowu/services/search_service.dart';
import 'package:nowu/ui/paging/paging_state.dart';

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

// TODO Ive added TContext here so we can have ExploreFilterState in some places
// and void on the home page...
// Will void actually work?? Is there a nice way of doing this...
abstract class ExploreSectionBloc<TExplorable extends Explorable, TContext>
    extends Cubit<ExploreTabState<TExplorable>> {
  @protected
  SearchService searchService;

  @protected
  CausesService causesService;

  ExploreSectionBloc({
    required this.searchService,
    required this.causesService,
    required ExploreTabState<TExplorable> initialState,
  }) : super(initialState);

  @protected
  Future<SearchResponse<TExplorable>> searchImpl(
    TContext searchContext,
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
    TContext filterState, {
    bool extendCurrentSearch = false,
  }) async {
    // Update the state showing so loading is happening
    switch (state.data) {
      case Data<TExplorable> dataState:
        {
          emit(
            state.copyWith(
              data: dataState.copyWith(
                isLoadingMore: true,
              ),
            ) as ExploreTabState<TExplorable>,
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

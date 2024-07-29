import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nowu/models/action.dart';
import 'package:nowu/services/causes_service.dart';
import 'package:tuple/tuple.dart';

part 'explore_filter_state.freezed.dart';

class ExplorePageFilterData {
  Set<int> filterCauseIds;
  Set<Tuple2<double, double>> filterTimeBrackets = Set();
  Set<ActionTypeEnum> filterActionTypes = Set();
  bool filterCompleted = false;
  bool filterRecommended = false;
  bool filterNew = false;

  ExplorePageFilterData({
    Set<int>? filterCauseIds,
    Set<Tuple2<double, double>>? filterTimeBrackets,
    Set<ActionTypeEnum>? filterActionTypes,
    this.filterCompleted = false,
    this.filterRecommended = false,
    this.filterNew = false,
  })  : this.filterCauseIds = filterCauseIds ?? Set(),
        this.filterTimeBrackets = filterTimeBrackets ?? Set(),
        this.filterActionTypes = filterActionTypes ?? Set();
}

@freezed
class ExploreFilterState with _$ExploreFilterState {
  const factory ExploreFilterState({
    @Default({}) Set<int> filterCauseIds,
    @Default({}) Set<Tuple2<double, double>> filterTimeBrackets,
    @Default({}) Set<ActionTypeEnum> filterActionTypes,
    @Default(false) bool filterCompleted,
    @Default(false) bool filterRecommended,
    @Default(false) bool filterNew,
    @Default('') String queryText,
  }) = _ExploreFilterState;
}

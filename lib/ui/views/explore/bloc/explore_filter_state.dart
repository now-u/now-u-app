import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nowu/models/Action.dart';
import 'package:nowu/services/causes_service.dart';
import 'package:tuple/tuple.dart';

part 'explore_filter_state.freezed.dart';

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

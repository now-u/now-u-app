import 'package:freezed_annotation/freezed_annotation.dart';

import 'explore_state.dart';

part 'explore_event.freezed.dart';

@freezed
sealed class ExploreEvent with _$ExploreEvent {
  const factory ExploreEvent.filterChanged({
    required ExploreFilterState filter,
  }) = ExploreFilterChanged;
}

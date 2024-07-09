import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nowu/models/cause.dart';

part 'causes_state.freezed.dart';

@freezed
sealed class CausesState with _$CausesState {
  const factory CausesState.loading() = CausesStateLoading;
  const factory CausesState.loaded({required List<Cause> causes}) =
      CausesStateLoaded;
  const factory CausesState.error(String message) = CausesStateError;
}

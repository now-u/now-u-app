import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nowu/models/Cause.dart';

part 'causes_state.freezed.dart';

@freezed
sealed class CausesState with _$CausesState {
  const factory CausesState.initial() = Initial;
  const factory CausesState.loading() = Loading;
  const factory CausesState.loaded({ required List<Cause> causes }) = Loaded;
  const factory CausesState.error(String message) = Error;
}

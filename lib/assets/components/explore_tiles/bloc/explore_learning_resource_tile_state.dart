import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nowu/services/causes_service.dart';

part 'explore_learning_resource_tile_state.freezed.dart';

@freezed
sealed class ExploreLearningResourceTileState with _$ExploreLearningResourceTileState {
  const factory ExploreLearningResourceTileState.static({
    required LearningResource learningResource,
  }) = Static;
  const factory ExploreLearningResourceTileState.launching({
    required LearningResource learningResource,
  }) = Launching;
}

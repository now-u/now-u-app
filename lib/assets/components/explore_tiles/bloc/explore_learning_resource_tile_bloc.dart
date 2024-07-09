import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nowu/assets/components/explore_tiles/bloc/explore_learning_resource_tile_state.dart';
import 'package:nowu/services/causes_service.dart';

class ExploreLearningResourceTileBloc
    extends Cubit<ExploreLearningResourceTileState> {
  CausesService _causesService;

  ExploreLearningResourceTileBloc({
    required LearningResource learningResource,
    required CausesService causesService,
  })  : _causesService = causesService,
        super(
          ExploreLearningResourceTileState.static(
            learningResource: learningResource,
          ),
        );

  Future<void> launchLearningResource() async {
    switch (state) {
      case ExploreLearningResourceTileStateStatic(:final learningResource):
        {
          emit(
            ExploreLearningResourceTileState.launching(
              learningResource: learningResource,
            ),
          );

          await _causesService.completeLearningResource(learningResource);

          // TODO Refetch learning resource
          emit(
            ExploreLearningResourceTileState.static(
              learningResource: learningResource,
            ),
          );
        }
      case ExploreLearningResourceTileStateLaunching():
        {
          throw Exception('Learning resource already launching');
        }
    }
  }
}

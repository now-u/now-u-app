import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nowu/ui/common/cause_tile.dart';
import 'package:nowu/ui/views/causes/bloc/causes_bloc.dart';
import 'package:nowu/ui/views/causes/bloc/causes_state.dart';
import 'package:nowu/ui/views/causes_selection/bloc/causes_selection_bloc.dart';
import 'package:nowu/ui/views/causes_selection/bloc/causes_selection_state.dart';

// TODO Can we stop this depending on view model and then use it on the home page as well?
class CauseTileGrid extends StatelessWidget {
  const CauseTileGrid();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CausesBloc, CausesState>(
      builder: (context, state) {
        switch (state) {
          case CausesStateLoading():
          // TODO Handle error
          case CausesStateError():
            return Container();
          case CausesStateLoaded(:final causes):
            return BlocBuilder<CausesSelectionBloc, CausesSelectionState>(
              builder: (context, causeSelectionState) {
                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1,
                  ),
                  padding: const EdgeInsets.all(20),
                  itemCount: causes.length,
                  itemBuilder: (BuildContext context, int index) {
                    final cause = causes[index];
                    return Container(
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: CauseTile(
                          onSelect: () => context.read<CausesSelectionBloc>().toggleCauseSelection(
                            cause.id,
                          ),
                          cause: cause,
                          isSelectedOverride: causeSelectionState.selectedCausesIds.contains(cause.id),
                        ),
                      ),
                    );
                  },
                );
              },
            );
        }
      },
    );
  }
}

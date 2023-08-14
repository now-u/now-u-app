import 'package:flutter/material.dart';
import 'package:nowu/ui/common/cause_tile.dart';

import '../select_causes_viewmodel.dart';

// TODO Can we stop this depending on view model and then use it on the home page as well?
class CauseTileGrid extends StatelessWidget {
  final SelectCausesViewModel viewModel;
  CauseTileGrid(this.viewModel);

  @override
  Widget build(BuildContext context) {
    if (!viewModel.dataReady) {
      return const Center(child: CircularProgressIndicator());
    }
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1,
      ),
      padding: const EdgeInsets.all(20),
      itemCount: viewModel.causesList.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: CauseTile(
              gestureFunction: () => viewModel.toggleSelection(
                listCause: viewModel.causesList[index],
              ),
              cause: viewModel.causesList[index],
              isSelected:
                  viewModel.isCauseSelected(viewModel.causesList[index]),
              getInfoFunction: () => viewModel.getCausePopup(
                listCause: viewModel.causesList[index],
                causeIndex: index,
              ),
            ),
          ),
        );
      },
    );
  }
}

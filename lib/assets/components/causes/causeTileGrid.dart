import 'package:app/assets/components/grid.dart';
import 'package:app/viewmodels/causes_view_model.dart';
import 'package:flutter/material.dart';
import 'package:app/assets/components/causes/causeTile.dart';

class CauseTileGrid extends StatelessWidget {
  final CausesViewModel model;
  CauseTileGrid(this.model);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15.0),
      child: ExpandedGrid.builder(
          numberOfRows: 2,
          itemCount: model.causesList.length,
          itemBuilder: (context, rowIndex, colIndex, index) {
            return Expanded(
                child: Padding(
              padding: EdgeInsets.all(10),
              child: CauseTile(
                gestureFunction: () => model.toggleSelection(
                    listCause: model.causesList[index]),
                cause: model.causesList[index],
                isSelected:
                    model.isCauseSelected(model.causesList[index]),
                getInfoFunction: () => model.getCausePopup(
                    listCause: model.causesList[index],
                    causeIndex: index),
              ),
            ),
          );
        },
      ),
    );
  }
}

import 'package:nowu/viewmodels/causes_view_model.dart';
import 'package:flutter/material.dart';
import 'package:nowu/assets/components/causes/causeTile.dart';

class CauseTileGrid extends StatelessWidget {
  final CausesViewModel model;
  CauseTileGrid(this.model);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1,
        ),
        padding: EdgeInsets.all(20),
        itemCount: model.causesList.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            child: Padding(
              padding: EdgeInsets.all(10),
              child: CauseTile(
                gestureFunction: () =>
                    model.toggleSelection(listCause: model.causesList[index]),
                cause: model.causesList[index],
                isSelected: model.isCauseSelected(model.causesList[index]),
                getInfoFunction: () => model.getCausePopup(
                    listCause: model.causesList[index], causeIndex: index),
              ),
            ),
          );
        });
  }
}

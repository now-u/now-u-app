import 'package:app/assets/components/grid.dart';
import 'package:app/viewmodels/causes_view_model.dart';
import 'package:flutter/material.dart';
import 'package:app/assets/components/causes/causeTile.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stacked/stacked.dart';

class CauseTileGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CausesViewModel>.reactive(
        viewModelBuilder: () => CausesViewModel(),
        onModelReady: (model) => model.fetchCauses(),
        builder: (context, model, child) {
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
                            causeIcon: FontAwesomeIcons.leaf,
                            isSelected:
                            model.isCauseSelected(model.causesList[index]),
                            getInfoFunction: () => model.getCausePopup(
                                listCause: model.causesList[index],
                                causeIndex: index),
                          ),
                        ));
                  }));
        });
  }
}
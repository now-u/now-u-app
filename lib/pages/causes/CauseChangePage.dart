import 'package:app/assets/components/causeOnboardingClipper.dart';
import 'package:app/assets/components/grid.dart';
import 'package:app/viewmodels/causes_view_model.dart';
import 'package:flutter/material.dart';
import 'package:app/assets/components/causeTile.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:app/assets/components/buttons/customWidthButton.dart';
import 'package:stacked/stacked.dart';

class CauseChangePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ViewModelBuilder<CausesViewModel>.reactive(
            viewModelBuilder: () => CausesViewModel(),
            onModelReady: (model) => model.fetchCauses(),
            builder: (context, model, child) {
              return Padding(
                padding: const EdgeInsets.fromLTRB(0, 60, 0, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Row(
                        children: [
                          MaterialButton(
                              child: Row(
                                children: [
                                  Icon(
                                    FontAwesomeIcons.chevronLeft,
                                    color: Colors.orange,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text('Back',
                                      style: TextStyle(
                                        color: Colors.orange,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      )),
                                ],
                              ),
                              onPressed: () {
                                print('hello');
                              }),
                          SizedBox(width: 10)
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Edit Causes',
                              style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            Text(
                              'Select the causes which are most important to you to receive personalised content.',
                              style:
                                  TextStyle(fontSize: 15, color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 10,
                      child: Container(
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
                                  isSelected: model
                                      .isCauseSelected(model.causesList[index]),
                                  getInfoFunction: () => model.getCausePopup(
                                      listCause: model.causesList[index],
                                      causeIndex: index),
                                ),
                              ));
                            }),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Center(
                        child: CustomWidthButton(
                          'Save',
                          onPressed: model.areAllCausesStillDisabled
                              ? () {}
                              : () {
                                  model.getStarted();
                                },
                          backgroundColor: model.areAllCausesStillDisabled
                              ? Colors.grey
                              : Theme.of(context).primaryColor,
                          size: ButtonSize.Medium,
                          fontSize: 20.0,
                          buttonWidthProportion: 0.6,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              );
            }));
  }
}

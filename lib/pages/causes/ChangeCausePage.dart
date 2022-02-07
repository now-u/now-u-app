import 'package:app/viewmodels/causes_view_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:app/assets/components/buttons/customWidthButton.dart';
import 'package:stacked/stacked.dart';
import 'package:app/assets/components/causes/causeTileGrid.dart';

class ChangeCausePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ViewModelBuilder<ChangeCausesViewModel>.reactive(
            viewModelBuilder: () => ChangeCausesViewModel(),
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
                                model.goToPreviousPage();
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
                      child: CauseTileGrid(model),
                    ),
                    Expanded(
                      flex: 1,
                      child: Center(
                        child: CustomWidthButton(
                          'Save',
                          onPressed: model.areCausesDisabled
                              ? () {}
                              : () {
                                  model.selectCauses();
                                },
                          backgroundColor: model.areCausesDisabled
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

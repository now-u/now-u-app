import 'package:app/assets/components/causeOnboardingClipper.dart';
import 'package:app/assets/components/grid.dart';
import 'package:app/viewmodels/causes_view_model.dart';
import 'package:flutter/material.dart';
import 'package:app/assets/components/causeTile.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:app/assets/components/buttons/customWidthButton.dart';
import 'package:stacked/stacked.dart';

class CausePage extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ViewModelBuilder<CausesViewModel>.reactive(
            viewModelBuilder: () => CausesViewModel(),
            onModelReady: (model) => model.fetchCauses(),
            builder: (context, model, child) {
              return Stack(
                children: [
                  ClipPath(
                      clipper: CauseBackgroundClipper(),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.43,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Color(0XFF011A43), Color(0XFF012B93)],
                              begin: Alignment.bottomLeft,
                              end: Alignment.topRight,
                            )),
                      ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          flex: 3,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 7,
                                      child: Text(
                                        'Welcome to now-u',
                                        style: TextStyle(
                                            fontSize: 30,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white
                                        ),
                                      ),
                                    ),
                                    Expanded(flex: 3, child: SizedBox())
                                  ],
                                ),
                                Text(
                                  'Take action and selected the causes which are important to you.',
                                  style: TextStyle(fontSize: 15, color: Colors.white),
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
                              itemCount: 6,
                              itemBuilder: (context, rowIndex, colIndex, index) {
                                return Expanded(child: Padding(
                                  padding: EdgeInsets.all(10), 
                                  child: CauseTile(
                                      gestureFunction: () => model.toggleSelection(causeIndex: index),
                                      cause: model.causesList[index],
                                      causeIcon: FontAwesomeIcons.leaf,
                                      isSelected: model.causesSelectedList[index],
                                      getInfoFunction: () => model.getCausePopup(causeIndex: index),
                                  ),
                                ));
                              }
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Center(
                            child: CustomWidthButton('Get started',
                              onPressed: model.isButtonDisabled 
                                ? () {} 
                                : () {model.getStarted();},
                              backgroundColor: model.isButtonDisabled
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
                  )
                ],
              );
            }));
  }
}

import 'package:app/assets/components/causes/causeTileGrid.dart';
import 'package:app/viewmodels/causes_view_model.dart';
import 'package:flutter/material.dart';
import 'package:app/assets/components/buttons/customWidthButton.dart';
import 'package:stacked/stacked.dart';

class CauseOnboardingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ViewModelBuilder<SelectCausesViewModel>.reactive(
            viewModelBuilder: () => SelectCausesViewModel(),
            onModelReady: (model) => model.fetchCauses(),
            builder: (context, model, child) {
              return Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.43,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0XFF011A43), Color(0XFF012B93)],
                          begin: Alignment.bottomLeft,
                          end: Alignment.topRight,
                        )),
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
                                            color: Colors.white),
                                      ),
                                    ),
                                    Expanded(flex: 3, child: SizedBox())
                                  ],
                                ),
                                Text(
                                  'Take action and selected the causes which are important to you.',
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 10,
                          child: causeTileGrid()
                        ),
                        Expanded(
                          flex: 1,
                          child: Center(
                            child: CustomWidthButton('Get started',
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
                  )
                ],
              );
            }));
  }
}
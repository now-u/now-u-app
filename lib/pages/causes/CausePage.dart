import 'package:app/viewmodels/causes_view_model.dart';
import 'package:flutter/material.dart';
import 'package:app/assets/components/causeTile.dart';
import 'package:app/models/Cause.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:app/assets/components/buttons/customWidthButton.dart';
import 'package:app/viewmodels/causes_view_model.dart';
import 'package:stacked/stacked.dart';

class CausePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ViewModelBuilder<CausesViewModel>.reactive(
            viewModelBuilder: () => CausesViewModel(),
            onModelReady: (model) => model.fetchCauses(),
            builder: (context, model, child) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('Welcome to now-u'),
                  Text(
                      'Take action and selected the causes which are important to you'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CauseTile(
                          cause: model.causesList[0],
                          causeIcon: FontAwesomeIcons.leaf,
                          isSelected: false),
                      CauseTile(
                          cause: model.causesList[1],
                          causeIcon: FontAwesomeIcons.heart,
                          isSelected: false),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CauseTile(
                          cause: model.causesList[0],
                          causeIcon: FontAwesomeIcons.leaf,
                          isSelected: false),
                      CauseTile(
                          cause: model.causesList[1],
                          causeIcon: FontAwesomeIcons.heart,
                          isSelected: true),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CauseTile(
                          cause: model.causesList[0],
                          causeIcon: FontAwesomeIcons.leaf,
                          isSelected: false),
                      CauseTile(
                          cause: model.causesList[1],
                          causeIcon: FontAwesomeIcons.heart,
                          isSelected: true),
                    ],
                  ),
                  CustomWidthButton('Get started',
                      onPressed: () {
                    model.goHome();
                  },
                      size: ButtonSize.Medium,
                      fontSize: 20.0,
                      buttonWidthProportion: 0.6)
                ],
              );
            }));
  }
}

import 'package:flutter/material.dart';
import 'package:app/assets/components/causeTile.dart';
import 'package:app/models/Cause.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:app/assets/components/buttons/customWidthButton.dart';

class CausePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text('Welcome to now-u'),
          Text('Take action and selected the causes which are important to you'),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CauseTile(cause: Cause(name: 'Environment'), causeIcon: FontAwesomeIcons.leaf, isSelected: false),
              CauseTile(cause: Cause(name: 'Health & Wellbeing'), causeIcon: FontAwesomeIcons.heart, isSelected: true),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CauseTile(cause: Cause(name: 'Environment'), causeIcon: FontAwesomeIcons.leaf, isSelected: false),
              CauseTile(cause: Cause(name: 'Health & Wellbeing'), causeIcon: FontAwesomeIcons.heart, isSelected: true),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CauseTile(cause: Cause(name: 'Environment'), causeIcon: FontAwesomeIcons.leaf, isSelected: false),
              CauseTile(cause: Cause(name: 'Health & Wellbeing'), causeIcon: FontAwesomeIcons.heart, isSelected: true),
            ],
          ),
          CustomWidthButton('Get started', onPressed: () {print('hello');}, size: ButtonSize.Medium, fontSize: 20.0, buttonWidthProportion: 0.6)
        ],
      ),
    );
  }
}

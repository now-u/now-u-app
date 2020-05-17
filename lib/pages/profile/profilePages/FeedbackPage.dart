import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:app/assets/components/pageTitle.dart';
import 'package:app/assets/components/darkButton.dart';

import 'package:app/models/ViewModel.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:math' as math;

const double ICON_SIZE = 50;

class FeedbackPage extends StatelessWidget {
GestureTapCallback _goBack;
FeedbackPage(goBack) {
  _goBack = goBack;
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      Column(
        children: <Widget>[
          PageTitle('Feedback', hasBackButton: true, onClickBackButton: _goBack,),

          Center(
            heightFactor: 10,

            child: Container(
              height: 15.0,
              child: IconButton(icon: Icon(FontAwesomeIcons.envelopeOpen, size: ICON_SIZE), onPressed: () {launch('mailto:lizzie@now-u.com?subject=Hi there');})
            ),
          ),
          Text ('Please Leave Us Some Feedback', style: TextStyle(fontSize: 18)),
          ],
        ),
      );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

import 'package:url_launcher/url_launcher.dart';

import 'package:app/assets/components/darkButton.dart';
import 'package:app/assets/StyleFrom.dart';

class BetaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
            Text("Welcome!",
                style: textStyleFrom(
                    Theme.of(context).primaryTextTheme.headline1)),
            Padding(
              padding: EdgeInsets.all(15),
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: Theme.of(context).primaryTextTheme.bodyText1,
                  text:
                      "This app is currently in beta - thank you for helping us test it out! We would love to hear your thoughts, especially any suggestions for improvements. Try using the app as you normally would. You can then find a link to give us feedback in the 'more' menu under 'Give us feedback on the app'. We will regularly share updates so please do revisit the app over a period of time to leave us feedback on any changes or new features. Happy testing!",
                ),
              ),
            ),
            SizedBox(height: 20),
            DarkButton("Continue", onPressed: () {
              Navigator.of(context).pushNamed('/');
            })
          ])),
    );
  }
}

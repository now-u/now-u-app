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
            Text(
              "Welcome!",
              style: textStyleFrom(
                Theme.of(context).primaryTextTheme.headline1
              )
            ),
            Padding(
              padding: EdgeInsets.all(15),
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "This app is currenly in beta, thank you for helping us test it out! We would greatly appreciate any feedback you leave us ",
                      style: textStyleFrom(
                        Theme.of(context).primaryTextTheme.bodyText1,
                      ),
                    ),
                    TextSpan(
                      text: "here",
                      style: textStyleFrom(
                        Theme.of(context).primaryTextTheme.bodyText1,
                        color: Theme.of(context).buttonColor,
                      ),
                      recognizer: TapGestureRecognizer()..onTap = () {
                        launch("https://docs.google.com/forms/d/e/1FAIpQLSflMOarmyXRv7DRbDQPWRayCpE5X4d8afOpQ1hjXfdvzbnzQQ/viewform");
                      }
                    ),
                    TextSpan(
                      text: ". When you are using the app you can find this link in the 'more' section under 'Give us feedback on the app'",
                      style: textStyleFrom(
                        Theme.of(context).primaryTextTheme.bodyText1,
                      ),
                    ),
                  ]
                ),
              ),
            ),
            SizedBox(height: 20),
            DarkButton(
              "Continue",
              onPressed: () {
                Navigator.of(context).pushNamed('/');
              }
            )
          ]
        )
      ), 
    );
  }
}

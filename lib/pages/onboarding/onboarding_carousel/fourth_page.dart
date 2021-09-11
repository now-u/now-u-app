import 'package:app/assets/StyleFrom.dart';
import 'package:app/assets/components/darkButton.dart';
import 'package:app/viewmodels/onboarding_model.dart';
import 'package:flutter/material.dart';

class FourthOnBoardingPage extends StatelessWidget {
  const FourthOnBoardingPage({Key key, this.model}) : super(key: key);
  final OnBoardingViewModel model;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.4,
          child:
              Image.asset('assets/imgs/intro/On-Boarding illustrations-04.png'),
        ),
        Text(
          'Help shape a better world',
          textAlign: TextAlign.center,
          style: textStyleFrom(Theme.of(context)
              .primaryTextTheme
              .headline1
              .copyWith(color: Colors.white, fontWeight: FontWeight.w900)),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          'Join our growing community driving lasting change.',
          textAlign: TextAlign.center,
          style: textStyleFrom(
            Theme.of(context).primaryTextTheme.bodyText1.copyWith(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.w400),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.05,
        ),
        DarkButton(
          "Get started",
          onPressed: () {
            model.navigateToNextScreen();
          },
        )
      ],
    );
  }
}

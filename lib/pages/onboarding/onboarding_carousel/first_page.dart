import 'package:app/pages/onboarding/onboarding_carousel/basic_carousel_page.dart';
import 'package:app/viewmodels/onboarding_model.dart';
import 'package:flutter/material.dart';

class FirstOnBoardingPage extends StatelessWidget {
  const FirstOnBoardingPage({this.model, Key? key}) : super(key: key);
  final OnBoardingViewModel? model;
  @override
  Widget build(BuildContext context) {
    return BasicCarouselPage(
        model: model,
        boldText: 'Welcome',
        normalText: ' Our mission is to',
        additionalText: [
          TextSpan(
            text: ' inform, involve ',
            style: TextStyle(fontWeight: FontWeight.w800),
          ),
          TextSpan(text: 'and '),
          TextSpan(
            text: 'inspire ',
            style: TextStyle(fontWeight: FontWeight.w800),
          ),
          TextSpan(
              text:
                  'everyone to help tackle some of the world’s most pressing problems.')
        ],
        backgroundImagePath: 'assets/imgs/intro/OnBoarding1.png',
        logoPath: 'assets/imgs/intro/now-u-logo-onboarding.png',
        showSkipButton: false,
        showGetStartedButton: false);
  }
}

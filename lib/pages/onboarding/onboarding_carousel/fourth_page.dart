import 'package:app/pages/onboarding/onboarding_carousel/basic_carousel_page.dart';
import 'package:app/viewmodels/onboarding_model.dart';
import 'package:flutter/material.dart';

class FourthOnBoardingPage extends StatelessWidget {
  const FourthOnBoardingPage({Key? key, this.model}) : super(key: key);
  final OnBoardingViewModel? model;

  @override
  Widget build(BuildContext context) {
    return BasicCarouselPage(
        model: model,
        boldText: 'Help shape a better world',
        normalText: 'Join our growing community driving lasting change.',
        illustrationImagePath:
            'assets/imgs/intro/On-Boarding illustrations-04.png',
        showSkipButton: false,
        showGetStartedButton: true);
  }
}

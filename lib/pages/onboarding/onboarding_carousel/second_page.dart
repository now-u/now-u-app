import 'package:app/viewmodels/onboarding_model.dart';
import 'package:flutter/material.dart';

import 'basic_carousel_page.dart';

class SecondOnBoardingPage extends StatelessWidget {
  const SecondOnBoardingPage({Key? key, this.model});
  final OnBoardingViewModel? model;
  @override
  Widget build(BuildContext context) {
    return BasicCarouselPage(
      model: model,
      boldText: 'Choose causes you care about',
      normalText:
          'Select and support the social and environmental issues important to you.',
      illustrationImagePath:
          'assets/imgs/intro/On-Boarding illustrations-01.png',
      showGetStartedButton: false,
      showSkipButton: true,
    );
  }
}

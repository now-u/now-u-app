import 'package:app/pages/onboarding/onboarding_carousel/basic_carousel_page.dart';
import 'package:app/viewmodels/onboarding_model.dart';
import 'package:flutter/material.dart';

class ThirdOnBoardingPage extends StatelessWidget {
  const ThirdOnBoardingPage({Key key, this.model}) : super(key: key);
  final OnBoardingViewModel model;
  @override
  Widget build(BuildContext context) {
    return BasicCarouselPage(
      model: model,
      boldText: 'Learn and take action',
      normalText: 'Find ways to make a difference that suit you.',
      imagePath: 'assets/imgs/intro/On-Boarding illustrations-02.png',
    );
  }
}

import 'package:app/assets/StyleFrom.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'first_page.dart';
import 'fourth_page.dart';
import 'second_page.dart';
import 'third_page.dart';

class OnBoardingCarousel extends StatelessWidget {
  const OnBoardingCarousel({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pageController = PageController(initialPage: 0);
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorDark,
      body: Stack(
        children: [
          PageView(
            controller: pageController,
            children: pages,
          ),
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.05,
            width: MediaQuery.of(context).size.width,
            child: Center(
              child: SmoothPageIndicator(
                controller: pageController,
                count: pages.length,
                effect: ExpandingDotsEffect(
                    dotColor: colorFrom(
                      Colors.white,
                    ),
                    activeDotColor: Colors.orange,
                    spacing: 10.0,
                    dotHeight: 15,
                    radius: 25.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

const List<Widget> pages = [
  FirstOnBoardingPage(),
  SecondOnBoardingPage(),
  ThirdOnBoardingPage(),
  FourthOnBoardingPage()
];

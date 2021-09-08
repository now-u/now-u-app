import 'package:app/assets/StyleFrom.dart';
import 'package:app/viewmodels/onboarding_model.dart';
import 'package:flutter/material.dart';

class SecondOnBoardingPage extends StatelessWidget {
  const SecondOnBoardingPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextButton(
              style: TextButton.styleFrom(
                textStyle: TextStyle(
                    fontFamily: 'Nunito',
                    fontSize: 18,
                    fontWeight: FontWeight.w700),
              ),
              onPressed: () {
                OnBoardingViewModel().navigateToNextScreen();
              },
              child: Text(
                'Skip',
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.4,
                  child: Image.asset(
                      'assets/imgs/intro/On-Boarding illustrations-01.png'),
                ),
                Text(
                  'Choose causes you care about',
                  textAlign: TextAlign.center,
                  style: textStyleFrom(Theme.of(context)
                      .primaryTextTheme
                      .headline1
                      .copyWith(
                          color: Colors.white, fontWeight: FontWeight.w900)),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                    'Select and support the social and environmental issues important to you.',
                    textAlign: TextAlign.center,
                    style: textStyleFrom(Theme.of(context)
                        .primaryTextTheme
                        .bodyText1
                        .copyWith(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w400))),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

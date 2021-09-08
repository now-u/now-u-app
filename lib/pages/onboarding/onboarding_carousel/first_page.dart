import 'package:app/assets/StyleFrom.dart';
import 'package:flutter/material.dart';

class FirstOnBoardingPage extends StatelessWidget {
  const FirstOnBoardingPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Stack(children: [
      Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/imgs/intro/OnBoarding1.png'),
                  fit: BoxFit.cover))),
      Positioned(
        top: height * 0.04,
        width: width,
        child: Center(
          child: Image.asset('assets/imgs/intro/now-u-logo-onboarding.png'),
        ),
      ),
      Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Welcome',
                style: textStyleFrom(Theme.of(context)
                    .primaryTextTheme
                    .headline1
                    .copyWith(
                        color: Colors.white, fontWeight: FontWeight.w900)),
              ),
              SizedBox(
                height: height * 0.02,
              ),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: ' Our mission is to',
                  style: textStyleFrom(
                    Theme.of(context).primaryTextTheme.bodyText1.copyWith(
                          fontSize: 18,
                          letterSpacing: 1.2,
                        ),
                    color: Colors.white,
                  ),
                  children: [
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
                ),
              )
            ],
          ),
        ),
      ),
    ]);
  }
}

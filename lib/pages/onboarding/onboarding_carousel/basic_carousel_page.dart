import 'package:app/assets/StyleFrom.dart';
import 'package:app/assets/components/darkButton.dart';
import 'package:app/viewmodels/onboarding_model.dart';
import 'package:flutter/material.dart';

class BasicCarouselPage extends StatelessWidget {
  const BasicCarouselPage(
      {Key? key,
      required this.model,
      required this.boldText,
      required this.normalText,
      this.illustrationImagePath,
      required this.showSkipButton,
      required this.showGetStartedButton,
      this.additionalText,
      this.backgroundImagePath,
      this.logoPath})
      : super(key: key);

  final OnBoardingViewModel? model;
  final String boldText;
  final String normalText;
  final String? illustrationImagePath;
  final bool showSkipButton;
  final bool showGetStartedButton;
  final List<TextSpan>? additionalText;
  final String? backgroundImagePath;
  final String? logoPath;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          backgroundImage(backgroundImagePath),
          logo(logoPath, context),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                skipButton(showSkipButton, context),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    illustrationImage(illustrationImagePath, context),
                    Text(
                      boldText,
                      textAlign: TextAlign.center,
                      style: textStyleFrom(Theme.of(context)
                          .primaryTextTheme
                          .headline1!
                          .copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w900)),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text: normalText,
                        style: textStyleFrom(
                          Theme.of(context).primaryTextTheme.bodyText1!.copyWith(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w400),
                        ),
                        children: additionalText,
                      ),
                    ),
                    getStartedButton(showGetStartedButton, context, model),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget backgroundImage(String? path) {
    return path != null
        ? Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(path), fit: BoxFit.cover)))
        : Container();
  }

  Widget illustrationImage(String? path, BuildContext context) {
    return path != null
        ? Container(
            height: MediaQuery.of(context).size.height * 0.4,
            child: Image.asset(path),
          )
        : Container(
            height: MediaQuery.of(context).size.height * 0.4,
          );
  }

  Widget skipButton(bool show, BuildContext context) {
    return show
        ? TextButton(
            style: TextButton.styleFrom(
              textStyle: TextStyle(
                  fontFamily: 'Nunito',
                  fontSize: 18,
                  fontWeight: FontWeight.w700),
            ),
            onPressed: () {
              model!.navigateToNextScreen();
            },
            child: Text(
              'Skip',
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
          )
        : Container();
  }

  Widget getStartedButton(
      bool show, BuildContext context, OnBoardingViewModel? model) {
    return show
        ? Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              DarkButton(
                "Get started",
                onPressed: () {
                  model!.navigateToNextScreen();
                },
              )
            ],
          )
        : Container();
  }

  Widget logo(String? path, BuildContext context) {
    return path != null
        ? Positioned(
            top: 10,
            width: MediaQuery.of(context).size.width,
            child: Center(
              child: Image.asset(path),
            ),
          )
        : Container();
  }
}

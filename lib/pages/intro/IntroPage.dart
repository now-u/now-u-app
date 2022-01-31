import 'package:app/assets/StyleFrom.dart';
import 'package:app/viewmodels/intro_view_model.dart';
import 'package:flutter/material.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:rect_getter/rect_getter.dart';

import 'package:app/assets/components/buttons/darkButton.dart';
import 'package:app/assets/components/textButton.dart';
import 'package:stacked/stacked.dart';

List<IntroPageSection> pages = [
  IntroPageSection(
    title: "Welcome",
    description: "Our mission is to inform, involve and inspire everyone to help tackle some of the world’s most pressing problems.",
    backgroundImage: "assets/imgs/intro/OnBoarding1.png",
  ),
  IntroPageSection(
    title: "Choose causes you care about",
    description: "We partner with charities to bring you targeted monthly campaigns, highlighting a range of social and environmental issues both locally and around the world. Join as many as you like!",
    image: 'assets/imgs/intro/On-Boarding illustrations-01.png',
  ),
  IntroPageSection(
    title: "Learn and take action",
    description: "Find ways to make a difference that suit you.",
    image: 'assets/imgs/intro/On-Boarding illustrations-02.png',
  ),
  IntroPageSection(
    title: "Help shape a better world",
    description: "Join a community of changemakers, connect with fellow campaign contributors, and see how your actions are making a difference.",
    image: 'assets/imgs/intro/On-Boarding illustrations-04.png',
  ),
];

const curve = Curves.ease;
const duration = Duration(milliseconds: 500);
const Duration animationDuration = Duration(milliseconds: 500);

class IntroPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<IntroViewModel>.reactive(
      viewModelBuilder: () => IntroViewModel(0),
      builder: (context, model, child) => WillPopScope(
        onWillPop: () async => false,
        child: Stack(children: <Widget>[
          Scaffold(
              body: Container(
                  decoration: pages[model.currentIndex].backgroundImage == null 
                    ? BoxDecoration(
                        color: Theme.of(context).primaryColorDark,
                      )
                    : BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                            pages[model.currentIndex].backgroundImage!,
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      SafeArea(
                        child: Container(),
                      ),

                      if (pages[model.currentIndex].showSkip)
                        Padding(
                          padding: EdgeInsets.only(top: 20, bottom: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Container(
                                  width: 70,
                                  child: RectGetter(
                                    key: model.skipKey,
                                    child: CustomTextButton("Skip", onClick: () => model.skip(context)),
                                  ))
                            ],
                          ),
                        ),
                      Expanded(
                        child: PageView(
                          //physics: NeverScrollableScrollPhysics(),
                          onPageChanged: model.setIndex,
                          controller: model.controller,
                          children: pages,
                        ),
                      ),

                      Padding(
                          padding: EdgeInsets.all(40),
                          child: Container(
                            width: double.infinity,
                            child: Container(
                                height: 45,
                                child: model.currentIndex != pages.length - 1
                                    ? Container()
                                    : RectGetter(
                                        key: model.getStartedKey,
                                        child: DarkButton(
                                          "Get Started!",
                                          onPressed: () => model.getStarted(context)
                                        ),
                                      )),
                          )),

                      SmoothPageIndicator(
                        controller: model.controller,
                        count: pages.length,
                        effect: ExpandingDotsEffect(
                            dotColor: colorFrom(
                              Colors.white,
                              opacity: 0.3,
                            ),
                            activeDotColor: Colors.orange,
                            spacing: 8.0,
                            dotHeight: 12,
                            radius: 20.0),
                      ),

                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),),),
            if (model.animationRect != null)
              AnimatedPositioned(
                duration: animationDuration,
                left: model.animationRect!.left,
                right: MediaQuery.of(context).size.width - model.animationRect!.right,
                top: model.animationRect!.top,
                bottom: MediaQuery.of(context).size.height - model.animationRect!.bottom,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color.fromRGBO(255, 136, 0, 1),
                  ),
                ),
              ),
                  ],
                ),
              ),
            );
  }
}

class IntroPageSection extends StatelessWidget {
  final String title;
  final String description;
  final String? image;
  final String? backgroundImage;
  final bool showSkip;

  IntroPageSection({required this.title, required this.description, this.image, this.backgroundImage, this.showSkip=true});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: image != null ? Image(image: AssetImage(image!)): Container(),
          ),
        ),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 40), 
          child: Text(title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: Theme.of(context).primaryTextTheme.headline1!.fontSize,
              fontWeight: Theme.of(context).primaryTextTheme.headline1!.fontWeight,
              color: Colors.white,
            ),
          )
        ),
        SizedBox(height: 15,),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10), 
          child: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            child: Text(description,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize:
                      Theme.of(context).primaryTextTheme.bodyText1!.fontSize,
                  fontWeight:
                      Theme.of(context).primaryTextTheme.bodyText1!.fontWeight,
                  color: Colors.white,
                ),),)
        ),
      ],
    );
  }
}

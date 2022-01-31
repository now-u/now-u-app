import 'package:app/assets/StyleFrom.dart';
import 'package:app/viewmodels/intro_view_model.dart';
import 'package:flutter/material.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:rect_getter/rect_getter.dart';

import 'package:app/assets/components/buttons/darkButton.dart';
import 'package:app/assets/components/textButton.dart';
import 'package:stacked/stacked.dart';

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
        child: Stack(
          children: <Widget>[
            Scaffold(
              body: Container(
                decoration: model.currentPage.backgroundImage == null
                    ? BoxDecoration(
                        color: Theme.of(context).primaryColorDark,
                      )
                    : BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                            model.currentPage.backgroundImage!,
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
                    if (model.currentPage.showSkip)
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
                                  child: CustomTextButton("Skip",
                                      onClick: () => model.skip(context)),
                                ))
                          ],
                        ),
                      ),
                    if (model.currentPage.showLogo)
                      Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: Container(
                          child: Center(
                            child: Image.asset("assets/imgs/intro/now-u-logo-onboarding.png"),
                          ),
                        ),
                      ),

                    Expanded(
                      child: PageView(
                        //physics: NeverScrollableScrollPhysics(),
                        onPageChanged: model.setIndex,
                        controller: model.controller,
                        children: model.pages.map((page) => IntroPageSectionWidget(page)).toList(),
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.all(40),
                        child: Container(
                          width: double.infinity,
                          child: Container(
                              height: 45,
                              child: !model.isLastPage
                                  ? Container()
                                  : RectGetter(
                                      key: model.getStartedKey,
                                      child: DarkButton("Get Started!",
                                          onPressed: () =>
                                              model.getStarted(context)),
                                    )),
                        )),
                    SmoothPageIndicator(
                      controller: model.controller,
                      count: model.pages.length,
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
                ),
              ),
            ),
            if (model.animationRect != null)
              AnimatedPositioned(
                duration: animationDuration,
                left: model.animationRect!.left,
                right: MediaQuery.of(context).size.width -
                    model.animationRect!.right,
                top: model.animationRect!.top,
                bottom: MediaQuery.of(context).size.height -
                    model.animationRect!.bottom,
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

class IntroPageSectionWidget extends StatelessWidget {
  final IntroPageData data;
  IntroPageSectionWidget(this.data);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(20),
            child:
                data.image != null ? Image(image: AssetImage(data.image!)) : Container(),
          ),
        ),
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: Text(
              data.title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize:
                    Theme.of(context).primaryTextTheme.headline1!.fontSize,
                fontWeight:
                    Theme.of(context).primaryTextTheme.headline1!.fontWeight,
                color: Colors.white,
              ),
            )),
        SizedBox(
          height: 15,
        ),
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.9,
              child: Text(
                data.description,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize:
                      Theme.of(context).primaryTextTheme.bodyText1!.fontSize,
                  fontWeight:
                      Theme.of(context).primaryTextTheme.bodyText1!.fontWeight,
                  color: Colors.white,
                ),
              ),
            )),
      ],
    );
  }
}

import 'package:app/assets/routes/customRoute.dart';
import 'package:flutter/material.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:rect_getter/rect_getter.dart';

import 'package:app/assets/components/darkButton.dart';
import 'package:app/assets/components/textButton.dart';

import 'package:app/main.dart';

List<Widget> pages = <Widget>[
                  IntroPageSection(
                    "Join campaigns",
                    "Every month, now-u adds 3 new campiangs that enable you to make a difference! You can choose to join one or a few, or all of them.",
                    AssetImage('assets/imgs/intro/On-Boarding illustrations-01.png'),
                  ),
                  IntroPageSection(
                    "Take action",
                    "Every month, now-u adds 3 new campiangs that enable you to make a difference! You can choose to join one or a few, or all of them.",
                    AssetImage('assets/imgs/intro/On-Boarding illustrations-02.png'),
                  ),
                  IntroPageSection(
                    "Hit achievements",
                    "Every month, now-u adds 3 new campiangs that enable you to make a difference! You can choose to join one or a few, or all of them.",
                    AssetImage('assets/imgs/intro/On-Boarding illustrations-03.png'),
                  ),
                  IntroPageSection(
                    "Create real impact",
                    "Every month, now-u adds 3 new campiangs that enable you to make a difference! You can choose to join one or a few, or all of them.",
                    AssetImage('assets/imgs/intro/On-Boarding illustrations-04.png'),
                  ),
];

const curve = Curves.ease;
const duration = Duration(milliseconds: 500);

class IntroPage extends StatefulWidget {
  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  static const initialIndex = 0;
  int index = initialIndex;
  final controller = 
    PageController(
        initialPage: initialIndex,
      viewportFraction: 1,
    );

  // Animation Setup
  final Duration animationDuration = Duration(milliseconds: 500);
  final Duration delay = Duration(milliseconds: 300);
  GlobalKey rectGetterGetStartedKey = RectGetter.createGlobalKey();
  GlobalKey rectGetterSkipKey = RectGetter.createGlobalKey();
  Rect rect;

  void _onTapSkip() async {
    setState(() => rect = RectGetter.getRectFromKey(rectGetterSkipKey));
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() =>
          rect = rect.inflate(1.3 * MediaQuery.of(context).size.longestSide));
      Future.delayed(animationDuration + delay, _goToNextPage);
    });
  } 
  void _onTapGetStarted() async {
    setState(() => rect = RectGetter.getRectFromKey(rectGetterGetStartedKey));
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() =>
          rect = rect.inflate(1.3 * MediaQuery.of(context).size.longestSide));
      Future.delayed(animationDuration + delay, _goToNextPage);
    });
  } 

  void _goToNextPage() {
    Navigator.of(context)
        .push(FadeRouteBuilder(page: OrangePage()))
        .then((_) => setState(() => rect = null));
  }



  @override
  Widget build(BuildContext context) {
    return 
    Stack(
      children: <Widget> [
        Scaffold(
          body: Container(
            color: Theme.of(context).primaryColorDark,
            child: Column(
              children: <Widget>[
                SafeArea(child: Container(),),
                Padding(
                  padding: EdgeInsets.only(top: 20, bottom: 40),
                  child:
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          width: 70
                        ),
                        Text("Let's get started", style: Theme.of(context).primaryTextTheme.headline6,),
                        Container(
                          width: 70,
                          child: 
                          RectGetter(
                            key: rectGetterSkipKey,
                            child: TextButton(
                              "Skip",
                              onClick: () {
                                //Navigator.pushNamed(context, '/');
                                _onTapSkip();
                              }
                            ),
                          )
                        ) 
                      ],
                    ),
                ),
                SmoothPageIndicator(
                  controller: controller,
                  count: pages.length,
                  effect: ExpandingDotsEffect(
                    dotColor: Color.fromRGBO(221, 221, 221, 1),
                    activeDotColor: Colors.orange,
                    spacing: 14.0,
                    radius: 18.0
                  ),
                ),
                Expanded(
                  child: PageView(
                    //physics: NeverScrollableScrollPhysics(),
                    onPageChanged: (index) {
                      setState(() {
                        this.index = index;
                      }); 
                    },
                    controller: controller,
                    children: pages,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(40),
                  child: Container(
                    width: double.infinity,
                    child: index != pages.length - 1 ? 
                    DarkButton(
                      "Next",
                      onPressed: () {
                        controller.nextPage(
                          curve: curve,
                          duration: duration,
                        );
                      }
                    )
                    :
                    RectGetter(
                      key: rectGetterGetStartedKey,
                      child: DarkButton(
                        "Get Started!",
                        onPressed: _onTapGetStarted,
                        //() {
                        //  //Navigator.pushNamed(context, '/');
                        //  _onTap();
                        //}
                      ),
                    )
                  )
                ),
                Container(
                  width: double.infinity,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 20, left: 20),
                    child: TextButton(
                      "Back",
                      iconLeft: true,
                      onClick: () {
                        controller.previousPage(
                          curve: curve,
                          duration: duration,
                        );
                      },
                    ),
                  )
                )
              ],
            )
          )
        ),
        _ripple(),
      ]
    );
  }

  Widget _ripple() {
    if (rect == null) {
      return Container();
    }
    return AnimatedPositioned(
      duration: animationDuration,
      left: rect.left,
      right: MediaQuery.of(context).size.width - rect.right,
      top: rect.top, 
      bottom: MediaQuery.of(context).size.height - rect.bottom,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Color.fromRGBO(255, 136, 0, 1),
        ),
      ),
    );
  }
}


class IntroPageSection extends StatelessWidget {
  final String title;
  final String description;
  final AssetImage image;

  IntroPageSection(this.title, this.description, this.image);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Image(
              image: image
            ),
          ),
        ),
        Text(
          title,
          style: TextStyle(
            fontSize: Theme.of(context).primaryTextTheme.headline1.fontSize,
            fontWeight: Theme.of(context).primaryTextTheme.headline1.fontWeight,
            color: Colors.white,
          )
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.7,
          child: Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: Theme.of(context).primaryTextTheme.bodyText1.fontSize,
              fontWeight: Theme.of(context).primaryTextTheme.bodyText1.fontWeight,
              color: Colors.white,
            )
          )
        ) 
      ],
    );
  }
}

class FadeRouteBuilder<T> extends PageRouteBuilder<T> {
  final Widget page;

  FadeRouteBuilder({@required this.page})
      : super(
          pageBuilder: (context, animation1, animation2) => page,
          transitionsBuilder: (context, animation1, animation2, child) {
            return FadeTransition(opacity: animation1, child: child);
          },
        );
}

class OrangePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO SUUPER HACKY --> need to sort out state being parsed around and instead use store connector
    Navigator.pushNamed(context, Routes.home);
    return Scaffold(
      body: Container(
        child: Center(child: Text('Now-U Home Page')),
      ),
    );
  }
}

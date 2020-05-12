import 'package:flutter/material.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'package:app/assets/components/darkButton.dart';
import 'package:app/assets/components/textButton.dart';

List<Widget> pages = <Widget>[
                  IntroPageSection(
                    "Join Campaigns",
                    "Every month, now-u adds 3 new campiangs that enable you to make a difference! You can choose to join one or a few, or all of them.",
                    AssetImage('assets/imgs/logo.png'),
                  ),
                  IntroPageSection(
                    "Join Campaigns",
                    "Every month, now-u adds 3 new campiangs that enable you to make a difference! You can choose to join one or a few, or all of them.",
                    AssetImage('assets/imgs/logo.png'),
                  ),
                  IntroPageSection(
                    "Join Campaigns",
                    "Every month, now-u adds 3 new campiangs that enable you to make a difference! You can choose to join one or a few, or all of them.",
                    AssetImage('assets/imgs/intro/mailbox.png'),
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      child: TextButton(
                        "Skip",
                        onClick: () {
                          Navigator.pushNamed(context, '/');
                        }
                      ),
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
                DarkButton(
                  "Get Started!",
                  onPressed: () {
                    Navigator.pushNamed(context, '/');
                  }
                ),
              )
            ),
            Container(
              width: double.infinity,
              child: Padding(
                padding: EdgeInsets.only(bottom: 20, left: 20),
                child: TextButton(
                  "Back",
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

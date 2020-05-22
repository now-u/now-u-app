import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter_appavailability/flutter_appavailability.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:rect_getter/rect_getter.dart';

import 'package:app/assets/components/darkButton.dart';
import 'package:app/assets/components/textButton.dart';
import 'package:app/assets/routes/customRoute.dart';

import 'package:app/models/ViewModel.dart';

import 'package:app/services/dynamicLinks.dart';
import 'package:app/locator.dart';

class EmailSentPage extends StatefulWidget {
  final UserViewModel model;

  EmailSentPage(this.model);
  
  @override
  _EmailSentPageState createState() => _EmailSentPageState();
}

class _EmailSentPageState extends State<EmailSentPage> with WidgetsBindingObserver {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      DynamicLinkService deepLinkService = locator<DynamicLinkService>();
      deepLinkService.getLink().then((Uri link) {
        print("Reconnect on email sent page");
        print(link.toString());
        widget.model.repository.getEmail().then((email) {
          print("Stored email is");
          print(email);
          widget.model.login(email, link.queryParameters['token']);
        });
      });
    }
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
                        Text("Let's get started", style: Theme.of(context).primaryTextTheme.headline6,),
                      ],
                    ),
                ),
                Expanded(
                  child: Container(
                    //physics: NeverScrollableScrollPhysics(),
                    child: IntroPageSection(
                      "Email sent",
                      "Eamil has been aksjfkladsjfl;k",
                      AssetImage('assets/imgs/intro/il-joincamp@4x.png'),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(40),
                  child: Container(
                    width: double.infinity,
                    child: DarkButton(
                      "Open Email",
                      onPressed: () {
                        // TODO open email
                        openEmailApp(context);
                      }
                    )
                  )
                ),
              ],
            )
          )
        ),
      ]
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
    Navigator.pushNamed(context, '/');
    return Scaffold(
      body: Container(
        child: Center(child: Text('Now-U Home Page')),
      ),
    );
  }
}
void openEmailApp(BuildContext context){
    try{
        AppAvailability.launchApp(Platform.isIOS ? "message://" : "com.google.android.gm").then((_) {
                print("App Email launched!");
              }).catchError((err) {
                Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text("App Email not found!")
                ));
                print(err);
              });
    } catch(e) {
      Scaffold.of(context).showSnackBar(SnackBar(content: Text("Email App not found!")));
    }
}


//Future<void> _retrieveDynamicLink() async {
//  final PendingDynamicLinkData data =
//      await FirebaseDynamicLinks.instance.getInitialLink();

//  final Uri deepLink = data?.link;
//  print("THE LINK IS");
//  print(deepLink.toString());

//  if (deepLink.toString() != null) {
//    print("The link is not null");
//    _link = deepLink.toString();
//    _signInWithEmailAndLink();
//  }
//  return deepLink.toString();
//}

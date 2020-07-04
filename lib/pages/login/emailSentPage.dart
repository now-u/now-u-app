import 'package:flutter/material.dart';
import 'dart:io';
import 'package:url_launcher/url_launcher.dart';
import 'package:android_intent/android_intent.dart';

import 'package:app/assets/components/darkButton.dart';
import 'package:app/assets/components/textButton.dart';

import 'package:app/models/ViewModel.dart';

import 'package:app/services/dynamicLinks.dart';
import 'package:app/routes.dart';

import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

class EmailSentPageArguments {
  final UserViewModel model;
  final String email;
  EmailSentPageArguments({
    @required this.model,
    @required this.email,
  });
}

class EmailSentPage extends StatefulWidget {
  final EmailSentPageArguments args;
  EmailSentPage(this.args);

  @override
  _EmailSentPageState createState() => _EmailSentPageState();
}

class _EmailSentPageState extends State<EmailSentPage>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      print("email page life cycle resumed");
      //DynamicLinkService deepLinkService = locator<DynamicLinkService>();
      //deepLinkService.getLink().then((Uri link) {
      //  print("Reconnect on email sent page");
      //  print(link.toString());
      //  widget.model.repository.getEmail().then((email) {
      //    print("Stored email is");
      //    print(email);
      //    widget.model.login(email, link.queryParameters['token']);
      //  });
      //});
      FirebaseDynamicLinks.instance.onLink(
          onSuccess: (PendingDynamicLinkData dynamicLink) async {
        print("Have dynamic link");
        print('dynamicLink: $dynamicLink');
        final Uri deepLink = dynamicLink?.link;
        print('deepLink: $deepLink');
        print('deepLink.path: ${deepLink.path}');
        print('token parameter: ${deepLink.queryParameters['token']}');
        print('deepLink.query: ${deepLink.query}');
        print('deepLink.pathSegments: ${deepLink.pathSegments}');
        print('deepLink.queryParametersAll: ${deepLink.queryParametersAll}');

        if (deepLink != null && deepLink.path == "/loginMobile") {
          print(deepLink.queryParameters['token']);
          widget.args.model.repository.getEmail().then((email) {
            print("Stored email is");
            print(email);
            widget.args.model.login(email, deepLink.queryParameters['token']);
          });
        }
      }, onError: (OnLinkErrorException e) async {
        print('onLinkError');
        print(e.message);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      Scaffold(
          body: Container(
              color: Theme.of(context).primaryColorDark,
              child: Column(
                children: <Widget>[
                  SafeArea(
                    child: Container(),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20, bottom: 40),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //children: <Widget>[
                      //  Text("Let's get started", style: Theme.of(context).primaryTextTheme.headline6,),
                      //],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      //physics: NeverScrollableScrollPhysics(),
                      child: IntroPageSection(
                        "Check your email",
                        "We have just sent an email to ${widget.args.email}",
                        "It has a link that will sign you in to now-u and get you started",
                        AssetImage('assets/imgs/intro/il-mail@4x.png'),
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 40),
                      child: Container(
                          width: double.infinity,
                          child: DarkButton("Open Email", onPressed: () {
                            // TODO open email
                            openEmailApp(context);
                          }))),
                  SizedBox(height: 20),
                  Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton("I did not recieve an email", onClick: () {
                          Navigator.of(context).pushNamed(Routes.loginIssues);
                        }),
                      ]),
                  SizedBox(height: 10),
                ],
              ))),
    ]);
  }
}

class IntroPageSection extends StatelessWidget {
  final String title;
  final String description1;
  final String description2;
  final AssetImage image;

  IntroPageSection(
      this.title, this.description1, this.description2, this.image);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Flexible(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Image(image: image),
          ),
        ),
        Container(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text(title,
                  style: TextStyle(
                    fontSize:
                        Theme.of(context).primaryTextTheme.headline1.fontSize,
                    fontWeight:
                        Theme.of(context).primaryTextTheme.headline1.fontWeight,
                    color: Colors.white,
                  )),
              SizedBox(
                height: 10,
              ),
              Container(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: Text(description2,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: Theme.of(context)
                            .primaryTextTheme
                            .bodyText1
                            .fontSize,
                        fontWeight: Theme.of(context)
                            .primaryTextTheme
                            .bodyText1
                            .fontWeight,
                        color: Colors.white,
                      ))),
              SizedBox(
                height: 5,
              ),
              Container(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: Text(description1,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: Theme.of(context)
                            .primaryTextTheme
                            .bodyText1
                            .fontSize,
                        fontWeight: Theme.of(context)
                            .primaryTextTheme
                            .bodyText1
                            .fontWeight,
                        color: Colors.white,
                      )))
            ],
          ),
        ),
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

void openEmailApp(BuildContext context) {
  //try{
  //    AppAvailability.launchApp(Platform.isIOS ? "message://" : "com.google.android.gm").then((_) {
  //            print("App Email launched!");
  //          }).catchError((err) {
  //            Scaffold.of(context).showSnackBar(SnackBar(
  //                content: Text("App Email not found!")
  //            ));
  //            print(err);
  //          });
  //} catch(e) {
  //  Scaffold.of(context).showSnackBar(SnackBar(content: Text("Email App not found!")));
  //}
  if (Platform.isAndroid) {
    AndroidIntent intent = AndroidIntent(
      action: 'android.intent.action.MAIN',
      category: 'android.intent.category.APP_EMAIL',
    );
    intent.launch().catchError((e) {});
  } else if (Platform.isIOS) {
    launch("message://").catchError((e) {});
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

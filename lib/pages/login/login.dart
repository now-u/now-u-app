import 'package:app/assets/StyleFrom.dart';
import 'package:flutter/gestures.dart';
import 'package:app/assets/components/darkButton.dart';
import 'package:app/assets/components/textButton.dart';
import 'package:app/assets/components/inputs.dart';
import 'package:flutter/material.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:app/models/State.dart';
import 'package:app/models/ViewModel.dart';
import 'package:app/services/dynamicLinks.dart';
import 'package:app/locator.dart';

import 'package:app/services/storage.dart';
import 'package:flutter_redux/flutter_redux.dart';

class LoginPage extends StatefulWidget {
  static String tag = "login page";
  final String deeplink;
  LoginPage({this.deeplink});
  @override
  LoginPageState createState() => new LoginPageState();
}

class LoginPageState extends State<LoginPage> with WidgetsBindingObserver {
//class LoginPageState extends State<LoginPage> {
  String _email;
  String _name;
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _repositry = SecureStorageService();

  @override
  void initState() {
    super.initState();
    //if (widget.deeplink != null) {
    //  _link = widget.deeplink;
    //  _signInWithEmailAndLink();
    //}
    WidgetsBinding.instance.addObserver(this);
  }

  //@override
  //void didChangeAppLifecycleState(AppLifecycleState state) {
  //  if (state == AppLifecycleState.resumed) {
  //    print("On resumed email is");
  //    print(_email);
  //    // TODO handle on resume
  //    //_retrieveDynamicLink();
  //    //DynamicLinkService deepLinkService = locator<DynamicLinkService>();
  //    //deepLinkService.getLink().then((Uri link) {
  //    //  print("Reconnect on email sent page");
  //    //  print(link.toString());
  //    //  model.repository.getEmail().then((email) {
  //    //    print("Stored email is");
  //    //    model.login(email, link.queryParameters['token']);
  //    //  });
  //    //});
  //  }
  //}

  @override
  Widget build(BuildContext context) {
    final snackBarEmailSent = SnackBar(content: Text('Email Sent!'));
    final snackBarEmailNotSent = SnackBar(
      content: Text('Email Not Sent. Error.'),
    );

    final email = CustomTextFormField(
      style: CustomFormFieldStyle.Dark,
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      validator: (value) {
        if (value.isEmpty) return "Email cannot be empty";
        if (!RegExp(
                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9-]+\.[a-zA-Z-]+")
            .hasMatch(value)) {
          return "Email must be a valid email address";
        }
        return null;
      },
      onSaved: (value) {
        print("Saved");
        _email = value;
        _repositry.setEmail(value);
      },
      hintText: 'e.g. jane.doe@email.com',
    );
    
    final name = CustomTextFormField(
      style: CustomFormFieldStyle.Dark,
      keyboardType: TextInputType.text,
      textCapitalization: TextCapitalization.words,
      autofocus: false,
      validator: (value) {
        if (value.isEmpty) return "Name cannot be empty";
        return null;
      },
      onSaved: (value) {
        print("Saved");
        _name = value;
        _repositry.setName(value);
      },
      hintText: 'Jane Doe',
    );

    Widget loginButton() {
      Future<bool> validateAndSave(UserViewModel model) async {
        final FormState form = _formKey.currentState;
        if (form.validate()) {
          form.save();
          model.email(_email, _name);
          return true;
        }
        return false;
      }

      return StoreConnector<AppState, UserViewModel>(
          converter: (store) => UserViewModel.create(store),
          builder: (_, viewModel) {
            return Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: DarkButton(
                  "Next",
                  onPressed: () {
                    print("Button pressed");
                    validateAndSave(viewModel);
                  },
                ));
          },
          onDidChange: (viewModel) {
            print("view model did change in login");
          });
    }

    Widget skipButton() {
      return StoreConnector<AppState, UserViewModel>(
          converter: (store) => UserViewModel.create(store),
          builder: (_, viewModel) {
            return Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: TextButton(
                  "Skip",
                  onClick: () {
                    viewModel.skipLogin();
                  },
                ));
          });
    }

    Form loginForm() {
      return Form(
          key: _formKey,
          child: Padding(
              padding: EdgeInsets.only(left: 24, right: 24),
              child: SafeArea(
                child: NotificationListener(
                  onNotification: (OverscrollIndicatorNotification overscroll) {
                    overscroll.disallowGlow();
                  },
                  child: ListView(
                    children: [
                      Column(
                        //shrinkWrap: true,
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(top: 30, bottom: 10),
                                child: Text(
                                  "Account Details",
                                  style: textStyleFrom(
                                    Theme.of(context).primaryTextTheme.headline3,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.9,
                                child: Text(
                                  "Enter the email address that you would like to use to access now-u",
                                  textAlign: TextAlign.center,
                                  style: textStyleFrom(
                                    Theme.of(context).primaryTextTheme.headline5,
                                    color: Colors.white,
                                  ),
                                ),
                              ),

                              SizedBox(height: 25),
                            ],
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "What should we call you?",
                                  style: textStyleFrom(
                                    Theme.of(context).primaryTextTheme.headline4,
                                    color: Colors.white,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                              SizedBox(height: 8),
                              name,
                              SizedBox(height: 15),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Your email address",
                                  style: textStyleFrom(
                                    Theme.of(context).primaryTextTheme.headline4,
                                    color: Colors.white,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                              SizedBox(height: 8),
                              email,

                              loginButton(),
                               
                              SizedBox (height: 10),

                              RichText(
                                text: TextSpan(children: [
                                  TextSpan(
                                      text:
                                          "View our privacy policy ",
                                      style: textStyleFrom(
                                        Theme.of(context).primaryTextTheme.bodyText1,
                                        color: Colors.white,
                                      )
                                  ),
                                  TextSpan(
                                      text: "here",
                                      style: textStyleFrom(
                                        Theme.of(context).primaryTextTheme.bodyText1,
                                        color: Theme.of(context).buttonColor,
                                      ),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          launch("https://now-u.com/static/media/now-u_privacy-notice.25c0d41b.pdf");
                                        }),
                                  ]
                                ),
                              ),
                            
                              SizedBox (height: 10),

                            ],
                          ),

                          // Uncomment to readd Skip button
                          //skipButton(),
                        ],
                      ),
                    ]
                  )
                ),
              )));
    }

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Theme.of(context).primaryColorDark,
        body: loginForm(),
      )
    );
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

  void _showDialog(String error) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Error"),
          content: new Text("Please Try Again.Error code: " + error),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

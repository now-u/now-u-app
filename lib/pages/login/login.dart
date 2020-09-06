import 'package:app/assets/StyleFrom.dart';
import 'package:flutter/gestures.dart';
import 'package:app/assets/components/darkButton.dart';
import 'package:app/assets/components/textButton.dart';
import 'package:app/assets/components/inputs.dart';
import 'package:app/assets/routes/customLaunch.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:app/models/State.dart';
import 'package:app/models/ViewModel.dart';
import 'package:app/models/User.dart';
import 'package:app/viewmodels/login_model.dart';

import 'package:app/services/storage.dart';

import 'package:stacked/stacked.dart';

//import 'package:flutter_redux/flutter_redux.dart';

enum LoginTypes{
  Login,
  Signup
}

class LoginPageArguments {
  final bool retry;
  final LoginTypes loginType;
  LoginPageArguments({this.retry, this.loginType});
}

class LoginPage extends StatefulWidget {
  final LoginPageArguments args;

  LoginPage(this.args);
  @override
  LoginPageState createState() => new LoginPageState();
}

class LoginPageState extends State<LoginPage> with WidgetsBindingObserver {
  String _email;
  String _name;
  String _token;
  bool _newsletterSignup = false;

  bool retry;
  final _formKey = GlobalKey<FormState>();
  final _tokenFormKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _repositry = SecureStorageService();

  @override
  void initState() {
    retry = widget.args.retry;
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

    @override
  Widget build(BuildContext context) {

    final email = CustomTextFormField(
      style: CustomFormFieldStyle.Dark,
      keyboardType: TextInputType.emailAddress,
      textCapitalization: TextCapitalization.none,
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
    
    final acceptTandC = CustomCheckboxFormField(
      title: RichText(
        text: TextSpan(
          style: textStyleFrom(
            Theme.of(context).primaryTextTheme.bodyText1,
            color: Colors.white,
          ),
          children: [
            TextSpan(text: "I agree to the user "),
            TextSpan(
              text: "Terms & Conditions",
              style: textStyleFrom(
                Theme.of(context).primaryTextTheme.bodyText1,
                color: Theme.of(context).buttonColor,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  launch("https://share.now-u.com/legal/terms_and_conditions.pdf");
                }
            ),
          ]
        ),
      ),
      validator: (value) {
        if (!value) return "You must accept our terms and conditions";
        return null;
      },
    );
    
    final newsletterSignup = CustomCheckboxFormField(
      title: RichText(
        text: TextSpan(
          style: textStyleFrom(
            Theme.of(context).primaryTextTheme.bodyText1,
            color: Colors.white,
          ),
          children: [
            TextSpan(text: "I am happy to receive the now-u newsletter via email"),
          ]
        ),
      ),
      onSaved: (value) {
        _newsletterSignup = value;
      },
    );
    
    Widget loginButton() {
      Future<bool> validateAndSave(LoginViewModel model) async {
        final FormState form = _formKey.currentState;
        if (form.validate()) {
          form.save();
          //if (stagingUsers.contains(_email)) {
          //  model.switchToStagingBranch();
          //}
          model.email(email: _email, name: _name, newsletterSignup:_newsletterSignup);
          return true;
        }
        return false;
      }

      return ViewModelBuilder<LoginViewModel>.reactive(
        viewModelBuilder: () => LoginViewModel(),
        builder: (context, model, child) => Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: DarkButton(
                  "Next",
                  onPressed: () {
                    print("Button pressed");
                    validateAndSave(model);
                  },
                )
              ) ,
        );
    }

    Form loginForm() {
      return Form(
          key: _formKey,
          child: Padding(
              padding: EdgeInsets.only(left: 24, right: 24),
              child: SafeArea(
                child: Column(
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
                          child: retry ?? false
                           ?  RichText(
                               textAlign: TextAlign.center,
                                text: TextSpan(
                                  style: textStyleFrom(
                                    Theme.of(context).primaryTextTheme.headline5,
                                  ),
                                  children: [
                                  TextSpan(
                                      text:
                                          "If you did not receive the email please double check your spam and give us a few minutes to get it over to you, otherwise please try again. If the issue persists please email ",
                                      style: textStyleFrom(
                                        Theme.of(context).primaryTextTheme.bodyText1,
                                        color: Colors.white,
                                      )
                                  ),
                                  TextSpan(
                                      text: "support",
                                      style: textStyleFrom(
                                        Theme.of(context).primaryTextTheme.bodyText1,
                                        color: Theme.of(context).buttonColor,
                                      ),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          launch("mailto:support@now-u.com?subject=LoginIssue");
                                        }),
                                  ]
                                ),
                              ) 
                            : Text(
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
                              SizedBox(height: 20),
                              acceptTandC,
                              newsletterSignup,

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
                                          customLaunch(context, "http://www.now-u.com/static/media/now-u_privacy-notice.25c0d41b.pdf", isExternal: true);
                                        }),
                                  ]
                                ),
                              ),

                              // Manual entry section
                              retry ?? false ? Container() : 
                              Row( 
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Column(
                                    children: [
                                      SizedBox(height: 15),
                                      CustomTextButton(
                                        "Having issues logging in?",
                                        onClick: () {
                                          setState(() {
                                            retry = true;
                                          });
                                        },
                                        fontSize: Theme.of(context).primaryTextTheme.bodyText1.fontSize,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ]
                                  )
                                ],
                              ),
                              
                              SizedBox (height: 10),

                            ],
                          ),

                          // Uncomment to readd Skip button
                          //skipButton(),
                        ],
                      ),
              )));
    }
    
    final token = CustomTextFormField(
      style: CustomFormFieldStyle.Dark,
      keyboardType: TextInputType.text,
      textCapitalization: TextCapitalization.words,
      autofocus: false,
      validator: (value) {
        if (value.isEmpty) return "Token cannot be empty";
        return null;
      },
      onSaved: (value) {
        _token = value;
      },
      hintText: '5jbNsPu7jdA9bUjN...',
    );
    
    Widget manualButton() {
      Future<bool> validateAndSave(LoginViewModel model) async {
        final FormState form = _tokenFormKey.currentState;
        if (form.validate()) {
          form.save();
          String email = await _repositry.getEmail();
          model.login(email: email, token: _token);
          return true;
        }
        return false;
      }
      return ViewModelBuilder<LoginViewModel>.reactive(
        viewModelBuilder: () => LoginViewModel(),
        builder: (context, model, child) => Padding(
          padding: EdgeInsets.symmetric(vertical: 16.0),
          child: DarkButton(
            "Login",
            onPressed: () {
              print("Button pressed");
              validateAndSave(model);
            },
          )
        ),
      );
    }
    
    Form tokenForm() {
      return Form(
          key: _tokenFormKey,
          child: Padding(
              padding: EdgeInsets.only(left: 24, right: 24),
              child: SafeArea(
                child: Column(
                  //shrinkWrap: true,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        SizedBox(height: 20),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: Text(
                            "If you did receive the email but the link is not working, please enter the manual token, from the email, below",
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
                                  "Manual Token",
                                  style: textStyleFrom(
                                    Theme.of(context).primaryTextTheme.headline4,
                                    color: Colors.white,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                              SizedBox(height: 8),
                              token,
                          
                              SizedBox(height:10),

                              acceptTandC,

                              manualButton(),
                               
                              SizedBox (height: 10),

                            ],
                          ),
                          // Uncomment to readd Skip button
                          //skipButton(),
                        ],
                      ),
              )));
    }

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Theme.of(context).primaryColorDark,
        body: NotificationListener(
          onNotification: (OverscrollIndicatorNotification overscroll) {
            overscroll.disallowGlow();
          },
          child: ListView(
            children: [
              loginForm(),
              retry ?? false 
                ? tokenForm()
                : Container()
            ]
          )
        ),
      )
    );
  }

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

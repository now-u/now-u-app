import 'package:app/assets/StyleFrom.dart';
import 'package:app/assets/components/buttons/customIconButton.dart';
import 'package:app/assets/constants.dart';
import 'package:flutter/gestures.dart';
import 'package:app/assets/components/buttons/darkButton.dart';
import 'package:app/assets/components/inputs.dart';
import 'package:app/services/storage.dart';
import 'package:app/viewmodels/login_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stacked/stacked.dart';
import 'package:url_launcher/url_launcher.dart';

enum LoginTypes { Login, Signup }

class LoginPageArguments {
  final LoginTypes? loginType;
  LoginPageArguments({this.loginType});
}

class LoginPage extends StatefulWidget {
  final LoginPageArguments args;

  LoginPage(this.args);
  @override
  LoginPageState createState() => new LoginPageState();
}

class LoginPageState extends State<LoginPage> with WidgetsBindingObserver {
  String? _email;

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    Widget _emailInput(LoginViewModel model) {
      return CustomTextFormField(
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
        onChanged: (value) {
          print("Saved");
          model.email = value;
        },
        hintText: 'e.g. jane.doe@email.com',
      );
    }

    Widget loginButton(LoginViewModel model) {
      Future<bool> validateAndSave(LoginViewModel model) async {
        final FormState form = _formKey.currentState!;
        if (form.validate()) {
          form.save();
          model.sendLoginEmail();
          return true;
        }
        return false;
      }

      return Padding(
          padding: EdgeInsets.symmetric(vertical: 16.0),
          child: DarkButton(
            "Next",
            onPressed: () {
              print("Button pressed");
              validateAndSave(model);
            },
          ));
    }

    Form loginForm(LoginViewModel model) {
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
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 30.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              CustomIconButton(
                                onPressed: model.loginWithGoogle,
                                icon: FontAwesomeIcons.google,
                                size: IconButtonSize.Small,
                                isCircularButton: false,
                              ),
                              CustomIconButton(
                                onPressed: model.loginWithFacebook,
                                icon: FontAwesomeIcons.facebookF,
                                size: IconButtonSize.Small,
                                isCircularButton: false,
                              ),
                            ],
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
                            "Your email address",
                            style: textStyleFrom(
                              Theme.of(context).primaryTextTheme.headline4,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        SizedBox(height: 8),
                        _emailInput(model),
                        SizedBox(height: 20),
                        loginButton(model),
                        SizedBox(height: 10),
                        RichText(
                          text: TextSpan(children: [
                            TextSpan(
                                text: "View our privacy policy ",
                                style: textStyleFrom(
                                  Theme.of(context).primaryTextTheme.bodyText1,
                                  color: Colors.white,
                                )),
                            TextSpan(
                                text: "here",
                                style: textStyleFrom(
                                  Theme.of(context).primaryTextTheme.bodyText1,
                                  color: Theme.of(context).buttonColor,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    model.launchTandCs();
                                  }),
                          ]),
                        ),
                        SizedBox(height: 10),
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
              return true;
            },
            child: ViewModelBuilder<LoginViewModel>.reactive(
                viewModelBuilder: () => LoginViewModel(),
                onModelReady: (model) => model.init(),
                onDispose: (model) => model.dispose(),
                builder: (context, model, child) {
                  return ListView(children: [
                    loginForm(model),
                  ]);
                }),
          ),
        ));
  }
}

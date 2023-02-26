import 'package:app/assets/StyleFrom.dart';
import 'package:app/assets/components/buttons/darkButton.dart';
import 'package:app/assets/components/inputs.dart';
import 'package:app/assets/components/header.dart';
import 'package:flutter/material.dart';

import 'package:app/viewmodels/login_model.dart';

import 'package:stacked/stacked.dart';

class LoginCodePage extends StatefulWidget {
  final String email;
  LoginCodePage(this.email);
  @override
  LoginCodePageState createState() => new LoginCodePageState();
}

class LoginCodePageState extends State<LoginCodePage>
    with WidgetsBindingObserver {
  String? _token;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final token = CustomTextFormField(
      style: CustomFormFieldStyle.Dark,
      keyboardType: TextInputType.numberWithOptions(decimal: false),
      textCapitalization: TextCapitalization.none,
      autofocus: false,
      validator: (value) {
        if (value.isEmpty) return "Please enter the secret code from the email";
        if (value.length != 6) return "The secret code must be 6 digits long";
        return null;
      },
      onSaved: (value) {
        _token = value;
      },
      hintText: 'e.g. 123456',
    );

    Widget loginButton() {
      Future<bool> validateAndSave(LoginViewModel model) async {
        final FormState form = _formKey.currentState!;
        if (form.validate()) {
          form.save();
          model.loginWithCode(email: widget.email, token: _token!);
          return true;
        }
        return false;
      }

      return ViewModelBuilder<LoginViewModel>.reactive(
        viewModelBuilder: () => LoginViewModel(),
        onModelReady: (model) => model.init(),
        onDispose: (model) => model.dispose(),
        builder: (context, model, child) => Padding(
            padding: EdgeInsets.symmetric(vertical: 16.0),
            child: DarkButton(
              "Log in",
              onPressed: () {
                validateAndSave(model);
              },
            )),
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
                    PageHeader(
                      title: "Complete login",
                      backButton: true,
                      textColor: Colors.white,
                    ),

                    SizedBox(height: 35),

                    Center(
                        child: ClipRRect(
                      child: Container(
                        width: 65,
                        child: Image.asset('assets/imgs/logo.png'),
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(3)),
                    )),

                    SizedBox(
                      height: 35,
                    ),
                    Text(
                      "Type in your 6 digit code from the email to log into now-u",
                      style: textStyleFrom(
                        Theme.of(context).primaryTextTheme.headline3,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 35,
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Your secret 6 digit code",
                            style: textStyleFrom(
                              Theme.of(context).primaryTextTheme.headline4,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        SizedBox(height: 8),
                        token,
                        loginButton(),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    )

                    // Uncomment to readd Skip button
                    //skipButton(),
                  ],
                ),
              )));
    }

    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          backgroundColor: Theme.of(context).primaryColorDark,
          body: NotificationListener(
              onNotification: (OverscrollIndicatorNotification overscroll) {
                overscroll.disallowGlow();
                return true;
              },
              child: ListView(children: [
                loginForm(),
              ])),
        ));
  }
}

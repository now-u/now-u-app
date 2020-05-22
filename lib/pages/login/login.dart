import 'package:app/assets/StyleFrom.dart';
import 'package:app/assets/components/darkButton.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

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

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      print("On resumed email is");
      print(_email);
      // TODO handle on resume
      //_retrieveDynamicLink();
      //DynamicLinkService deepLinkService = locator<DynamicLinkService>();
      //deepLinkService.getLink().then((Uri link) {
      //  print("Reconnect on email sent page");
      //  print(link.toString());
      //  model.repository.getEmail().then((email) {
      //    print("Stored email is");
      //    model.login(email, link.queryParameters['token']);
      //  });
      //});
    }
  }

  @override
  Widget build(BuildContext context) {
    final snackBarEmailSent = SnackBar(content: Text('Email Sent!'));
    final snackBarEmailNotSent = SnackBar(
      content: Text('Email Not Sent. Error.'),
    );

    final email = TextFormField(
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.go,
      autofocus: true,
      validator: (value) {
        if (value.isEmpty) return "Email cannot be empty";
        return null;
      },
      onSaved: (value) {
        print("Saved");
        _email = value;
        _repositry.setEmail(value);
      },
      style: textStyleFrom(
        Theme.of(context).primaryTextTheme.headline5,
        color: Colors.white,
      ),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 15),
        filled: true,
        fillColor: Color.fromRGBO(221,221,221,0.2),

        hintText: 'e.g. jane.doe@email.com',
        hintStyle: TextStyle(
          color: colorFrom(
            Theme.of(context).primaryColor,
            opacity: 0.5,
          ),
        ),
        //labelText: 'Your email address',
        //labelStyle: textStyleFrom(
        //  Theme.of(context).primaryTextTheme.headline3,
        //  color: Colors.white
        //),
        ////floatingLabelBehavior: FloatingLabelBehavior.never,
        //alignLabelWithHint: true,
        //border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    Widget loginButton() {
      Future<bool> validateAndSave(UserViewModel model) async {
        final FormState form = _formKey.currentState;
        if (form.validate()) {
          form.save();
          model.email(_email);
          return true;
        }
        return false;
      }
      return 
       StoreConnector<AppState, UserViewModel>(
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
              )
            );
         },
         onDidChange: (viewModel) {
            print("view model did change in login");
         }
      );
    }


    Form loginForm() {
      return 
        Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.only(left: 24, right: 24),
            child: SafeArea( 
              child: Column(
                //shrinkWrap: true,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 30, bottom: 10),
                        child: Text("Account Details",
                          style: textStyleFrom(
                            Theme.of(context).primaryTextTheme.headline3,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: Text(
                          "Enter the email address that you would like to use to access now-u",
                          textAlign: TextAlign.center,
                          style: textStyleFrom(
                            Theme.of(context).primaryTextTheme.headline5,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
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
                      SizedBox(height: 10),
                      email,
                    ],
                  ),
                  loginButton(),
                ],
              ),
            )
          )
        );
    }
    return 
      Scaffold(
        key: _scaffoldKey,
        backgroundColor: Theme.of(context).primaryColorDark,
        body: loginForm(),
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

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

import 'package:app/models/State.dart';
import 'package:app/models/ViewModel.dart';

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
      autofocus: false,
      validator: (value) {
        if (value.isEmpty) return "Email cannot be empty";
        return null;
      },
      onSaved: (value) {
        _email = value;
        _repositry.setEmail(value);
      },
      decoration: InputDecoration(
        hintText: 'Email',
        prefixIcon: Icon(Icons.mail),
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
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
              child: RaisedButton(
                color: Colors.lightBlueAccent,
                textColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
                child: Text("Send Verification Email"),
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
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.only(left: 24, right: 24),
            children: <Widget>[
              SizedBox(height: 50),
              email,
              SizedBox(height: 40),
              loginButton()
            ],
          ),
        );
    }
    return 
      Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.white,
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

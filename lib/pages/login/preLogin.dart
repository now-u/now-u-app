import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:app/pages/login/login.dart';

class FirstWidget extends StatefulWidget {
  @override
  FirstWidgetState createState() => new FirstWidgetState();
}

class FirstWidgetState extends State<FirstWidget> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: StreamBuilder<FirebaseUser>(
            stream: FirebaseAuth.instance.onAuthStateChanged,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.active) {
                FirebaseUser user = snapshot.data;
                if (user == null) {
                  return LoginPage();
                }
                return LoggedIn();
              } else {
                print("error"); //Connection Inactive, show error dialog
                return Center(child: Text("UHOH"),);
              }
            },
          ),
        ),
      ),
    );
  }
}

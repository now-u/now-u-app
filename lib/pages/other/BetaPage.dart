import 'package:flutter/material.dart';
import 'package:app/assets/components/darkButton.dart';

class BetaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Text("This app is in beta"),
          SizedBox(height: 20),
          DarkButton(
            "Continue",
            onPressed: () {
              Navigator.of(context).pushNamed('/');
            }
          )
        ]
      ), 
    );
  }
}

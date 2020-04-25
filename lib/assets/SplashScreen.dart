import 'dart:async';
import 'package:flutter/material.dart';

import 'package:app/assets/routes/customRoute.dart';

import 'package:app/models/ViewModel.dart';

import 'package:app/pages/Tabs.dart';

class SplashScreen extends StatefulWidget {
  ViewModel model;
  SplashScreen(this.model);
  @override
  _SplashScreenState createState() => new _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {  
  ViewModel model; 
  startTime() async {
    var _duration = new Duration(seconds: 2);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() {
    Navigator.push(
      context,
      CustomRoute(builder: (context) => TabsPage(model))
    );
  }

  @override
  void initState() {
    model = widget.model;
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
  print("In the splash screen");
  print(model.user.getName());
  return new Scaffold(
    body: new Container(
      color: Colors.red,
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
    ),
  );
  }
}

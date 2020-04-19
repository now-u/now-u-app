import 'package:app/assets/routes/customRoute.dart';
import 'package:flutter/material.dart';

import 'package:app/assets/components/pageTitle.dart';
import 'package:app/assets/components/darkButton.dart';

import 'package:app/main.dart';

class ProgressPage extends StatelessWidget {
  GestureTapCallback _goBack;
  
  ProgressPage(goBack) {
    _goBack = goBack;
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView (
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          PageTitle("Progress", hasBackButton: true, onClickBackButton: _goBack,),
          Text(
              "Current Campaigns Progress", 
              style: Theme.of(context).primaryTextTheme.display2,
              textAlign: TextAlign.center,
          ),
          Padding(
            padding: EdgeInsets.all(10),     
            child: Stack(
              children: <Widget>[
                Container(color: Colors.red, width: 300, height: 40,),
                Container(color: Colors.blue, width: 200, height: 40,) 
              ],
            ),
          ),
          DarkButton(
            "View Campaigns", 
            onPressed: () {
              Navigator.push(
                context,
                CustomRoute(builder: (context) => App(currentIndex: 0,))
              );
            },
          ),
          Container(
              height: MediaQuery.of(context).size.width * 0.3 ,
              child: Image(image: AssetImage('assets/imgs/partyPopperEmoji.png'),),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Text("You have completed 6 campaigns"),
          ),
          DarkButton(
            "Completed Campaigns", 
            onPressed: () {
              Navigator.push(
                context,
                CustomRoute(builder: (context) => App(currentIndex: 0,))
              );
            },
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Text("Highlights from you Campaigns"),
          ),
          // Highlights
          Text("Highlight 1"),
          Text("Highlight 2")
        ], 
      )
    );
  }
}

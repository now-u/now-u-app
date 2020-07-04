import 'package:flutter/material.dart';

import 'package:app/assets/components/pageTitle.dart';
import 'package:app/assets/components/darkButton.dart';

import 'package:app/pages/Tabs.dart';
import 'package:app/routes.dart';

import 'package:app/models/ViewModel.dart';

class ProgressPage extends StatelessWidget {
  final GestureTapCallback _goBack;
  final ViewModel model;
  
  
  ProgressPage(this._goBack, this.model);

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
          Text(
              "${ model.userModel.user.getActiveCampaignsProgress(model.campaigns) }", 
              style: Theme.of(context).primaryTextTheme.display2,
              textAlign: TextAlign.center,
          ),
          Padding(
            padding: EdgeInsets.all(10),     
            child: ProgressBar(
              progress: model.userModel.user.getActiveCampaignsProgress(model.campaigns),     
              width: MediaQuery.of(context).size.width * 0.9,
            ),
          ),
          DarkButton(
            "View Campaigns", 
            onPressed: () {
              Navigator.of(context).pushNamed(Routes.campaign);
            },
          ),
          Container(
              height: MediaQuery.of(context).size.width * 0.3 ,
              child: Image(image: AssetImage('assets/imgs/partyPopperEmoji.png'),),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Text("You have taken part in ${ model.userModel.user.getSelectedCampaigns().length } campaigns"),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Text("You have completed ${ model.userModel.user.getCompletedActions().length } actions"),
          ),
          DarkButton(
            "Completed Campaigns", 
            onPressed: () {
              Navigator.of(context).pushNamed(Routes.campaign);
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

class ProgressBar extends StatelessWidget {
  final double width;
  final double progress;

  ProgressBar({
    @required this.progress,
    @required this.width,
  });
  
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          Container(color: Colors.red, width: width, height: 40,),
          Container(color: Colors.blue, width: width*progress, height: 40,) 
        ],
      ),
    );
  }
}

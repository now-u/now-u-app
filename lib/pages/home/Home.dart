import 'package:app/assets/components/darkButton.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:app/pages/home/HomeTile.dart';

import 'package:app/assets/components/pageTitle.dart';
import 'package:app/assets/components/selectionItem.dart';

import 'package:app/models/Campaign.dart';
import 'package:app/models/ViewModel.dart';
import 'package:app/models/Action.dart';

const double BUTTON_PADDING = 10;

class Home extends StatelessWidget {
  ViewModel model;
  Home(this.model);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
              color: Colors.white,
              child: Column(
                  children: <Widget>[
                    PageTitle("Home"),
                    HomeTile(
                        Container(
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    sectionTitle("Actions", context),
                                    ActionTile(model.campaigns.getCampaigns()[0].getActions()),
                                  ],
                                  )
                            ),
                    ), 
                    HomeTile(
                        Container(
                              child: Column(
                                  children: <Widget>[
                                    sectionTitle("Congratulations", context),
                                    SelectionItem("You Completed 10 Actions"),
                                    sectionTitle("Other progress...", context),
                                    SelectionItem("Make 1 more donation to complete 'Make 5' donations"),
                                    Padding(
                                      padding: EdgeInsets.all(BUTTON_PADDING),
                                      child: DarkButton("See More Rewards", onPressed: () {},),
                                    ),
                                    // TODO Progress Slider thing
                                  ],
                                  )
                            ),
                    ), 
                  ],
                  
                  )
            ),
    );
  }
}

Text sectionTitle(String t, BuildContext context) {
  return Text(t, style: Theme.of(context).primaryTextTheme.headline, textAlign: TextAlign.start,);
}

class ActionTile extends StatelessWidget {
  List<CampaignAction> actions;
  ActionTile(this.actions);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
      },
      child: Padding(
          padding: EdgeInsets.fromLTRB(10, 0, 5, 10),
          child: 
            Column(
              children: <Widget>[
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 3,
                  itemBuilder: 
                    (BuildContext context, int index) => SelectionItem(actions[index].getTitle()),
                ),
                Padding(
                  padding: EdgeInsets.all(BUTTON_PADDING),
                  child: DarkButton("See More Actions", onPressed: () {},),
                ),
                //ActionItem(user.getFollowUpAction()),
                //TODO Work ou where follow up actions should be
              ]
          )
      )
    );
  }
}

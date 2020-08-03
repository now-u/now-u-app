import 'package:app/assets/StyleFrom.dart';
import 'package:app/assets/components/darkButton.dart';
import 'package:app/assets/components/header.dart';
import 'package:app/assets/components/selectionItem.dart';
import 'package:app/models/Action.dart';
import 'package:app/models/Campaign.dart';
import 'package:app/models/Campaigns.dart';
import 'package:app/models/State.dart';
import 'package:app/models/ViewModel.dart';
import 'package:app/pages/action/ActionPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import '../../routes.dart';

class PastCampaignActionPage extends StatefulWidget {
  Campaign campaign;
  PastCampaignActionPage(this.campaign);
//  Campaigns campaigns; //already defining in the State
//  PastCampaignActionPage({this.campaigns}) //i am going to use ModalRoute to take the arguements so constructor is not needed
  @override
  _PastCampaignActionPageState createState() => _PastCampaignActionPageState();
}

class _PastCampaignActionPageState extends State<PastCampaignActionPage> {
  List<CampaignAction> actions2 = [];
  Map data = {};
  List<CampaignAction> actions = []; //used in ActionPage
  Map<String, Map> selections = {
    "times": {},
    "campaigns": {},
    "categories": {},
    "extras": {
      "todo": true,
      "completed": true,
      "rejected": false,
      "starred": true,
    }
  };
  initState() {
    //complex actions here
    for (int i = 0; i < timeBrackets.length; i++) {
      selections['times'][timeBrackets[i]['text']] = false;
    }
    for (int i = 0; i < CampaignActionSuperType.values.length; i++) {
      selections['categories'][CampaignActionSuperType.values[i]] = false;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Campaign campaign = widget.campaign;
    actions = campaign.getActions();

    return StoreConnector<AppState, ViewModel>(
        converter: (Store<AppState> store) => ViewModel.create(store),
        builder: (BuildContext context, ViewModel viewModel) {
          return SafeArea(
            child: Scaffold(
//        backgroundColor: colorFrom(
//          Theme.of(context).primaryColorDark,
//          opacity: 0.9,
//        ),
              backgroundColor: Colors.white,
              body: ListView(
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                children: [
//                  Stack(
//                    fit: StackFit.loose,
//
//                    children: <Widget>[
//                      // Max Size
//                     Image(
//                       height: 120,
//                       image: NetworkImage(campaign.getHeaderImage()),
//                       fit: BoxFit.fill,
//                     ),
//                      Container(
//                        height: 120,
//                        decoration: BoxDecoration(
//                          gradient: LinearGradient(
//                            begin: Alignment.topCenter,
//                            end:Alignment.bottomCenter,
//                            colors: [Colors.black,Colors.white54],
//                          ),
//                        ),
//                        child: Text("H"),
//                      ),
//                    ],
//                  ),





                  ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: actions.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                            padding: EdgeInsets.symmetric(horizontal: 0),
                            child: ActionSelectionItem(
                              outerHpadding: 10,
                              campaign: campaign,
                              action: actions[index],
                              backgroundColor: Colors.white,
                            ));
                      }),
                ],
              ),
            ),
          );
        });
  }


}

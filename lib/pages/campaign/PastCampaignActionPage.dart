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
  @override
  _PastCampaignActionPageState createState() => _PastCampaignActionPageState();
}

const double HEADER_HEIGHT = 140;

class _PastCampaignActionPageState extends State<PastCampaignActionPage> {
  
  List<CampaignAction> actions = []; //used in ActionPage
  
  @override
  Widget build(BuildContext context) {
    actions = widget.campaign.getActions();

    return StoreConnector<AppState, ViewModel>(
        converter: (Store<AppState> store) => ViewModel.create(store),
        builder: (BuildContext context, ViewModel viewModel) {
          return SafeArea(
            child: Scaffold(
              backgroundColor: Colors.white,
              body: ListView(
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                children: [
                  Container(
                    child: Stack(
                      children: [
                        Container(
                          height: HEADER_HEIGHT,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(widget.campaign.getHeaderImage()),
                              fit: BoxFit.cover,
                            ),
                          )
                        ),
                        Container(
                          height: HEADER_HEIGHT,
                          color: colorFrom(
                            Colors.black,
                            opacity: 0.5,
                          )
                        ),
                        PageHeader(
                          title: widget.campaign.getTitle(),
                          textColor: Colors.white,
                          backButton: true,
                          maxLines: 2,
                        ),
                      ],
                    )
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: actions.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 0),
                          child: ActionSelectionItem(
                            outerHpadding: 10,
                            campaign: widget.campaign,
                            action: actions[index],
                            backgroundColor: Colors.white,
                          ));
                    }
                  ),
                ],
              ),
            ),
          );
        });
  }


}

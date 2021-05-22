import 'package:app/assets/StyleFrom.dart';
import 'package:app/assets/components/header.dart';
import 'package:app/assets/components/selectionItem.dart';
import 'package:app/assets/components/custom_network_image.dart';
import 'package:app/models/Action.dart';
import 'package:app/models/Campaign.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const double HEADER_HEIGHT = 140;

class PastCampaignActionPage extends StatelessWidget {
  final Campaign campaign;
  PastCampaignActionPage(this.campaign);

  @override
  Widget build(BuildContext context) {
    List<CampaignAction> actions = campaign.getActions();
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
                        image: customNetworkImageProvider(
                            campaign.getHeaderImage()),
                        fit: BoxFit.cover,
                      ),
                    )),
                Container(
                    height: HEADER_HEIGHT,
                    color: colorFrom(
                      Colors.black,
                      opacity: 0.5,
                    )),
                PageHeader(
                  title: campaign.getTitle(),
                  textColor: Colors.white,
                  backButton: true,
                  maxLines: 2,
                ),
              ],
            )),
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
  }
}

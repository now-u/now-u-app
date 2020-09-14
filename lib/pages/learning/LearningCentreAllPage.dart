import 'package:app/assets/components/header.dart';
import 'package:flutter/material.dart';

import 'package:stacked/stacked.dart';
import 'package:app/viewmodels/base_campaign_model.dart';

import 'package:app/assets/components/selectionItem.dart';
import 'package:app/assets/components/customScrollableSheet.dart';

const double CIRCLE_1_RADIUS = 150;
const double CIRCLE_2_RADIUS = 250;

class LearningCentreAllPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ViewModelBuilder<BaseCampaignViewModel>.reactive(
        viewModelBuilder: () => BaseCampaignViewModel(),
        builder: (context, model, child) {
          return ScrollableSheetPage(
              sheetBackgroundColor: Colors.white,
              scaffoldBackgroundColor: Colors.white,
              shadow: Shadow(color: Colors.transparent),
              maxChildSize: 0.72,
              // Header
              header: 
                Container(
                  color: Color.fromRGBO(247,248,252,1),
                  height: MediaQuery.of(context).size.height * (1-0.6),
                  child: Stack(
                    children: [
                      Positioned(
                        right: -30,
                        bottom: -10,
                        child: Image.asset(
                          "assets/imgs/graphics/ilstr_learning@3x.png",
                          height: MediaQuery.of(context).size.height * 0.3,
                        ),
                      ),
                      PageHeader(
                        title: "Learning Hub",
                        infoTitle: "Learning Hub",
                        infoText: "Driving change starts with being informed.\n Our learning actions give you the fundamental knowledge to better understand the issue, why it’s so important, what’s being done to tackle it, and how you can help make a difference.\n In our Learning Hub, we provide short and informative answers to key questions about each campaign issue, as well as extra learning resources so you can dive deeper into the topic. Educate yourself on campaign topics to become an effective advocate for your cause, and help contribute new ideas for driving change.",
                      )
                    ],
                  ),
                ),
              // BODY
              children: [
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: model.campaigns.length,
                  itemBuilder: (context, index) {
                    return LearningCentreCampaignSelectionItem(
                      campaign: model.campaigns[index],
                      onWhiteBackground: true,
                    );
                  },
                ),
                SizedBox(height: 20),
              ]
          );
      },
    ));
  }
}

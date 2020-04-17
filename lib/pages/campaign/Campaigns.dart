import 'package:flutter/material.dart';
import 'package:app/assets/components/customFloatingActionButton.dart';
import 'package:app/pages/campaign/CampaignTile.dart';
import 'package:app/models/Campaign.dart';

List<Campaign> campaigns = List<Campaign>(3);

class Campaigns extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    campaigns[0] = Campaign(1, "Refugees", "Help with the things", 270, "https://cdn.pixabay.com/photo/2013/04/16/14/23/eritrea-105081_960_720.jpg");
    campaigns[1] = Campaign(1, "Other Thing", "Help with the things", 170, "https://cdn.pixabay.com/photo/2013/04/16/14/23/eritrea-105081_960_720.jpg");
    campaigns[2] = Campaign(1, "Other2", "Help with the things", 320, "https://cdn.pixabay.com/photo/2013/04/16/14/23/eritrea-105081_960_720.jpg");
    return Scaffold(
        body: SafeArea(
                child: Column(
                  children: <Widget>[
                    Padding(
                        padding: EdgeInsets.all(15),
                        child: Text("Campaigns", style: Theme.of(context).primaryTextTheme.title),
                    ),
                    
                    Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                        child: Text("Click to learn more...", style: Theme.of(context).primaryTextTheme.subtitle),
                    ),
                    
                    CampaignTile(campaigns[0]),
                    CampaignTile(campaigns[1]),
                    CampaignTile(campaigns[2]),
                  ], 
                ),
              ),
        floatingActionButton: CustomFloatingActionButton(text: "Select Campaigns", ),
      );
    }
}

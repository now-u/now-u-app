import 'package:flutter/material.dart';
import 'package:app/assets/components/darkButton.dart';
import 'package:app/pages/campaign/CampaignTile.dart';
import 'package:app/models/Campaign.dart';

var campaigns = new List<Campaign>(3);

bool _selectionMode = false;

class Campaigns extends StatefulWidget {
  @override
  _CampaignsState createState() => _CampaignsState();
}

class _CampaignsState extends State<Campaigns> {

  @override
  Widget build(BuildContext context) {
    campaigns[0] = Campaign(1, "Refugees", "Help with the things", 270, "https://cdn.pixabay.com/photo/2013/04/16/14/23/eritrea-105081_960_720.jpg", false);
    campaigns[1] = Campaign(2, "Other Thing", "Help with the things", 170, "https://cdn.pixabay.com/photo/2013/04/16/14/23/eritrea-105081_960_720.jpg", false);
    campaigns[2] = Campaign(3, "Other2", "Help with the things", 320, "https://cdn.pixabay.com/photo/2013/04/16/14/23/eritrea-105081_960_720.jpg", false);
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
                    
                    CampaignTile(campaigns[0], selectionMode: _selectionMode),
                    CampaignTile(campaigns[1], selectionMode: _selectionMode),
                    CampaignTile(campaigns[2], selectionMode: _selectionMode),
                    Padding (
                        padding: EdgeInsets.all(14),
                        child: DarkButton(
                          "Select Campaigns",
                          onPressed: () {
                            setState(() {
                               _selectionMode = !_selectionMode;
                             }); 
                          },
                        )
                    ),
                  ], 
                ),
              ),
        //floatingActionButton: CustomFloatingActionButton(text: "Select Campaigns", ),
      );
    }
}

import 'package:flutter/material.dart';
import 'package:app/assets/components/customFloatingActionButton.dart';
import 'package:app/pages/campaign/CampaignTile.dart';

class Campaigns extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
                child: Column(
                  children: <Widget>[
                    CampaignTile() 
                  ], 
                ),
              ),
        floatingActionButton: CustomFloatingActionButton(text: "Select Campaigns", ),
      );
    }
}

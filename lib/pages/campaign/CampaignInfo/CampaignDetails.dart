import 'package:flutter/material.dart';

import 'package:app/assets/components/header.dart';
import 'package:app/models/Campaign.dart';

class CampaignDetails extends StatelessWidget {
  final Campaign _campaign;

  CampaignDetails(this._campaign);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          PageHeaderBackButton(backButton: true),
          SizedBox(height: 10),
          Padding(
              padding: EdgeInsets.only(left: 20, right: 20, bottom: 15),
              child: Text(
                _campaign.getTitle()!,
                style: Theme.of(context).primaryTextTheme.headline3,
              )),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Text(
                _campaign.getDescription(),
                style: Theme.of(context).primaryTextTheme.bodyText1,
              )),
        ],
      ),
    );
  }
}

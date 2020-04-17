import 'package:flutter/material.dart';
import 'package:app/models/Campaign.dart';
import 'package:app/pages/campaign/CampaignInfo/CampaignInfo.dart';
import 'package:app/assets/routes/customRoute.dart';

class CampaignTile extends StatelessWidget {
  
  Campaign _campaign;
  
  CampaignTile(campaign) {
    _campaign = campaign;
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
       child: GestureDetector(
           onTap: () {
              Navigator.push(
                    context, 
                    CustomRoute(builder: (context) => CampaignInfo(_campaign))
                  );
           },
           child: Stack(
              children: <Widget>[
                // Image
                Hero(
                    tag: "CampaignHeaderImage${_campaign.getId()}",
                    child: 
                      Container(decoration: BoxDecoration(
                        image: DecorationImage( 
                                   image: NetworkImage(_campaign.getHeaderImage()), 
                                   fit: BoxFit.cover, 
                               ),
                        )
                      ),
                ),
                // Gradient
                Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [const Color.fromRGBO(0, 0,0, 0), Color.fromRGBO(0, 0,0, 0.4)],
                      )
                  ),
                ),
                // Text
                Container(
                   width: MediaQuery.of(context).size.width,
                   child: Padding(
                      padding: EdgeInsets.all(26),
                      child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Text(_campaign.getTitle().toUpperCase(), style: Theme.of(context).primaryTextTheme.display1,),
                              Text(_campaign.getNumberOfCampaigners().toString() + " campaigners", style: Theme.of(context).primaryTextTheme.body2,),
                            ], 
                          ),
                          ) 
                   )
              ], 
           ),
          )
    );
  }
}

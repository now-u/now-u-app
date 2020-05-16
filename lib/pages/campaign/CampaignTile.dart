import 'package:flutter/material.dart';

import 'package:app/models/Campaign.dart';
import 'package:app/models/User.dart';
import 'package:app/models/ViewModel.dart';

import 'package:app/pages/campaign/CampaignInfo/CampaignInfo.dart';
import 'package:app/assets/routes/customRoute.dart';
import 'package:app/assets/components/textButton.dart';
import 'package:app/assets/StyleFrom.dart';

class CampaignTile extends StatefulWidget {
  
  final ViewModel model;
  final Campaign campaign;

  CampaignTile(this.campaign, this.model);
  
  @override
  _CampaignTileState createState() => _CampaignTileState();
}

class _CampaignTileState extends State<CampaignTile> {
  User _user;
  bool selected;
 
  @override
  void initState () {
    print("Initialising state");
    _user = widget.model.user;
    selected = widget.model.campaigns.getActiveCampaigns().contains(widget.campaign.getId());
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    //_user = widget.model.user;
    
    GestureTapCallback _onTapMoreInfo =  () {
      Navigator.push(
        context, 
        CustomRoute(builder: (context) => CampaignInfo(campaign: widget.campaign, model: widget.model))
      );
    };

    GestureTapCallback _onTapSelect =  () {
      setState(() {
        if (widget.campaign.isSelected(_user.getSelectedCampaigns())) {
          _user.removeSelectedCamaping(widget.campaign.getId());
        } else {
          _user.addSelectedCamaping(widget.campaign.getId());
        }
      });
    };
    var borderRadius = 20.0;
    var hPadding = 15.0;
    return 
      Padding(
        padding: EdgeInsets.only(left: hPadding, right: hPadding, top: 16, bottom: 8),
        child: Container(
          decoration: BoxDecoration(
           color: Colors.white,
           borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
           boxShadow: [
             BoxShadow(
               color: Color.fromRGBO(0,0,0,0.16),
               offset: Offset(0, 8),
               blurRadius: 6
             )
           ]
          ),
          child: GestureDetector(
            onTap: _onTapMoreInfo,
            child: 
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
              child: Column(
                children: <Widget>[
                  // Image
                  Container(
                    height: 180,
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage( 
                            image: NetworkImage(widget.campaign.getHeaderImage()), 
                            fit: BoxFit.cover, 
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(10))
                        )
                      ),
                    ),
                  ),
                  // Title
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: hPadding),
                    child: Text(
                      widget.campaign.getTitle(), 
                      textAlign: TextAlign.left,
                      style: textStyleFrom(
                        Theme.of(context).primaryTextTheme.headline3,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 5, bottom: 10, left: hPadding, right: hPadding),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.people,
                              size: 18,
                            ),
                            SizedBox(width: 2),
                            Text(
                              widget.campaign.getNumberOfCampaigners().toString() + " campaigners", 
                              style: textStyleFrom(
                                Theme.of(context).primaryTextTheme.headline5,
                                fontWeight: FontWeight.w500,
                                color: Color.fromRGBO(63,61,86,1),
                              ),
                            ),
                          ],
                        ),
                        TextButton(
                          "See more",
                          iconRight: true,
                          onClick: null,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 45,
                    width: double.infinity,
                    color: selected ? Theme.of(context).primaryColor : Color.fromRGBO(187,187,187,1),
                    child: Center(
                      child: 
                      !selected ? 
                      Text(
                        "Not joined",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white
                        ),
                      ) 
                      :
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Icon(
                            Icons.check_circle,
                            size: 15,
                            color: Colors.white,
                          ),
                          SizedBox(width: 5),
                          Text(
                            "Joined",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white
                            ),
                          )
                        ],
                      )
                    )
                  )
                ],
              ),
          ),
        ),
      )
    );
  }
}

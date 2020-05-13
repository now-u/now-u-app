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
  final Campaign _campaign;
  final bool selectionMode;

  CampaignTile(this._campaign, this.model, { this.selectionMode });
  
  @override
  _CampaignTileState createState() => _CampaignTileState();
}

class _CampaignTileState extends State<CampaignTile> {
  bool _selectionMode;
  User _user;
 
  @override
  void initState () {
    print("Initialising state");
    print(widget.selectionMode);
    _selectionMode = widget.selectionMode ?? false;
    _user = widget.model.user;
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    _selectionMode = widget.selectionMode ?? false;
    //_user = widget.model.user;
    
    GestureTapCallback _onTapMoreInfo =  () {
      Navigator.push(
        context, 
        CustomRoute(builder: (context) => CampaignInfo(campaign: widget._campaign, model: widget.model))
      );
    };

    GestureTapCallback _onTapSelect =  () {
      setState(() {
        if (widget._campaign.isSelected(_user.getSelectedCampaigns())) {
          _user.removeSelectedCamaping(widget._campaign.getId());
        } else {
          _user.addSelectedCamaping(widget._campaign.getId());
        }
      });
    };
    var borderRadius = 10.0;
    return 
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Container(
         height: 250,
         decoration: BoxDecoration(
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
             onTap: _selectionMode ? _onTapSelect : _onTapMoreInfo,
             child: Stack(
                children: <Widget> [
                  Padding(
                     padding: widget._campaign.isSelected(_user.getSelectedCampaigns()) && _selectionMode ? EdgeInsets.fromLTRB(35, 30, 35, 30) : EdgeInsets.all(0), 
                     child: Stack(
                        children: <Widget>[
                          // Image
                          Container(
                              decoration: BoxDecoration(
                               borderRadius: BorderRadius.all(Radius.circular(borderRadius))
                              ),
                              //tag: "CampaignHeaderImage${widget._campaign.getId()}",
                              child: 
                                Container(decoration: BoxDecoration(
                                    image: DecorationImage( 
                                      image: NetworkImage(widget._campaign.getHeaderImage()), 
                                      fit: BoxFit.cover, 
                                    ),
                                    borderRadius: BorderRadius.all(Radius.circular(borderRadius))
                                  )
                                ),
                          ),
                          // Gradient
                          Container(
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [const Color.fromRGBO(0, 0,0, 0), Color.fromRGBO(0, 0,0, 0.5)],
                                ),
                                borderRadius: BorderRadius.all(Radius.circular(borderRadius))
                            ),
                          ),
                          // Text
                          Container(
                             width: MediaQuery.of(context).size.width,
                             decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(borderRadius))
                             ),
                             child: Padding(
                                padding: EdgeInsets.symmetric(horizontal:15, vertical: 9),
                                child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          widget._campaign.getTitle(), 
                                          style: textStyleFrom(
                                            Theme.of(context).primaryTextTheme.headline3,
                                            color: Colors.white,
                                          ),
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Row(
                                              children: <Widget>[
                                                Icon(
                                                  Icons.people,
                                                  color: Colors.white,
                                                  size: 16,
                                                ),
                                                Text(
                                                  widget._campaign.getNumberOfCampaigners().toString() + " campaigners", 
                                                  style: textStyleFrom(
                                                    Theme.of(context).primaryTextTheme.headline5,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.white,
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
                                      ], 
                                    ),
                                    ) 
                             )
                        ], 
                     ),
                   ),
                   Padding(
                        padding: EdgeInsets.all(15),
                        child: 
                          Material(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(45),
                            shadowColor:  Color.fromRGBO(69, 91, 99, 0.4),
                            elevation: 30.0,
                            child: 
                              Container(
                                height: widget._campaign.isSelected(_user.getSelectedCampaigns()) && _selectionMode 
                                        ? 90 
                                        : 0,  
                                width: widget._campaign.isSelected(_user.getSelectedCampaigns()) && _selectionMode 
                                       ? 90 
                                       : 0,  
                                child: widget._campaign.isSelected(_user.getSelectedCampaigns()) && _selectionMode 
                                       ? Icon(Icons.check, size: 50,) 
                                       : null,
                              ),
                          )
                       )
               ],
              )
            )
        )
      );
  }
}

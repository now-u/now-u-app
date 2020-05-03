import 'package:flutter/material.dart';

import 'package:app/models/Campaign.dart';
import 'package:app/models/User.dart';
import 'package:app/models/ViewModel.dart';

import 'package:app/pages/campaign/CampaignInfo/CampaignInfo.dart';
import 'package:app/assets/routes/customRoute.dart';

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

    return Container(
       height: 300,
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
                            //tag: "CampaignHeaderImage${widget._campaign.getId()}",
                            child: 
                              Container(decoration: BoxDecoration(
                                image: DecorationImage( 
                                           image: NetworkImage(widget._campaign.getHeaderImage()), 
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
                                      Text(widget._campaign.getTitle().toUpperCase(), style: Theme.of(context).primaryTextTheme.display1,),
                                      Text(widget._campaign.getNumberOfCampaigners().toString() + " campaigners", style: Theme.of(context).primaryTextTheme.body2,),
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
    );
  }
}

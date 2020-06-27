import 'package:flutter/material.dart';

import 'package:app/models/Campaign.dart';
import 'package:app/models/User.dart';
import 'package:app/models/ViewModel.dart';
import 'package:app/models/State.dart';

import 'package:app/pages/campaign/CampaignInfo/CampaignInfo.dart';
import 'package:app/assets/routes/customRoute.dart';
import 'package:app/assets/components/joinedIndicator.dart';
import 'package:app/assets/components/textButton.dart';
import 'package:app/assets/StyleFrom.dart';

import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

class Tile extends StatelessWidget {
  final Widget child;
  final double borderRadius;
  final double hPadding;
  final Function onTap;
  Tile({this.child, this.borderRadius, this.hPadding, this.onTap});
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(
            left: hPadding ?? 15, right: hPadding ?? 15, top: 16, bottom: 8),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius:
                  BorderRadius.all(Radius.circular(borderRadius ?? 20)),
              boxShadow: [
                BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.16),
                    offset: Offset(0, 8),
                    blurRadius: 6)
              ]),
          child: GestureDetector(
            onTap: onTap,
            child: ClipRRect(
              borderRadius:
                  BorderRadius.all(Radius.circular(borderRadius ?? 20)),
              child: child,
            ),
          ),
        ));
  }
}

class CampaignTile extends StatefulWidget {
  final Campaign campaign;

  CampaignTile(this.campaign);

  @override
  _CampaignTileState createState() => _CampaignTileState();
}

class _CampaignTileState extends State<CampaignTile> {
  @override
  void initState() {
    print("Initialising state");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //_user = widget.model.user;

    GestureTapCallback _onTapMoreInfo = () {
      Navigator.push(
          context,
          CustomRoute(
              builder: (context) => CampaignInfo(campaign: widget.campaign)));
    };

    var borderRadius = 20.0;
    var hPadding = 15.0;
    return Tile(
      onTap: _onTapMoreInfo,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Image
          Stack(children: <Widget>[
            Container(
              height: 120,
              child: Padding(
                padding: EdgeInsets.all(0),
                child: Container(
                    decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(widget.campaign.getHeaderImage()),
                    fit: BoxFit.cover,
                  ),
                  //borderRadius: BorderRadius.only(topLeft: Radius.circular(10))
                )),
              ),
            ),
            StoreConnector<AppState, ViewModel>(
                converter: (Store<AppState> store) => ViewModel.create(store),
                builder: (BuildContext context, ViewModel viewModel) {
                  bool selected = viewModel.userModel.user
                      .getSelectedCampaigns()
                      .contains(widget.campaign.getId());
                  if (selected) {
                    return Padding(
                        padding: EdgeInsets.all(12),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: JoinedIndicator(),
                        ));
                  } else {
                    return Container();
                  }
                })
          ]),
          SizedBox(height: 10),
          // Title
          Padding(
            padding: EdgeInsets.symmetric(horizontal: hPadding),
            child: Text(
              widget.campaign.getTitle(),
              textAlign: TextAlign.left,
              style: textStyleFrom(
                Theme.of(context).primaryTextTheme.headline3,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                top: 5, bottom: 10, left: hPadding, right: hPadding),
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
                    RichText(
                        text: TextSpan(children: [
                      TextSpan(
                        text:
                            widget.campaign.getNumberOfCampaigners().toString(),
                        style: textStyleFrom(
                          Theme.of(context).primaryTextTheme.headline5,
                          fontWeight: FontWeight.w600,
                          color: Color.fromRGBO(63, 61, 86, 1),
                        ),
                      ),
                      TextSpan(
                        text: " campaigners",
                        style: textStyleFrom(
                          Theme.of(context).primaryTextTheme.headline5,
                          fontWeight: FontWeight.w400,
                          color: Color.fromRGBO(63, 61, 86, 1),
                        ),
                      ),
                    ]))
                  ],
                ),
                TextButton(
                  "See more",
                  onClick: null,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

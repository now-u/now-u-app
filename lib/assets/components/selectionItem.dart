import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:app/models/Action.dart';
import 'package:app/models/Campaign.dart';
import 'package:app/models/ViewModel.dart';

import 'package:app/pages/other/ActionInfo.dart';
import 'package:app/assets/routes/customRoute.dart';

class SelectionItem extends StatelessWidget {
  final String t;
  final GestureTapCallback onClick;
  SelectionItem(this.t, {this.onClick});
  @override
  Widget build(BuildContext context) {
    return 
    GestureDetector(
     onTap: this.onClick,
     child: 
      Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(5),
            child: Text(t, style: Theme.of(context).primaryTextTheme.body1,),
          ),
          Transform.rotate(
            angle: 180 * math.pi / 180,
            child: Icon(Icons.chevron_left, size: 25), 
          ),
        ],
      ),   
    );
  }
}

class ActionSelectionItem extends StatelessWidget {
  final CampaignAction action;
  final Campaign campaign;
  final ViewModel model;

  ActionSelectionItem({
    this.action, 
    this.campaign,
    this.model,
  });

  @override
  Widget build(BuildContext context) {
    return 
    GestureDetector(
      onTap: () {
        Navigator.push(
          context, 
          CustomRoute(builder: (context) => ActionInfo(action, campaign, model))
        );
      },   
      child:
        Padding(
          padding: EdgeInsets.all(5),
          child: SelectionItem(
             action.getTitle(),
             onClick: () {
               Navigator.push(
                 context, 
                 CustomRoute(builder: (context) => ActionInfo(action, campaign, model))
               );
             },   
          )
        )
    );

  }
}

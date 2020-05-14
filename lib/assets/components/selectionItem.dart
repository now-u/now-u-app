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
  final IconData icon;
  final Color arrowColor;
  
  SelectionItem(
    this.t, 
    {
      this.onClick,
      this.icon,
      this.arrowColor,
    });
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
          Row(
            children: <Widget>[
              icon == null ? Container() :
              Icon(icon),
              Padding(
                padding: EdgeInsets.all(5),
                child: Text(t, style: Theme.of(context).primaryTextTheme.bodyText1,),
              ),
            ],
          ),
          Transform.rotate(
            angle: 180 * math.pi / 180,
            child: Icon(
              Icons.chevron_left, size: 25,
              color: arrowColor == null ? Theme.of(context).primaryColor : arrowColor,
            ), 
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
  final Function extraOnTap;

  ActionSelectionItem({
    this.action, 
    this.campaign,
    this.model,
    this.extraOnTap,
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
          child: Row(
            children: <Widget>[
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  color: action.getActionIconMap()['iconBackgroundColor']
                ), 
                child: 
                  Center(
                    child: Icon(
                      action.getActionIconMap()['icon'],
                      color: action.getActionIconMap()['iconColor'],
                      size: 30,
                    ),
                  ),
              ),
              SizedBox(width: 10),
              Expanded( child: SelectionItem(
                 action.getTitle(),
                 onClick: () {
                   if (extraOnTap != null) {
                    extraOnTap();
                   }
                   Navigator.push(
                     context, 
                     CustomRoute(builder: (context) => ActionInfo(action, campaign, model))
                   );
                 },   
                )
              )
              ],
            )
        )
    );

  }
}

import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:app/models/Action.dart';
import 'package:app/models/Campaign.dart';

import 'package:app/pages/other/ActionInfo.dart';

import 'package:app/assets/routes/customRoute.dart';
import 'package:app/assets/StyleFrom.dart';

class SelectionItem extends StatelessWidget {
  final String t;
  final GestureTapCallback onClick;
  final IconData icon;
  final Color arrowColor;
  final EdgeInsetsGeometry padding;

  SelectionItem(
    this.t, {
    this.onClick,
    this.icon,
    this.arrowColor,
    this.padding,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: this.onClick,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              icon == null ? Container() : Icon(icon),
              Padding(
                padding: this.padding ?? EdgeInsets.all(15),
                child: Text(
                  t,
                  style: Theme.of(context).primaryTextTheme.bodyText1,
                ),
              ),
            ],
          ),
          Transform.rotate(
            angle: 180 * math.pi / 180,
            child: Icon(
              Icons.chevron_left,
              size: 25,
              color: arrowColor ?? Theme.of(context).primaryColor,
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
  final Function extraOnTap;

  ActionSelectionItem({
    this.action,
    this.campaign,
    this.extraOnTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.push(context,
              CustomRoute(builder: (context) => ActionInfo(action, campaign)));
        },
        child: Padding(
            padding: EdgeInsets.all(5),
            child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    color: colorFrom(Theme.of(context).primaryColor,
                        opacity: 0.05)),
                child: Padding(
                    padding: EdgeInsets.all(5),
                    child: Row(
                      children: <Widget>[
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                              color: action
                                  .getActionIconMap()['iconBackgroundColor']),
                          child: Center(
                            child: Icon(
                              action.getActionIconMap()['icon'],
                              color: action.getActionIconMap()['iconColor'],
                              size: 30,
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                            child: SelectionItem(
                          action.getTitle(),
                          onClick: () {
                            if (extraOnTap != null) {
                              extraOnTap();
                            }
                            Navigator.push(
                                context,
                                CustomRoute(
                                    builder: (context) =>
                                        ActionInfo(action, campaign)));
                          },
                        ))
                      ],
                    )))));
  }
}

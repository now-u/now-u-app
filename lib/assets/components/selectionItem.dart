import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:app/models/Action.dart';
import 'package:app/models/Campaign.dart';

import 'package:app/pages/action/ActionInfo.dart';

import 'package:app/assets/routes/customRoute.dart';
import 'package:app/assets/StyleFrom.dart';

class SelectionItem extends StatelessWidget {
  final String text;
  final GestureTapCallback onClick;
  final IconData icon;
  final Color arrowColor;
  final EdgeInsetsGeometry padding;
  final Widget child;

  SelectionItem({
    this.text,
    this.onClick,
    this.icon,
    this.arrowColor,
    this.padding,
    this.child,
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
              // If given child will do that
              child != null ? 
              Container(
                child: child,
              )
              :
              // Else will do text
              Padding(
                padding: this.padding ?? EdgeInsets.all(15),
                child: Text(
                  text,
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
              color: arrowColor == null
                  ? Theme.of(context).primaryColor
                  : arrowColor,
            ),
          ),
        ],
      ),
    );
  }
}

class ActionSelectionItem extends StatelessWidget {
  @required final CampaignAction action;
  @required final Campaign campaign;
  final Function extraOnTap;
  final bool isNew;

  ActionSelectionItem({
    this.action,
    this.campaign,
    this.extraOnTap,
    this.isNew,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.push(context,
              CustomRoute(builder: (context) => ActionInfo(action, campaign)));
        },
        child: Padding(
            padding: EdgeInsets.symmetric(vertical: 5),
            child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    color: colorFrom(Theme.of(context).primaryColor,
                        opacity: 0.05)
                    ),
                child: 
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    children: <Widget>[
                      Stack (
                        children: <Widget> [
                          Padding(
                           padding: EdgeInsets.all(5),
                           child: Container(
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
                          ), 
                          !(isNew ?? false) ? Container() :
                          Positioned(
                            right: 0,
                            child: Container(
                              padding: EdgeInsets.all(1),
                              decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              constraints: BoxConstraints(
                                minWidth: 12,
                                minHeight: 12,
                              ),
                            ),
                          ),
                        ]
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: SelectionItem(
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
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                height: 40,
                                width: MediaQuery.of(context).size.width * 0.8 - 50,
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    action.getTitle(),
                                    style: Theme.of(context).primaryTextTheme.bodyText1,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Icon(
                                        Icons.access_time,
                                        size: 15,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                      SizedBox(
                                        width: 2,
                                      ),
                                      Text(
                                        action.getTimeText(),
                                        style: textStyleFrom(
                                          Theme.of(context).primaryTextTheme.bodyText1,
                                          fontWeight: FontWeight.w600,
                                          color: Theme.of(context).primaryColor,
                                          fontSize: 11,
                                        )
                                      ),
                                    ],
                                  ),
                                ]
                              )
                          ),
                      )
                    ]
                  ),
                )
            )
        ),
      );
  }
}

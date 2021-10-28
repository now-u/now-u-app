import 'package:app/models/Action.dart';
import 'package:app/models/Campaign.dart';
import 'package:app/models/Cause.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ExploreActionTile extends StatelessWidget {
  final String title;
  final ActionType type;
  final Color color;
  final IconData icon;
  final ListCause? cause;
  final String timeText;

  ExploreActionTile(ListCauseAction model, {Key? key})
      : title = model.title,
        type = model.superType,
        color = model.primaryColor,
        icon = model.icon,
        cause = model.cause,
        timeText = model.timeText,
        super(key: key);

  // TODO fonts and colors
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      clipBehavior: Clip.antiAlias,
      child: AspectRatio(
        aspectRatio: 1.65,
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                width: double.infinity,
                color: color,
                child: Row(
                  children: [
                    SizedBox(width: 12),
                    Icon(
                      icon,
                      size: 18, // TODO icon color
                    ),
                    SizedBox(width: 8),
                    Text(type.name),
                    SizedBox(width: 16),
                    VerticalDivider(
                      color: Colors.black, // TODO divider color
                      indent: 12,
                      endIndent: 12,
                    ),
                    SizedBox(width: 16),
                    FaIcon(
                      // Use FaIcon to center icons properly
                      FontAwesomeIcons.clock,
                      size: 18, // TODO icon color
                    ),
                    SizedBox(width: 8),
                    Text(timeText)
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: Text(
                  // title,
                  "Tell Zara to stop profiting from Uighur forced labour",
                  style: Theme.of(context).primaryTextTheme.headline2!.apply(
                        fontSizeDelta: -9,
                      ),
                ),
              ),
              flex: 2,
            ),
            Expanded(
              child: Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  children: [
                    // TODO get icon from cause
                    Icon(Icons.error),
                    SizedBox(width: 8),
                    Text(cause!.title!)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ExploreCampaignTile extends StatelessWidget {
  const ExploreCampaignTile(ListCampaign model, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

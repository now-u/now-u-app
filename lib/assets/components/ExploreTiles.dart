import 'package:app/models/Action.dart';
import 'package:app/models/Campaign.dart';
import 'package:app/models/Cause.dart';
import 'package:flutter/material.dart';

class ExploreActionTile extends StatelessWidget {
  final String title;
  final CampaignActionType type;
  final Color color;
  final IconData icon;
  final ListCause? cause;
  final String timeText;

  ExploreActionTile(ListCauseAction model, {Key? key})
      : title = model.title,
        type = model.type,
        color = model.primaryColor,
        icon = model.icon,
        cause = model.cause,
        timeText = model.timeText,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      clipBehavior: Clip.antiAlias,
      child: AspectRatio(
        aspectRatio: 1.65,
        child: Column(
          children: [
            Flexible(
              child: Container(
                color: color,
              ),
            ),
            Flexible(
              child: Container(),
              flex: 3,
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

import 'package:app/assets/components/custom_network_image.dart';
import 'package:app/models/Action.dart';
import 'package:app/models/Campaign.dart';
import 'package:app/models/Cause.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ExploreCampaignTile extends StatelessWidget {
  final String headerImage;
  final String title;
  final ListCause? cause;

  ExploreCampaignTile(ListCampaign model, {Key? key})
      : headerImage = model.headerImage,
        title = model.title,
        cause = model.cause,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      clipBehavior: Clip.antiAlias,
      child: AspectRatio(
        aspectRatio: 0.75,
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 1.5,
              child: CustomNetworkImage(
                headerImage,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: _ExploreTileTitle(title),
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: _ExploreTileCause(cause!)),
          ],
        ),
      ),
    );
  }
}

class ExploreActionTile extends StatelessWidget {
  final String title;
  final ActionType type;
  final Color iconColor;
  final Color headerColor;
  final Color dividerColor;
  final IconData icon;
  final ListCause? cause;
  final String timeText;

  ExploreActionTile(ListCauseAction model, {Key? key})
      : title = model.title,
        type = model.superType,
        iconColor = model.primaryColor,
        headerColor = model.secondaryColor,
        dividerColor = model.tertiaryColor,
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
                padding: const EdgeInsets.symmetric(horizontal: 12),
                color: headerColor,
                child: Row(
                  children: [
                    Icon(
                      icon,
                      size: 18,
                      color: iconColor,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      type.name,
                      textScaleFactor: .8,
                    ),
                    VerticalDivider(
                      color: dividerColor,
                      indent: 12,
                      endIndent: 12,
                    ),
                    const FaIcon(
                      // Use FaIcon to center icons properly
                      FontAwesomeIcons.clock,
                      size: 16,
                      color: Color.fromRGBO(55, 58, 74, 1),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      timeText,
                      textScaleFactor: .8,
                    )
                  ],
                ),
              ),
            ),
            Flexible(
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: _ExploreTileTitle(title),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: _ExploreTileCause(cause!),
                  )
                ],
              ),
              flex: 3,
            ),
          ],
        ),
      ),
    );
  }
}

class _ExploreTileTitle extends StatelessWidget {
  final String title;

  const _ExploreTileTitle(this.title, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).primaryTextTheme.headline2!,
      textScaleFactor: .6,
    );
  }
}

class _ExploreTileCause extends StatelessWidget {
  final ListCause cause;

  const _ExploreTileCause(this.cause, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          Icon(
            cause.icon,
            size: 18,
          ),
          const SizedBox(width: 6),
          Text(
            cause.title,
            textScaleFactor: .9,
          )
        ],
      ),
    );
  }
}

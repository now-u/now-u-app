import 'package:flutter/material.dart';

import 'package:nowu/assets/components/customTile.dart';

const double ICON_PADDING = 22;
const double ITEM_HORIZONTAL = 10;
const double ITEM_VERTICAL = 15;

/// A single Tile/row in the [Profile] class aka "More Menu"
///
/// This is how it looks ![image of Profile Tile](https://i.ibb.co/kBm5X5r/Inkedslack-LI.jpg)
class ProfileTile extends StatelessWidget {
  final IconData iconData;
  final String text;

  ProfileTile(this.text, this.iconData);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 12),
        child: CustomTile(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              ITEM_HORIZONTAL,
              ITEM_VERTICAL,
              ITEM_HORIZONTAL,
              ITEM_VERTICAL,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: ICON_PADDING),
                  child: Icon(
                    iconData,
                    size: 30,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                Text(text, style: Theme.of(context).textTheme.displayMedium),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

const double ICON_SIZE = 65;
const double TOP_PADDING = 30;
const double BOTTOM_PADDING = 20;

class PageTitle extends StatelessWidget {
  final String title;
  bool hasBackButton;
  final GestureTapCallback onClickBackButton;

  PageTitle(this.title, {hasBackButton, this.onClickBackButton}) {
    this.hasBackButton = hasBackButton ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Padding(
            padding: EdgeInsets.only(
              top: TOP_PADDING,
            ),
            child: GestureDetector(
              onTap: onClickBackButton != null
                  ? onClickBackButton
                  : () {
                      Navigator.pop(context);
                    },
              child: Icon(
                Icons.chevron_left,
                size: hasBackButton ? ICON_SIZE : 0,
              ),
            )),
        SafeArea(
          child: Padding(
            padding: EdgeInsets.fromLTRB(0, TOP_PADDING, 0, BOTTOM_PADDING),
            child: Text(title, style: Theme.of(context).primaryTextTheme.title),
          ),
        ),
        Container(
          width: hasBackButton ? ICON_SIZE : 0,
          height: 0,
        )
      ],
    );
  }
}

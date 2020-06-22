import 'package:flutter/material.dart';

import 'package:app/assets/components/textButton.dart';

AppBar CustomAppBar({
  @required text,
  @required context,
  String backButtonText,
  bool hasBackButton,
  List<Widget> actions,
  Function extraOnTap,
}) {
  hasBackButton = hasBackButton == null ? true : hasBackButton;
  return AppBar(
    //leading: SizedBox(width: 0),
    backgroundColor: Colors.white,
    automaticallyImplyLeading: false,
    centerTitle: true,
    title: Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: Align(
            alignment: Alignment.centerRight,
            child: !hasBackButton
                ? Container()
                : Container(
                    child: TextButton(
                      backButtonText ?? "Back",
                      iconLeft: true,
                      onClick: () {
                        if (extraOnTap != null) {
                          extraOnTap();
                        }
                        Navigator.pop(context);
                      },
                    ),
                  ),
          ),
        ),
        Text(
          text,
          style: TextStyle(
            color: Theme.of(context).primaryTextTheme.headline4.color,
            fontSize: Theme.of(context).primaryTextTheme.headline4.fontSize,
            fontWeight: FontWeight.w500,
            fontStyle: Theme.of(context).primaryTextTheme.headline4.fontStyle,
            fontFamily: Theme.of(context).primaryTextTheme.headline4.fontFamily,
          ),
        ),
        Expanded(
          child: Container(
              //flex: 1,
              child: actions == null || actions.length == 0
                  ? Container()
                  : Align(
                      alignment: Alignment.centerRight,
                      child: actions.length == 1
                          ? actions[0]
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: actions,
                            ),
                    )),
        ),
      ],
    ),
    //actions: actions,
  );
}

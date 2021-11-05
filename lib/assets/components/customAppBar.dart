import 'package:app/assets/StyleFrom.dart';
import 'package:flutter/material.dart';

import 'package:app/assets/components/textButton.dart';

AppBar customAppBar({
  text,
  required context,
  String? backButtonText,
  bool? hasBackButton,
  List<Widget>? actions,
  Function? extraOnTap,
}) {
  hasBackButton = hasBackButton == null ? true : hasBackButton;
  return AppBar(
    //leading: SizedBox(width: 0),
    backgroundColor: Colors.white,
    automaticallyImplyLeading: false,
    centerTitle: true,
    elevation: 0,
    bottom: text == null
        ? null
        : PreferredSize(
            preferredSize: Size(0, 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: 15),
                Padding(
                  padding: EdgeInsets.only(bottom: 5),
                  child: Text(
                    text,
                    style: textStyleFrom(
                      Theme.of(context).primaryTextTheme.headline2,
                    ),
                  ),
                ),
              ],
            ),
          ),
    title: Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: Align(
            alignment: Alignment.centerRight,
            child: !hasBackButton
                ? Container()
                : Container(
                    child: CustomTextButton(
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
      ],
    ),
    actions: actions,
  );
}

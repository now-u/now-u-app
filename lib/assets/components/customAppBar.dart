import 'package:flutter/material.dart';

import 'package:app/assets/components/textButton.dart';

AppBar CustomAppBar(
    {
      @required text,
      @required context,
      String backButtonText,
      bool hasBackButton,
      List<Widget> actions,
      Function extraOnTap,
    }
    ) {
  hasBackButton = hasBackButton == null ? true : hasBackButton;
  return AppBar(
   backgroundColor: Colors.white,
   automaticallyImplyLeading: false,
   centerTitle: true,
   title: 
    Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Flexible(
          flex: 1,
          child: 
          !hasBackButton ? Container() :
          TextButton(
            backButtonText ?? "Back",
            iconLeft: true,
            onClick: (){
              if (extraOnTap != null) {
                extraOnTap();
              }
              Navigator.pop(context);
            },
          ),
        ),
        Container(
          child: Text(
            text, 
            style: TextStyle(
              color: Theme.of(context).primaryTextTheme.headline4.color,
              fontSize: Theme.of(context).primaryTextTheme.headline4.fontSize,
              fontWeight: FontWeight.w500,
              fontStyle: Theme.of(context).primaryTextTheme.headline4.fontStyle,
              fontFamily: Theme.of(context).primaryTextTheme.headline4.fontFamily,
            ),
          )
        ),
        Flexible(
          flex: 1,
          child: Container(),
        )
      ],
    ),
    actions: actions,
  );
}

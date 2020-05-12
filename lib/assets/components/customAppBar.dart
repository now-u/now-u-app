import 'package:flutter/material.dart';

import 'package:app/assets/components/textButton.dart';

AppBar CustomAppBar(
    {
      @required text,
      @required context,
      String backButtonText  
    }
    ) {

  return AppBar(
   backgroundColor: Colors.white,
   automaticallyImplyLeading: false,
   title: 
    Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Flexible(
          flex: 1,
          child: TextButton(
            backButtonText ?? "Back",
            icon: Icons.arrow_left,
            onClick: (){
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
  );
}

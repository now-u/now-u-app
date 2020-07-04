import 'package:flutter/material.dart';
import 'package:app/assets/components/textButton.dart';
import 'package:app/pages/other/InfoPage.dart';
import 'package:app/routes.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PageHeader extends StatelessWidget {
  final Function onTap;
  final String title;
  final IconData icon;
  final bool backButton;
  final double padding;

  // For question mark button
  final String infoTitle;
  final String infoText;

  PageHeader(
      {this.onTap, this.title, this.icon, this.backButton, this.padding, this.infoText, this.infoTitle});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SafeArea(
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: backButton ?? false
                ? MainAxisAlignment.spaceBetween
                : MainAxisAlignment.end,
            children: [
              backButton ?? false
                  ? Container(
                    height: 40,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: padding ?? 10.0, vertical: 10.0),
                      child: TextButton(
                        "Back",
                        onClick: () {
                          Navigator.of(context).pop();
                        },
                        iconLeft: true,
                        fontWeight: FontWeight.w400,
                      ))
                    )
                  : Container(height: 40,),
              icon == null
                  ? Container()
                  : Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: onTap,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: padding ?? 10.0, vertical: 10.0),
                          child: Icon(
                            icon,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                    )
            ],
          ),
        ),
        Container(
          height: 60,
          child: Padding(
            padding: EdgeInsets.only(left: padding == null ? 20 : padding + 10),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  child: Text(
                    title,
                    textAlign: TextAlign.left,
                    style: Theme.of(context).primaryTextTheme.headline2,
                  ),
                ),
                
                SizedBox(width: 7,),

                infoTitle != null && infoText != null 
                  ? GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed(
                          Routes.info,
                          arguments: InfoPageArgumnets(
                            title: infoTitle, 
                            body: infoText,
                          ),
                        );
                      },
                      child: Icon(
                        FontAwesomeIcons.questionCircle,
                        color: Theme.of(context).primaryColor,
                      ),
                    )
                  : Container(),

              ]
            ),
          ),
        ),
      ],
    );
  }
}

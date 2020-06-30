import 'package:app/assets/StyleFrom.dart';
import 'package:app/assets/components/darkButton.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void customLaunch(
  BuildContext context,
  String url,
  {
    String title,
    String description,
    String buttonText, 
    String closeButtonText,
  }
) {
  showDialog(
      context: context,
      barrierDismissible: true,
      builder: (_) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(35),
            ),
            content: Padding(
              padding: EdgeInsets.all(25),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  SizedBox(height: 20),
                  Text(
                    title ?? "You're about to leave the app",
                    style: textStyleFrom(
                      Theme.of(context).primaryTextTheme.headline2,
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: Text(
                      description ?? "This link will take you out off the app. Are you sure you want to go?",
                      style: textStyleFrom(
                        Theme.of(context).primaryTextTheme.bodyText1,
                        color: Theme.of(context).primaryColorDark,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 40),
                  Container(
                    width: double.infinity,
                    child:
                      DarkButton(
                        buttonText ?? "Yes lets go",
                        onPressed: () {
                          launch(url);
                        }
                      ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    width: double.infinity,
                    child:
                      DarkButton(
                        closeButtonText ?? "Close",
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        inverted: true
                      ),
                  ),
                  SizedBox(height: 20),
                ],
              )
            ),
          ));
}

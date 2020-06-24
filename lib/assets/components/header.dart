import 'package:flutter/material.dart';
import 'package:app/assets/components/textButton.dart';

class PageHeader extends StatelessWidget {
  final Function onTap;
  final String title;
  final IconData icon;
  final bool backButton;
  final double padding;
  PageHeader(
      {this.onTap, this.title, this.icon, this.backButton, this.padding});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SafeArea(
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: backButton ?? false
                ? MainAxisAlignment.spaceBetween
                : MainAxisAlignment.end,
            children: [
              backButton ?? false
                  ? Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: padding ?? 10.0, vertical: 10.0),
                      child: TextButton(
                        "Back",
                        onClick: () {
                          Navigator.of(context).pop();
                        },
                        iconLeft: true,
                      ))
                  : Container(),
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
        Padding(
          padding: EdgeInsets.only(left: padding == null ? 20 : padding + 10),
          child: Container(
            width: double.infinity,
            child: Text(
              title,
              textAlign: TextAlign.left,
              style: Theme.of(context).primaryTextTheme.headline2,
            ),
          ),
        ),
      ],
    );
  }
}

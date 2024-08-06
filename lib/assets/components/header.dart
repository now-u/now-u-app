import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

// TODO Loads of stuff here isn't used, remove all the things
class PageHeader extends StatelessWidget {
  final Function? onTap;
  final String? title;
  final IconData? icon;
  final bool? backButton;
  final String? backButtonText;
  final double? padding;
  final int? maxLines;

  // For Colour
  final Color? textColor;

  // For question mark button
  final String? infoTitle;
  final String? infoText;
  final double? fontSize;
  final double? extraInnerPadding;

  PageHeader({
    this.onTap,
    this.title,
    this.icon,
    this.backButton,
    this.backButtonText,
    this.padding,
    this.infoText,
    this.infoTitle,
    this.textColor,
    this.maxLines,
    this.fontSize,
    this.extraInnerPadding,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PageHeaderBackButton(
          onTap: onTap,
          backButton: backButton,
          backButtonText: backButtonText,
          icon: icon,
          padding: padding,
        ),
        SizedBox(height: extraInnerPadding ?? 0),
        Container(
          child: Padding(
            padding:
                EdgeInsets.only(left: padding == null ? 20 : padding! + 10),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                infoText == null && infoTitle == null && maxLines != null
                    ? Expanded(
                        child: Text(
                          title!,
                          textAlign: TextAlign.left,
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(
                                color: textColor,
                                fontSize: fontSize,
                              ),
                          maxLines: maxLines,
                          overflow: TextOverflow.ellipsis,
                        ),
                      )
                    : Container(
                        child: Text(
                          title!,
                          textAlign: TextAlign.left,
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(
                                color: textColor,
                                fontSize: fontSize,
                              ),
                        ),
                      ),
                const SizedBox(
                  width: 7,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class PageHeaderBackButton extends StatelessWidget {
  final Function? onTap;
  final IconData? icon;
  final bool? backButton;
  final String? backButtonText;
  final double? padding;

  PageHeaderBackButton({
    this.backButton,
    this.backButtonText,
    this.padding,
    this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
                      horizontal: padding ?? 10.0,
                      vertical: 10.0,
                    ),
                    child: TextButton.icon(
                      icon: Icon(
                        Icons.chevron_left,
                        size: 25,
                        color: Theme.of(context).primaryColor,
                      ),
                      label: Text(
                        backButtonText ?? 'Back',
                        style: const TextStyle(
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      onPressed: () {
                        context.router.maybePop();
                      },
                    ),
                  ),
                )
              : Container(
                  height: 40,
                ),
          icon == null
              ? Container()
              : Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: onTap as void Function()?,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: padding ?? 10.0,
                        vertical: 10.0,
                      ),
                      child: Icon(
                        icon,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}

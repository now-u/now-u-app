import 'package:flutter/material.dart';
import 'package:nowu/assets/components/textButton.dart';

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
            preferredSize: const Size(0, 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(width: 15),
                Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Text(
                    text,
                    style: Theme.of(context).textTheme.headlineMedium,
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
                      backButtonText ?? 'Back',
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

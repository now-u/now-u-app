import 'package:flutter/material.dart';
import 'package:nowu/assets/components/textButton.dart';

AppBar customAppBar({
  required String text,
  required BuildContext context,
  String? backButtonText,
}) {
  return AppBar(
    //leading: SizedBox(width: 0),
    backgroundColor: Colors.white,
    automaticallyImplyLeading: false,
    centerTitle: true,
    elevation: 0,
    bottom: PreferredSize(
      preferredSize: const Size(0, 30),
      child: Padding(
        padding: const EdgeInsets.only(left: 15, bottom: 5),
        child: Text(
          text,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
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
            child: Container(
              child: CustomTextButton(
                backButtonText ?? 'Back',
                iconLeft: true,
                onClick: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

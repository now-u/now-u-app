import 'package:flutter/material.dart';
import 'package:open_mail_app/open_mail_app.dart';
import 'package:auto_route/auto_route.dart';

class EmailAppPickerDialog extends StatelessWidget {
  final List<MailApp> mailApps;
  const EmailAppPickerDialog({ required this.mailApps, Key? key }) : super(key: key);

  @override
  Widget build( BuildContext context) {
    return SimpleDialog(
      title: const Text('Open an email app'),
      children: <Widget>[
        for (var app in mailApps)
          SimpleDialogOption(
            child: Text(app.name),
            onPressed: () {
              OpenMailApp.openSpecificMailApp(app);
              context.router.maybePop();
            },
          ),
      ],
    );
  }
}

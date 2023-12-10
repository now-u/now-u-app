import 'package:flutter/material.dart';
import 'package:open_mail_app/open_mail_app.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import 'email_app_picker_dialog_model.dart';

class EmailAppPickerDialog extends StackedView<EmailAppPickerDialogModel> {
  final DialogRequest request;
  final Function(DialogResponse) completer;

  const EmailAppPickerDialog({
    Key? key,
    required this.request,
    required this.completer,
  }) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    EmailAppPickerDialogModel viewModel,
    Widget? child,
  ) {
    // TODO Find alternative to having to cast
    final mailApps = request.data! as List<MailApp>;
    return SimpleDialog(
      title: const Text('Open an email app'),
      children: <Widget>[
        for (var app in mailApps)
          SimpleDialogOption(
            child: Text(app.name),
            onPressed: () {
              OpenMailApp.openSpecificMailApp(app);
              completer(DialogResponse(confirmed: true));
            },
          ),
      ],
    );
  }

  @override
  EmailAppPickerDialogModel viewModelBuilder(BuildContext context) =>
      EmailAppPickerDialogModel();
}

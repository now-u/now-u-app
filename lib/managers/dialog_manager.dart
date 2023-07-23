import 'package:nowu/assets/components/buttons/customWidthButton.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:nowu/locator.dart';
import 'package:nowu/services/dialog_service.dart';
import 'package:nowu/models/Cause.dart';

import 'package:nowu/assets/components/buttons/darkButton.dart';
import 'package:nowu/assets/StyleFrom.dart';
import 'package:open_mail_app/open_mail_app.dart';

abstract class CustomDialog {
  final DialogService _dialogService = locator<DialogService>();

  void show(BuildContext context);

  void complete(dynamic result, BuildContext context) {
    _dialogService.dialogComplete(AlertResponse(response: result));
    Navigator.of(context).pop();
  }
}

class CauseDialog extends CustomDialog {
  Cause cause;

  CauseDialog(this.cause);

  void show(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (_) => AlertDialog(
          contentPadding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          clipBehavior: Clip.hardEdge,
          content: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Stack(children: [
                  CachedNetworkImage(imageUrl: cause.headerImage.url),
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                          icon: Icon(Icons.close),
                          onPressed: () {
                            complete(false, context);
                          },
                          color: Theme.of(context).primaryColor,
                        )),
                  )
                ]),
                Padding(
                  padding: EdgeInsets.all(25),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text(
                        cause.title,
                        textAlign: TextAlign.center,
                        style: textStyleFrom(
                          Theme.of(context).primaryTextTheme.headline2,
                        ),
                      ),
                      SizedBox(height: 15),
                      Text(
                        cause.description,
                        style: textStyleFrom(
                          Theme.of(context).primaryTextTheme.bodyText1,
                          color: Theme.of(context).primaryColorDark,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 20),
                      Container(
                        width: double.infinity,
                        child: DarkButton(
                          'Select Cause',
                          onPressed: () {
                            complete(true, context);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ])),
    );
  }
}

class EmailAppPickerDialog extends CustomDialog {
  final List<MailApp> options;

  EmailAppPickerDialog(this.options);

  void show(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) {
        return SimpleDialog(
          title: Text("Open an email app"),
          children: <Widget>[
            for (var app in options)
              SimpleDialogOption(
                child: Text(app.name),
                onPressed: () {
                  OpenMailApp.openSpecificMailApp(app);
                  complete(false, context);
                },
              ),
          ],
        );
      },
    );
  }
}

class BasicDialog extends CustomDialog {
  final String title;
  final String description;
  final List<DialogButton>? buttons;
  final String? headerImage;

  BasicDialog(
      {required this.title,
      required this.description,
      this.headerImage,
      this.buttons});

  void show(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (_) => AlertDialog(
          contentPadding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          clipBehavior: Clip.hardEdge,
          content: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                if (headerImage != null)
                  CachedNetworkImage(imageUrl: headerImage!),
                SizedBox(height: 15),
                Padding(
                  padding: EdgeInsets.all(25),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text(
                        title,
                        textAlign: TextAlign.center,
                        style: textStyleFrom(
                          Theme.of(context).primaryTextTheme.headline2,
                        ),
                      ),
                      SizedBox(height: 20),
                      Padding(
                        padding: EdgeInsets.all(5),
                        child: Text(
                          description,
                          style: textStyleFrom(
                            Theme.of(context).primaryTextTheme.bodyText1,
                            color: Theme.of(context).primaryColorDark,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: 20),
                      Column(
                        children: _getButtons(buttons, context),
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ])),
    );
  }

  List<Widget> _getButtons(List<DialogButton>? buttons, BuildContext context) {
    if (buttons == null) {
      return <Widget>[
        Container(
          width: double.infinity,
          child: DarkButton(
            'Ok',
            onPressed: () {
              complete(true, context);
            },
          ),
        )
      ];
    }

    List<Widget> buttonWidgets = [];
    for (final DialogButton button in buttons) {
      buttonWidgets.add(Container(
        child: CustomWidthButton(button.text, onPressed: () {
          complete(button.response, context);
        }, buttonWidthProportion: 0.7, size: ButtonSize.Medium),
      ));
      buttonWidgets.add(SizedBox(height: 10));
    }
    return buttonWidgets;
  }
}

class DialogManager extends StatefulWidget {
  final Widget child;
  DialogManager({Key? key, required this.child}) : super(key: key);

  @override
  _DialogManagerState createState() => _DialogManagerState();
}

class _DialogManagerState extends State<DialogManager> {
  final DialogService _dialogService = locator<DialogService>();

  @override
  void initState() {
    super.initState();
    _dialogService.registerDialogListener(_showDialog);
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  void _showDialog(CustomDialog dialog) {
    dialog.show(context);
  }
}

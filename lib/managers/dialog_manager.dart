import 'package:app/assets/components/buttons/customWidthButton.dart';
import 'package:flutter/material.dart';

import 'package:app/locator.dart';
import 'package:app/services/dialog_service.dart';

import 'package:app/assets/components/buttons/darkButton.dart';
import 'package:app/assets/StyleFrom.dart';


class DialogManager extends StatefulWidget {
  final Widget? child;
  DialogManager({Key? key, this.child}) : super(key: key);

  @override
  _DialogManagerState createState() => _DialogManagerState();
}

abstract class CustomDialog {
  final String title;
  final String? description;
  final List? buttons;

  CustomDialog({
    required this.title,
    this.description,
    this.buttons,
  });

  void show(BuildContext context);
  
  List<Widget> _getButtons(List? buttons, BuildContext context) {
    DialogService _dialogService = locator<DialogService>();

    if (buttons == null) {
      return <Widget>[
        Container(
          width: double.infinity,
          child: DarkButton(
            'Ok',
            onPressed: () {
              _dialogService.dialogComplete(AlertResponse(response: true));
              Navigator.of(context).pop();
            },
          ),
        )
      ];
    }

    List<Widget> buttonWidgets = [];
    for (final DialogButton button in buttons as Iterable<DialogButton>) {
      buttonWidgets.add(Container(
        child: CustomWidthButton(
          button.text,
          onPressed: () {
            _dialogService
                .dialogComplete(AlertResponse(response: button.response));
            if (button.closeOnClick != false) {
              Navigator.of(context).pop();
            }
          },
          buttonWidthProportion: 0.3,
          fontSize: 30,
          size: ButtonSize.Medium
        ),
      ));
      buttonWidgets.add(SizedBox(height: 10));
    }
    return buttonWidgets;
  }
}

class BasicDialog extends CustomDialog {
  String headerImage;
  BasicDialog({
    required String title,
    required String description,
    List? buttons,

    required this.headerImage,
  }) : super(title: title, description: description, buttons: buttons);

  void show(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        content: Padding(
            padding: EdgeInsets.all(25),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                SizedBox(height: 20),
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
                  children: _getButtons(request.buttons, context),
                ),
                SizedBox(height: 20),
              ],
            ),
        ),
      ),
    );
  }
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
    return widget.child!;
  }

  void _showDialog(CustomDialog dialog) {
    dialog.show(context);
  }

}

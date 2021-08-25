import 'package:app/assets/components/buttons/customWidthButton.dart';
import 'package:flutter/material.dart';

import 'package:app/locator.dart';
import 'package:app/services/dialog_service.dart';
import 'package:app/services/navigation_service.dart';

import 'package:app/assets/components/buttons/darkButton.dart';
import 'package:app/assets/StyleFrom.dart';
import 'package:rflutter_alert/rflutter_alert.dart';


class DialogManager extends StatefulWidget {
  final Widget child;
  DialogManager({Key key, this.child}) : super(key: key);

  @override
  _DialogManagerState createState() => _DialogManagerState();
}

class _DialogManagerState extends State<DialogManager> {
  final DialogService _dialogService = locator<DialogService>();
  final NavigationService _navigationService = locator<NavigationService>();

  @override
  void initState() {
    super.initState();
    _dialogService.registerDialogListener(_showDialog);
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  void _showDialog(AlertRequest request) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Image.network(request.headerImage ?? 'https://images.unsplash.com/photo-1498925008800-019c7d59d903?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=968&q=80'),
            SizedBox(height: 20),
            Text(
              request.title,
              textAlign: TextAlign.center,
              style: textStyleFrom(
                Theme.of(context).primaryTextTheme.headline2,
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.all(5),
              child: Text(
                request.description,
                style: textStyleFrom(
                  Theme.of(context).primaryTextTheme.bodyText1,
                  color: Theme.of(context).primaryColorDark,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 20),
            Column(
              children: _getButtons(request.buttons),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  List<Widget> _getButtons(List buttons) {
    if (buttons == null) {
      return <Widget>[
        Container(
          width: double.infinity,
          child: DarkButton(
            'Select Cause',
            onPressed: () {
              _dialogService.dialogComplete(AlertResponse(response: true));
              Navigator.of(context).pop();
            },
          ),
        )
      ];
    }

    List<Widget> buttonWidgets = [];
    for (final CustomDialogButton button in buttons) {
      DarkButtonStyle buttonStyle =
      button.style != null ? button.style : DarkButtonStyle.Primary;
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

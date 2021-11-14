import 'package:app/assets/components/buttons/customWidthButton.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:app/locator.dart';
import 'package:app/services/dialog_service.dart';

import 'package:app/assets/components/buttons/darkButton.dart';
import 'package:app/assets/StyleFrom.dart';


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

  void _showDialog(AlertRequest request) {
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
            if(request.headerImage != null) CachedNetworkImage(imageUrl: request.headerImage!),
            SizedBox(height: 15),
            Padding(
                padding: EdgeInsets.all(25),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(
                      request.title!,
                      textAlign: TextAlign.center,
                      style: textStyleFrom(
                        Theme.of(context).primaryTextTheme.headline2,
                      ),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: EdgeInsets.all(5),
                      child: Text(
                        request.description!,
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
          ]
        )
      ),
    );
  }

  List<Widget> _getButtons(List? buttons) {
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

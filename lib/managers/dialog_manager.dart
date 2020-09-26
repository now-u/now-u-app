import 'package:flutter/material.dart';

import 'package:app/locator.dart';
import 'package:app/services/dialog_service.dart';

import 'package:app/assets/components/darkButton.dart';
import 'package:app/assets/StyleFrom.dart';

class DialogManager extends StatefulWidget {
  
  final Widget child;
  DialogManager({Key key, this.child}) : super(key: key);

  @override
  _DialogManagerState createState() => _DialogManagerState();
}

class _DialogManagerState extends State<DialogManager> {

  DialogService _dialogService = locator<DialogService>();

  @override
  void initState() {
    super.initState();
    _dialogService.registerDialogListener(_showDialog);
  }
  
  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  void _showDialog() {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(35),
        ),
        content: Padding(
            padding: EdgeInsets.all(25),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                SizedBox(height: 20),
                Text(
                  "Hello",
                  textAlign: TextAlign.center,
                  style: textStyleFrom(
                    Theme.of(context).primaryTextTheme.headline2,
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.all(5),
                  child: Text(
                    "Some text",
                    style: textStyleFrom(
                      Theme.of(context).primaryTextTheme.bodyText1,
                      color: Theme.of(context).primaryColorDark,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 40),
                SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  child:
                    DarkButton("Ok", onPressed: () {
                        _dialogService.dialogComplete();
                        Navigator.of(context).pop();
                      }, 
                      inverted: true,
                    ),
                ),
                SizedBox(height: 20),
              ],
            )),
      ),
    );
  }
}


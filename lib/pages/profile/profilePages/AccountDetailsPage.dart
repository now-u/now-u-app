import 'package:app/assets/StyleFrom.dart';
import 'package:app/assets/components/darkButton.dart';
import 'package:app/assets/components/inputs.dart';
import 'package:app/assets/components/textButton.dart';
import 'package:app/models/State.dart';
import 'package:app/models/ViewModel.dart';
import 'package:flutter/material.dart';
import 'package:app/assets/components/customAppBar.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class AccountDetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        text: "Edit account details",
        context: context,
        backButtonText: "Menu",
      ),
      body: StoreConnector<AppState, ViewModel>(
        converter: (Store<AppState> store) => ViewModel.create(store),
        builder: (BuildContext context, ViewModel viewModel) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(18, 0, 18, 0),
            child: ListView(
              children: <Widget>[
                // TODO: Name
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 30, 0, 8),
                  child: Text(
                    "Name",
                    style: textStyleFrom(
                      Theme.of(context).primaryTextTheme.headline5,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                CustomTextFormField(
                  autofocus: false,
                  hintText: 'No answer',
                  style: CustomFormFieldStyle.Light,
                ),
                // TODO: Age
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 28.5, 0, 8),
                  child: Text(
                    "Age",
                    style: textStyleFrom(
                      Theme.of(context).primaryTextTheme.headline5,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                CustomTextFormField(
                  autofocus: false,
                  hintText: 'No answer',
                ),
                // TODO: Location
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 28.5, 0, 8),
                  child: Text(
                    "Location",
                    style: textStyleFrom(
                      Theme.of(context).primaryTextTheme.headline5,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                CustomTextFormField(
                  autofocus: false,
                  hintText: 'No answer',
                ),
                // TODO: Email
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 28.5, 0, 8),
                  child: Text(
                    "Email",
                    style: textStyleFrom(
                      Theme.of(context).primaryTextTheme.headline5,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                // TODO: Make field disabled
                CustomTextFormField(
                  autofocus: false,
                  hintText: 'No answer',
                ),
                // TODO: Receive newsletter toggle
                Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 20, 0, 5),
                      child: Text(
                        "Receive newsletter",
                        style: textStyleFrom(
                          Theme.of(context).primaryTextTheme.headline4,
                        ),
                      ),
                    ),
                    // TODO: Implement Toggle Button
                    // CustomToggleButton(),
                  ],
                ),
                // TODO: Organisation Code
                // TODO: CustomSwitch in inputs.dart
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 8),
                  child: Text(
                    "Organisation code",
                    style: textStyleFrom(
                      Theme.of(context).primaryTextTheme.headline4,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 21),
                  child: Text(
                    "If you work for one of our business partners, you can enter the organisation code below so they can see the actions you’ve taken.",
                    style: textStyleFrom(
                      Theme.of(context).primaryTextTheme.bodyText2,
                    ),
                  ),
                ),
                CustomTextFormField(
                  autofocus: false,
                  hintText: 'Enter organisation code',
                ),
                // TODO: Ok button
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 21, 0, 0),
                  child: DarkButton("Ok"),
                ),
                // TODO: Delete account button
                SizedBox(
                  height: 82,
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: SizedBox(),
                    ),
                    TextButton("Delete my account"),
                    Expanded(
                      child: SizedBox(),
                    ),
                  ],
                ),
                // TODO: Save Changes
              ],
            ),
          );
        },
      ),
    );
  }
}

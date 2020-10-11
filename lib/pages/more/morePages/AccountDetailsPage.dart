import 'package:app/assets/StyleFrom.dart';
import 'package:app/assets/components/darkButton.dart';
import 'package:app/assets/components/inputs.dart';
import 'package:flutter/material.dart';
import 'package:app/assets/components/customAppBar.dart';
import 'package:app/viewmodels/account_details_model.dart';

import 'package:stacked/stacked.dart';

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
      body: ViewModelBuilder<AccountDetailsViewModel>.reactive(
          viewModelBuilder: () => AccountDetailsViewModel(),
          builder: (context, model, child) {
            return Form(
              key: model.formKey,
              child: Padding(
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
                      initialValue: model.currentUser.getName(),
                      style: CustomFormFieldStyle.Light,
                      onChanged: (String name) {
                        model.name = name;
                      }
                    ),
                    // TODO: Age
                    //Padding(
                    //  padding: const EdgeInsets.fromLTRB(0, 28.5, 0, 8),
                    //  child: Text(
                    //    "Age",
                    //    style: textStyleFrom(
                    //      Theme.of(context).primaryTextTheme.headline5,
                    //      fontWeight: FontWeight.w600,
                    //    ),
                    //  ),
                    //),
                    //CustomTextFormField(
                    //  autofocus: false,
                    //  hintText: 'No answer',
                    //  style: CustomFormFieldStyle.Light,
                    //),
                    // TODO: Location
                    //Padding(
                    //  padding: const EdgeInsets.fromLTRB(0, 28.5, 0, 8),
                    //  child: Text(
                    //    "Location",
                    //    style: textStyleFrom(
                    //      Theme.of(context).primaryTextTheme.headline5,
                    //      fontWeight: FontWeight.w600,
                    //    ),
                    //  ),
                    //),
                    //CustomTextFormField(
                    //  autofocus: false,
                    //  hintText: 'No answer',
                    //  style: CustomFormFieldStyle.Light,
                    //),
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
                      style: CustomFormFieldStyle.Light,
                      initialValue: model.currentUser.getEmail(),
                      enabled: false,

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
                      style: CustomFormFieldStyle.Light,
                    ),
                    // TODO: Ok button
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 21, 0, 0),
                      child: DarkButton(
                        "Save", 
                        onPressed: model.save,
                      ),
                    ),
                    // TODO: Delete account button
                    SizedBox(
                      height: 82,
                    ),
                    //TODO add this in 
                    //Row(
                    //  children: <Widget>[
                    //    Expanded(
                    //      child: SizedBox(),
                    //    ),
                    //    CustomTextButton("Delete my account"),
                    //    Expanded(
                    //      child: SizedBox(),
                    //    ),
                    //  ],
                    //),
                    // TODO: Save Changes
                  ],
                ),
              )
            );
        },
      ),
    );
  }
}

import 'package:app/assets/StyleFrom.dart';
import 'package:app/assets/components/buttons/darkButton.dart';
import 'package:app/assets/components/inputs.dart';
import 'package:app/assets/constants.dart';
import 'package:app/viewmodels/profile_setup_view_model.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class ProfileSetup extends StatelessWidget {
  Widget _nameInput(ProfileSetupViewModel model) {
    return CustomTextFormField(
      style: CustomFormFieldStyle.Dark,
      keyboardType: TextInputType.text,
      textCapitalization: TextCapitalization.words,
      autofocus: false,
      validator: (value) {
        if (value.isEmpty) return "Name cannot be empty";
        return null;
      },
      onSaved: (value) {
        print("Saved");
        model.name = value;
      },
      hintText: 'Jane Doe',
    );
  }

  Widget _acceptTandCInput(BuildContext context, ProfileSetupViewModel model) {
    return CustomCheckboxFormField(
      title: RichText(
        text: TextSpan(
            style: textStyleFrom(
              Theme.of(context).primaryTextTheme.bodyText1,
              color: Colors.white,
            ),
            children: [
              TextSpan(text: "I agree to the user "),
              TextSpan(
                text: "Terms & Conditions",
                style: textStyleFrom(
                  Theme.of(context).primaryTextTheme.bodyText1,
                  color: Theme.of(context).buttonColor,
                ),
                recognizer: TapGestureRecognizer()..onTap = model.openTsAndCs,
              ),
            ]),
      ),
      validator: (value) {
        if (!value!) return "You must accept our terms and conditions";
        return null;
      },
    );
  }

  Widget _newsletterSignup(BuildContext context, ProfileSetupViewModel model) {
    return CustomCheckboxFormField(
      title: RichText(
        text: TextSpan(
            style: textStyleFrom(
              Theme.of(context).primaryTextTheme.bodyText1,
              color: Colors.white,
            ),
            children: [
              TextSpan(
                  text: "I am happy to receive the now-u newsletter via email"),
            ]),
      ),
      onSaved: (value) {
        model.signUpForNewsLetter = value ?? false;
      },
    );
  }

  Widget _nextButton(ProfileSetupViewModel model) {
    Future<bool> validateAndSave() async {
      final FormState form = model.formKey.currentState!;
      if (form.validate()) {
        form.save();
        model.saveAndNavigate();
        return true;
      }
      return false;
    }

    return Padding(
        padding: EdgeInsets.symmetric(vertical: 16.0),
        child: DarkButton(
          "Next",
          onPressed: validateAndSave,
        ));
  }

  Widget _setupProfileForm(BuildContext context, ProfileSetupViewModel model) {
    return Form(
        key: model.formKey,
        child: Padding(
            padding: EdgeInsets.only(left: 24, right: 24),
            child: SafeArea(
              child: Column(
                //shrinkWrap: true,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 30, bottom: 10),
                        child: Text(
                          "Account Details",
                          style: textStyleFrom(
                            Theme.of(context).primaryTextTheme.headline3,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "What should we call you?",
                          style: textStyleFrom(
                            Theme.of(context).primaryTextTheme.headline4,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      SizedBox(height: 8),
                      _nameInput(model),
                      SizedBox(height: 20),
                      _acceptTandCInput(context, model),
                      _newsletterSignup(context, model),
                      _nextButton(model),
                      SizedBox(height: 10),
                      RichText(
                        text: TextSpan(children: [
                          TextSpan(
                              text: "View our privacy policy ",
                              style: textStyleFrom(
                                Theme.of(context).primaryTextTheme.bodyText1,
                                color: Colors.white,
                              )),
                          TextSpan(
                              text: "here",
                              style: textStyleFrom(
                                Theme.of(context).primaryTextTheme.bodyText1,
                                color: Theme.of(context).buttonColor,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  model.launchTandCs();
                                }),
                        ]),
                      ),
                      SizedBox(height: 10),
                    ],
                  ),

                  // Uncomment to readd Skip button
                  //skipButton(),
                ],
              ),
            )));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          backgroundColor: Theme.of(context).primaryColorDark,
          body: NotificationListener(
            onNotification: (OverscrollIndicatorNotification overscroll) {
              overscroll.disallowGlow();
              return true;
            },
            child: ViewModelBuilder<ProfileSetupViewModel>.reactive(
                viewModelBuilder: () => ProfileSetupViewModel(),
                builder: (context, model, child) {
                  return ListView(children: [
                    _setupProfileForm(context, model),
                  ]);
                }),
          ),
        ));
  }
}

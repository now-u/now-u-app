import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:nowu/assets/components/buttons/darkButton.dart';
import 'package:nowu/assets/components/inputs.dart';
import 'package:nowu/assets/constants.dart';
import 'package:nowu/themes.dart';
import 'package:nowu/ui/views/profile_setup/profile_setup_viewmodel.dart';
import 'package:stacked/stacked.dart';

class ProfileSetupView extends StackedView<ProfileSetupViewModel> {
  Widget _nameInput(ProfileSetupViewModel model) {
    return CustomTextFormField(
      style: CustomFormFieldStyle.Dark,
      keyboardType: TextInputType.text,
      textCapitalization: TextCapitalization.words,
      autofocus: false,
      validator: (value) {
        if (value.isEmpty) return 'Name cannot be empty';
        return null;
      },
      onChanged: (value) {
        model.name = value;
      },
      hintText: 'Jane Doe',
    );
  }

  Widget _acceptTandCInput(BuildContext context, ProfileSetupViewModel model) {
    return CustomCheckboxFormField(
      title: RichText(
        text: TextSpan(
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Colors.white,
              ),
          children: [
            const TextSpan(text: 'I agree to the user '),
            TextSpan(
              text: 'Terms & Conditions',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: CustomColors.brandColor,
                  ),
              recognizer: TapGestureRecognizer()..onTap = model.openTsAndCs,
            ),
          ],
        ),
      ),
      validator: (value) {
        if (!value!) return 'You must accept our terms and conditions';
        return null;
      },
    );
  }

  Widget _newsletterSignup(BuildContext context, ProfileSetupViewModel model) {
    return CustomCheckboxFormField(
      title: RichText(
        text: TextSpan(
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Colors.white,
              ),
          children: [
            const TextSpan(
              text: 'I am happy to receive the now-u newsletter via email',
            ),
          ],
        ),
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
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: DarkButton(
        'Next',
        onPressed: validateAndSave,
      ),
    );
  }

  Widget _setupProfileForm(BuildContext context, ProfileSetupViewModel model) {
    return Form(
      key: model.formKey,
      child: Padding(
        padding: const EdgeInsets.only(left: 24, right: 24),
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
                    padding: const EdgeInsets.only(top: 30, bottom: 10),
                    child: Text(
                      'Account Details',
                      style:
                          Theme.of(context).textTheme.headlineSmall?.copyWith(
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
                      'What should we call you?',
                      style:
                          Theme.of(context).textTheme.displayMedium?.copyWith(
                                color: Colors.white,
                              ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  const SizedBox(height: 8),
                  _nameInput(model),
                  const SizedBox(height: 20),
                  _acceptTandCInput(context, model),
                  _newsletterSignup(context, model),
                  _nextButton(model),
                  const SizedBox(height: 10),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'View our privacy policy ',
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    color: Colors.white,
                                  ),
                        ),
                        TextSpan(
                          text: 'here',
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    color: CustomColors.brandColor,
                                  ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              model.launchTandCs();
                            },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),

              // Uncomment to readd Skip button
              //skipButton(),
            ],
          ),
        ),
      ),
    );
  }

  @override
  ProfileSetupViewModel viewModelBuilder(BuildContext context) =>
      ProfileSetupViewModel();

  @override
  Widget builder(
    BuildContext context,
    ProfileSetupViewModel model,
    Widget? child,
  ) {
    return Theme(
      data: darkTheme,
      child: Scaffold(
        backgroundColor: darkTheme.colorScheme.background,
        body: NotificationListener(
          onNotification: (OverscrollIndicatorNotification overscroll) {
            overscroll.disallowIndicator();
            return true;
          },
          child: ListView(
            children: [
              _setupProfileForm(context, model),
            ],
          ),
        ),
      ),
    );
  }
}

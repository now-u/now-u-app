import 'package:auto_route/auto_route.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:nowu/assets/components/buttons/darkButton.dart';
import 'package:nowu/assets/components/inputs.dart';
import 'package:nowu/assets/constants.dart';
import 'package:nowu/locator.dart';
import 'package:nowu/router.dart';
import 'package:nowu/router.gr.dart';
import 'package:nowu/services/user_service.dart';
import 'package:nowu/themes.dart';
import 'package:nowu/ui/views/causes_selection/onboarding_view/onboarding_select_causes_view.dart';
import 'package:nowu/ui/views/profile_setup/bloc/profile_setup_bloc.dart';
import 'package:nowu/ui/views/profile_setup/model/name.dart';
import 'package:url_launcher/url_launcher.dart';

import 'bloc/profile_setup_state.dart';

@RoutePage()
class ProfileSetupView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: darkTheme,
      child: _Body(),
    );
  }
}

class _Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkTheme.colorScheme.surface,
      body: NotificationListener(
        onNotification: (OverscrollIndicatorNotification overscroll) {
          overscroll.disallowIndicator();
          return true;
        },
        child: ListView(
          children: [
            BlocProvider(
              create: (_) => ProfileSetupBloc(
                userService: locator<UserService>(),
              ),
              child: BlocListener<ProfileSetupBloc, ProfileSetupState>(
                listener: (context, state) {
                  switch (state.status) {
                    case FormzSubmissionStatus.success:
                      context.router.push(const OnboardingSelectCausesRoute());
                    case FormzSubmissionStatus.failure:
                      // TODO Do something
                    case FormzSubmissionStatus.inProgress:
                      // TODO Handle loading state (somewhere) - use that nice button
                    case FormzSubmissionStatus.initial:
                    case FormzSubmissionStatus.canceled:
                      break;
                  }
                },
                child: Form(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 24, right: 24),
                    child: SafeArea(
                      child: Column(
                        //shrinkWrap: true,
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          _AccountDetailsTitle(),
                          _AccountDetailsInputs(),
                
                          // Uncomment to readd Skip button
                          //skipButton(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AccountDetailsTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 30, bottom: 10),
          child: Text(
            'Account Details',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
      ],
    );
  }
}

class _AccountDetailsInputs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'What should we call you?',
            style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  color: Colors.white,
                ),
            textAlign: TextAlign.left,
          ),
        ),
        const SizedBox(height: 8),
        _NameInput(),
        const SizedBox(height: 20),
        _AcceptTandCInput(),
        _NewsLetterSignup(),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: DarkButton(
            'Next',
            onPressed: () {
              context.read<ProfileSetupBloc>().submit();
            },
          ),
        ),
        const SizedBox(height: 10),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'View our privacy policy ',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.white,
                    ),
              ),
              TextSpan(
                text: 'here',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: CustomColors.brandColor,
                    ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    launchLink(TERMS_AND_CONDITIONS_URI);
                  },
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}

class _NameInput extends StatelessWidget {
  String? _getErrorText(ProfileSetupState state) {
    switch (state.name.displayError) {
      case null:
        return null;
      case NameValidationError.empty:
        return 'Name must be provided';
      case NameValidationError.tooLong:
        return 'Name must be 30 characters or less';
      case NameValidationError.invalid:
        return 'Name must contain only letters';
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileSetupBloc, ProfileSetupState>(
      builder: (context, state) {
        return TextFormField(
          keyboardType: TextInputType.text,
          textCapitalization: TextCapitalization.words,
          autofocus: false,
          decoration: InputDecoration(
            errorText: _getErrorText(state),
            hintText: 'Jane Doe',
          ),
          onChanged: context.read<ProfileSetupBloc>().updateName,
        );
      },
    );
  }
}

class _NewsLetterSignup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
      onChanged:
          context.read<ProfileSetupBloc>().updateShouldSubscribeToNewsLetter,
    );
  }
}

class _AcceptTandCInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
              recognizer: TapGestureRecognizer()
                ..onTap = () => launchUrl(
                      TERMS_AND_CONDITIONS_URI,
                    ),
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
}

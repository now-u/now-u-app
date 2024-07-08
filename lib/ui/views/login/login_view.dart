import 'package:auto_route/auto_route.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:nowu/assets/constants.dart';
import 'package:nowu/locator.dart';
import 'package:nowu/router.dart';
import 'package:nowu/router.gr.dart';
import 'package:nowu/services/auth.dart';
import 'package:nowu/themes.dart';
import 'package:nowu/ui/common/form.dart';
import 'package:nowu/ui/views/login/bloc/login_bloc.dart';

import '../../common/filled_button.dart';
import 'bloc/login_state.dart';
import 'components/social_media_buttons.dart';
import 'models/email.dart';

@RoutePage()
class LoginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NotificationListener(
        onNotification: (OverscrollIndicatorNotification overscroll) {
          overscroll.disallowIndicator();
          return true;
        },
        child: BlocProvider(
          create: (context) {
            return LoginBloc(
              authenticationService: locator<AuthenticationService>(),
              appRouter: AutoRouter.of(context),
            );
          },
          child: ListView(
            children: [
              // TODO Fix clip scrolling under the status bar
              LoginForm(),
            ],
          ),
        ),
      ),
    );
  }
}

class LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipPath(
          clipper: LoginBackgroundClipper(),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.2,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.orange, Colors.deepOrangeAccent],
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              const SizedBox(height: 90),
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: Text(
                    'Sign up to now-u',
                    style: Theme.of(context).textTheme.headlineLarge,
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              const _OAuthLoginButtons(),
              const SizedBox(height: 30),
              Container(
                width: MediaQuery.of(context).size.width * 0.9,
                child: Text(
                  'Or sign up with email',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              const SizedBox(height: 30),
              const _EmailInput(),
              const SizedBox(height: 20),
              Container(
                width: MediaQuery.of(context).size.width * 0.6,
                child: const Column(
                  children: [
                    const _LoginButton(),
                    const SizedBox(height: 20),
                    const _SkipButton(),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'View our privacy policy ',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    TextSpan(
                      text: 'here',
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(color: CustomColors.brandColor),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          launchLinkExternal(context, PRIVACY_POLICY_URI);
                        },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ],
    );
  }
}

class _EmailInput extends StatelessWidget {
  const _EmailInput();

  String? getErrorText(Email email) {
    switch (email.displayError) {
      case null:
        return null;
      case EmailValidationError.empty:
        return 'Email must be provided';
      case EmailValidationError.invalid:
        return 'Email is invalid';
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return TextFormFieldWithExternalLabel(
          externalLabelText: 'Email',
          textFormField: TextFormField(
            keyboardType: TextInputType.emailAddress,
            textCapitalization: TextCapitalization.none,
            textInputAction: TextInputAction.next,
            autofocus: false,
            decoration: InputDecoration(
              errorText:
                  state.showValidation ? getErrorText(state.email) : null,
              hintText: 'e.g. jane.doe@email.com',
            ),
            onChanged: (value) {
              context.read<LoginBloc>().onEmailChanged(value);
            },
          ),
        );
      },
    );
  }
}

class _SkipButton extends StatelessWidget {
  const _SkipButton();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: FilledButton(
        style: secondaryFilledButtonStyle,
        child: const Text('Skip'),
        onPressed: () async {
          await context.router.replaceAll([
            TabsRoute(children: [const HomeRoute()]),
          ]);
        },
      ),
    );
  }
}

class _LoginButton extends StatelessWidget {
  const _LoginButton();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return NowFilledButton(
          title: 'Login',
          onPressed: () {
            context.read<LoginBloc>().onLoginWithEmail();
          },
          loading: state.status == FormzSubmissionStatus.inProgress,
        );
      },
    );
  }
}

class _OAuthLoginButtons extends StatelessWidget {
  const _OAuthLoginButtons();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return SocialMediaLoginButtons(context.read<LoginBloc>());
      },
    );
  }
}

class LoginBackgroundClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.moveTo(size.width * 0.2, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.quadraticBezierTo(
      size.width * 0.75,
      size.height * 0.9,
      size.width * 0.65,
      size.height * 0.6,
    );
    path.quadraticBezierTo(
      size.width * 0.5,
      size.height * 0.1,
      size.width * 0.2,
      0,
    );
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}

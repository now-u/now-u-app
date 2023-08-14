import 'package:nowu/assets/constants.dart';
import 'package:flutter/gestures.dart';
import 'package:nowu/themes.dart';
import 'package:nowu/ui/common/form.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

import 'login_view.form.dart';
import 'login_viewmodel.dart';

@FormView(
  fields: [
    FormTextField(
      name: 'emailInput',
      validator: LoginFormValidators.emailValidator,
    ),
  ],
)
class LoginView extends StackedView<LoginViewModel> with $LoginView {
  @override
  LoginViewModel viewModelBuilder(BuildContext context) => LoginViewModel();

  @override
  void onViewModelReady(LoginViewModel viewModel) => viewModel.init();

  @override
  void onDispose(LoginViewModel viewModel) => viewModel.dispose();

  @override
  Widget builder(
    BuildContext context,
    LoginViewModel viewModel,
    Widget? child,
  ) {
    Widget _emailInput(LoginViewModel model) {
      return TextFormFieldWithExternalLabel(
        externalLabelText: 'Email',
        textFormField: TextFormField(
          controller: emailInputController,
          keyboardType: TextInputType.emailAddress,
          textCapitalization: TextCapitalization.none,
          textInputAction: TextInputAction.next,
          autofocus: false,
          decoration: InputDecoration(
            errorText: model.emailInputValidationMessage,
            hintText: 'e.g. jane.doe@email.com',
          ),
          onChanged: (value) {
            if (model.emailInputValidationMessage != null) {
              model.validateForm();
            }
          },
        ),
      );
    }

    Widget _skipButton(LoginViewModel model) {
      return Container(
        width: double.infinity,
        child: TextButton(
          style: secondaryTextButtonStyle,
          child: const Text('Skip'),
          onPressed: () {
            model.skipLogin();
          },
        ),
      );
    }

    Widget _loginButton(LoginViewModel model) {
      return Container(
        width: double.infinity,
        child: TextButton(
          child: const Text('Create Account'),
          onPressed: () {
            model.loginWithEmail();
          },
        ),
      );
    }

    Widget _loginForm(LoginViewModel model) {
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SocialMediaLoginButton(
                      onPressed: model.loginWithGoogle,
                      iconData: FontAwesomeIcons.google,
                    ),
                    SocialMediaLoginButton(
                      onPressed: model.loginWithFacebook,
                      iconData: FontAwesomeIcons.facebookF,
                    ),
                  ],
                ),
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
                _emailInput(model),
                const SizedBox(height: 20),
                Container(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: Column(
                    children: [
                      _loginButton(model),
                      const SizedBox(height: 20),
                      _skipButton(model),
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
                            model.launchTandCs();
                          },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          )
        ],
      );
    }

    // TODO Fix will pop scope
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: NotificationListener(
          onNotification: (OverscrollIndicatorNotification overscroll) {
            overscroll.disallowIndicator();
            return true;
          },
          child: ListView(
            children: [
              // TODO Fix clip scrolling under the status bar
              _loginForm(viewModel),
            ],
          ),
        ),
      ),
    );
  }
}

class SocialMediaLoginButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData iconData;

  const SocialMediaLoginButton({
    Key? key,
    required this.onPressed,
    required this.iconData,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Icon(iconData, color: Colors.orange),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.white),
        padding: const MaterialStatePropertyAll(
          EdgeInsets.symmetric(vertical: 15, horizontal: 60),
        ),
      ),
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

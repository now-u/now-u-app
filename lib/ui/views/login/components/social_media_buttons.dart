import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../login_viewmodel.dart';

class SocialMediaLoginButtons extends StatelessWidget {
  SocialMediaLoginButtons(this._viewModel);

  final LoginViewModel _viewModel;

  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Platform.isIOS
              ? _SocialMediaLoginButton(
                  onPressed: _viewModel.loginWithApple,
                  iconData: FontAwesomeIcons.apple,
                )
              : _SocialMediaLoginButton(
                  onPressed: _viewModel.loginWithFacebook,
                  iconData: FontAwesomeIcons.facebookF,
                ),
          _SocialMediaLoginButton(
            onPressed: _viewModel.loginWithGoogle,
            iconData: FontAwesomeIcons.google,
          ),
        ],
      );
}

class _SocialMediaLoginButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData iconData;

  const _SocialMediaLoginButton({
    Key? key,
    required this.onPressed,
    required this.iconData,
  }) : super(key: key);

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

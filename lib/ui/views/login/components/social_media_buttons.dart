import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nowu/services/auth.dart';

import '../bloc/login_bloc.dart';

class SocialMediaLoginButtons extends StatelessWidget {
  SocialMediaLoginButtons(this._loginBloc);

  final LoginBloc _loginBloc;

  @override
  Widget build(BuildContext context) => Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          !kIsWeb && Platform.isIOS
              ? _SocialMediaLoginButton(
                  onPressed: () =>
                      _loginBloc.onLoginWithOAuth(AuthProvider.Apple),
                  iconData: FontAwesomeIcons.apple,
                )
              : _SocialMediaLoginButton(
                  onPressed: () =>
                      _loginBloc.onLoginWithOAuth(AuthProvider.Facebook),
                  iconData: FontAwesomeIcons.facebookF,
                ),
          const SizedBox(width: 10),
          _SocialMediaLoginButton(
            onPressed: () => _loginBloc.onLoginWithOAuth(AuthProvider.Google),
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
    return Expanded(
      child: FilledButton(
        onPressed: onPressed,
        child: Icon(iconData, color: Colors.orange, size: 32),
        style: ButtonStyle(
          padding:
              WidgetStateProperty.all(const EdgeInsets.symmetric(vertical: 20)),
          backgroundColor: WidgetStateProperty.all(Colors.white),
        ),
      ),
    );
  }
}

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';
import 'package:nowu/router.dart';
import 'package:nowu/router.gr.dart';
import 'package:nowu/ui/views/authentication/bloc/authentication_bloc.dart';
import 'package:nowu/ui/views/authentication/bloc/authentication_state.dart';

class LoginAuthStateListener extends StatelessWidget {
  final Logger _logger = Logger('LoginAuthStateListener');

  final Widget child;
  final String? initialRoute;

  LoginAuthStateListener({
    required this.child,
    required this.initialRoute,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        switch (state) {
          case AuthenticationStateAuthenticated(:final user)
              when !user.isInitialised:
            _logger.info(
              'User authenticated but not yet initalized, pushing to profile setup',
            );
            context.router.replaceAll([const ProfileSetupRoute()]);
            break;

          case AuthenticationStateAuthenticated():
            _logger.info(
              'User authenticated and initalized, pushing to initialRoute',
            );

            context.router.pushNamedRouteWithFallback(
              path: initialRoute,
              fallback: postLoginInitialRouteFallback,
              // After login, we don't want people going back to mid way through login
              clearHistroy: true,
            );
            break;

          case AuthenticationStateUnauthenticated():
          case AuthenticationStateUnknown():
            _logger.info(
              'User not authenticated not navigating yet',
            );
            break;
        }
      },
      child: child,
    );
  }
}

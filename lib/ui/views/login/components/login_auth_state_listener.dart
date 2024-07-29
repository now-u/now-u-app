import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';
import 'package:nowu/router.gr.dart';
import 'package:nowu/ui/views/authentication/bloc/authentication_bloc.dart';
import 'package:nowu/ui/views/authentication/bloc/authentication_state.dart';

class LoginAuthStateListener extends StatelessWidget {
  final Logger _logger = Logger('LoginAuthStateListener');

  final Widget child;

  LoginAuthStateListener({required this.child});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        PageRouteInfo? _getNextRoute(AuthenticationState authState) {
          switch (authState) {
            case AuthenticationStateAuthenticated(:final user)
                when !user.isInitialised:
              return const ProfileSetupRoute();
            case AuthenticationStateAuthenticated():
              return TabsRoute(children: [const HomeRoute()]);
            case AuthenticationStateUnauthenticated():
            case AuthenticationStateUnknown():
              return null;
          }
        }

        final route = _getNextRoute(state);
        _logger.info('Loging successful, next route: $route');

        if (route != null) {
          context.router.replaceAll([route]);
        }
      },
      child: child,
    );
  }
}

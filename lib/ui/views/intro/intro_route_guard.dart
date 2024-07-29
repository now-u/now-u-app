import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';
import 'package:nowu/router.gr.dart';
import 'package:nowu/ui/views/authentication/bloc/authentication_bloc.dart';
import 'package:nowu/ui/views/authentication/bloc/authentication_state.dart';

class IntroRouteGuard extends AutoRouteGuard {
  // TODO: https://github.com/Milad-Akarie/auto_route_library/issues/1174
  Logger _logger = Logger('IntroRouteGuard');
  AuthenticationBloc _authBloc;

  IntroRouteGuard({required AuthenticationBloc authenticationBloc})
      : this._authBloc = authenticationBloc;

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    _logger.info('Checking auth state: ${_authBloc.state}');
    // the navigation is paused until resolver.next() is called with either
    // true to resume/continue navigation or false to abort navigation
    switch (_authBloc.state) {
      case _ when kIsWeb:
      case AuthenticationStateAuthenticated(:final user)
          when !user.isInitialised:
        resolver.redirect(
          const ProfileSetupRoute(),
        );
      case AuthenticationStateAuthenticated():
      case AuthenticationStateUnauthenticated(:final hasShownIntro)
          when hasShownIntro:
        _logger.info('Skipping intro');
        resolver.next(true);
        break;
      default:
        _logger.info('Showing intro ${_authBloc.state}');
        resolver.redirect(
          const IntroRoute(),
        );
    }
  }
}

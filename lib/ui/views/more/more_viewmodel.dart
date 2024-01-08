import 'package:nowu/app/app.locator.dart';
import 'package:nowu/services/auth.dart';
import 'package:nowu/services/navigation_service.dart';
import 'package:nowu/services/router_service.dart';
import 'package:stacked/stacked.dart';

sealed class MenuItemAction {
  const MenuItemAction();
}

class RouteMenuItemAction extends MenuItemAction {
  final PageRouteInfo route;
  const RouteMenuItemAction(this.route);
}

class LinkMenuItemAction extends MenuItemAction {
  final String link;
  final bool isExternal;
  const LinkMenuItemAction(this.link, {this.isExternal = false});
}

class FunctionMenuItemAction extends MenuItemAction {
  final Future<void> Function() function;
  const FunctionMenuItemAction(this.function);
}

class MoreViewModel extends BaseViewModel {
  final _authenticationService = locator<AuthenticationService>();
  final _navigationService = locator<NavigationService>();
  final _routerService = locator<RouterService>();

  bool get isLoggedIn => _authenticationService.isUserLoggedIn();

  Future<void> logout() async {
    await _authenticationService.logout();
    _routerService.clearStackAndShow(const LoginViewRoute());
  }

  Future<void> performMenuItemAction(MenuItemAction action) {
    switch (action) {
      case LinkMenuItemAction():
        return _navigationService.launchLink(
          action.link,
          // TODO This is broken at the moment (at least for app store)
          // TODO 1 - fix this is we still need external links
          // TODO 2 - Open app store directly (not via broswer)
          isExternal: action.isExternal,
        );
      case RouteMenuItemAction():
        return _routerService.navigateTo(action.route);
      case FunctionMenuItemAction():
        return action.function();
    }
  }

  Future<void> launchLinkExternal(String link) {
    return _navigationService.launchLink(link, isExternal: true);
  }
}

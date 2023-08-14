// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedRouterGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter/foundation.dart' as _i16;
import 'package:flutter/material.dart' as _i15;
import 'package:stacked/stacked.dart' as _i14;
import 'package:stacked_services/stacked_services.dart' as _i13;

import '../services/causes_service.dart' as _i17;
import '../ui/views/action_info/action_info_view.dart' as _i4;
import '../ui/views/campaign_info/campaign_info_view.dart' as _i5;
import '../ui/views/causes_selection/change_view/change_select_causes_view.dart'
    as _i10;
import '../ui/views/causes_selection/onboarding_view/onboarding_select_causes_view.dart'
    as _i11;
import '../ui/views/explore/explore_page_definition.dart' as _i18;
import '../ui/views/faq/faq_view.dart' as _i6;
import '../ui/views/intro/intro_view.dart' as _i7;
import '../ui/views/login/login_view.dart' as _i9;
import '../ui/views/partners/partners_view.dart' as _i3;
import '../ui/views/profile_setup/profile_setup_view.dart' as _i8;
import '../ui/views/search/search_view.dart' as _i2;
import '../ui/views/startup/startup_view.dart' as _i1;
import '../ui/views/tabs/tabs_view.dart' as _i12;

final stackedRouter =
    StackedRouterWeb(navigatorKey: _i13.StackedService.navigatorKey);

class StackedRouterWeb extends _i14.RootStackRouter {
  StackedRouterWeb({_i15.GlobalKey<_i15.NavigatorState>? navigatorKey})
      : super(navigatorKey);

  @override
  final Map<String, _i14.PageFactory> pagesMap = {
    StartupViewRoute.name: (routeData) {
      return _i14.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i1.StartupView(),
        opaque: true,
        barrierDismissible: false,
      );
    },
    SearchViewRoute.name: (routeData) {
      final args = routeData.argsAs<SearchViewArgs>(
          orElse: () => const SearchViewArgs());
      return _i14.CustomPage<dynamic>(
        routeData: routeData,
        child: _i2.SearchView(key: args.key),
        opaque: true,
        barrierDismissible: false,
      );
    },
    PartnersViewRoute.name: (routeData) {
      return _i14.CustomPage<dynamic>(
        routeData: routeData,
        child: _i3.PartnersView(),
        opaque: true,
        barrierDismissible: false,
      );
    },
    ActionInfoViewRoute.name: (routeData) {
      final args = routeData.argsAs<ActionInfoViewArgs>();
      return _i14.CustomPage<dynamic>(
        routeData: routeData,
        child: _i4.ActionInfoView(
          key: args.key,
          actionId: args.actionId,
        ),
        opaque: true,
        barrierDismissible: false,
      );
    },
    CampaignInfoViewRoute.name: (routeData) {
      final args = routeData.argsAs<CampaignInfoViewArgs>();
      return _i14.CustomPage<dynamic>(
        routeData: routeData,
        child: _i5.CampaignInfoView(args.listCampaign),
        opaque: true,
        barrierDismissible: false,
      );
    },
    FAQViewRoute.name: (routeData) {
      return _i14.CustomPage<dynamic>(
        routeData: routeData,
        child: _i6.FAQView(),
        opaque: true,
        barrierDismissible: false,
      );
    },
    IntroViewRoute.name: (routeData) {
      return _i14.CustomPage<dynamic>(
        routeData: routeData,
        child: _i7.IntroView(),
        opaque: true,
        barrierDismissible: false,
      );
    },
    ProfileSetupViewRoute.name: (routeData) {
      return _i14.CustomPage<dynamic>(
        routeData: routeData,
        child: _i8.ProfileSetupView(),
        opaque: true,
        barrierDismissible: false,
      );
    },
    LoginViewRoute.name: (routeData) {
      return _i14.CustomPage<dynamic>(
        routeData: routeData,
        child: _i9.LoginView(),
        opaque: true,
        barrierDismissible: false,
      );
    },
    ChangeSelectCausesViewRoute.name: (routeData) {
      return _i14.CustomPage<dynamic>(
        routeData: routeData,
        child: _i10.ChangeSelectCausesView(),
        opaque: true,
        barrierDismissible: false,
      );
    },
    OnboardingSelectCausesViewRoute.name: (routeData) {
      return _i14.CustomPage<dynamic>(
        routeData: routeData,
        child: _i11.OnboardingSelectCausesView(),
        opaque: true,
        barrierDismissible: false,
      );
    },
    TabsViewRoute.name: (routeData) {
      final args =
          routeData.argsAs<TabsViewArgs>(orElse: () => const TabsViewArgs());
      return _i14.CustomPage<dynamic>(
        routeData: routeData,
        child: _i12.TabsView(
          initialPage: args.initialPage,
          explorePageArgs: args.explorePageArgs,
        ),
        opaque: true,
        barrierDismissible: false,
      );
    },
  };

  @override
  List<_i14.RouteConfig> get routes => [
        _i14.RouteConfig(
          StartupViewRoute.name,
          path: '/',
        ),
        _i14.RouteConfig(
          SearchViewRoute.name,
          path: '/search-view',
        ),
        _i14.RouteConfig(
          PartnersViewRoute.name,
          path: '/partners-view',
        ),
        _i14.RouteConfig(
          ActionInfoViewRoute.name,
          path: 'action/:actionId',
        ),
        _i14.RouteConfig(
          CampaignInfoViewRoute.name,
          path: '/campaign-info-view',
        ),
        _i14.RouteConfig(
          FAQViewRoute.name,
          path: '/f-aq-view',
        ),
        _i14.RouteConfig(
          IntroViewRoute.name,
          path: '/intro-view',
        ),
        _i14.RouteConfig(
          ProfileSetupViewRoute.name,
          path: '/profile-setup-view',
        ),
        _i14.RouteConfig(
          LoginViewRoute.name,
          path: '/login-view',
        ),
        _i14.RouteConfig(
          ChangeSelectCausesViewRoute.name,
          path: '/change-select-causes-view',
        ),
        _i14.RouteConfig(
          OnboardingSelectCausesViewRoute.name,
          path: '/onboarding-select-causes-view',
        ),
        _i14.RouteConfig(
          TabsViewRoute.name,
          path: '/tabs-view',
        ),
      ];
}

/// generated route for
/// [_i1.StartupView]
class StartupViewRoute extends _i14.PageRouteInfo<void> {
  const StartupViewRoute()
      : super(
          StartupViewRoute.name,
          path: '/',
        );

  static const String name = 'StartupView';
}

/// generated route for
/// [_i2.SearchView]
class SearchViewRoute extends _i14.PageRouteInfo<SearchViewArgs> {
  SearchViewRoute({_i16.Key? key})
      : super(
          SearchViewRoute.name,
          path: '/search-view',
          args: SearchViewArgs(key: key),
        );

  static const String name = 'SearchView';
}

class SearchViewArgs {
  const SearchViewArgs({this.key});

  final _i16.Key? key;

  @override
  String toString() {
    return 'SearchViewArgs{key: $key}';
  }
}

/// generated route for
/// [_i3.PartnersView]
class PartnersViewRoute extends _i14.PageRouteInfo<void> {
  const PartnersViewRoute()
      : super(
          PartnersViewRoute.name,
          path: '/partners-view',
        );

  static const String name = 'PartnersView';
}

/// generated route for
/// [_i4.ActionInfoView]
class ActionInfoViewRoute extends _i14.PageRouteInfo<ActionInfoViewArgs> {
  ActionInfoViewRoute({
    _i16.Key? key,
    required int actionId,
  }) : super(
          ActionInfoViewRoute.name,
          path: 'action/:actionId',
          args: ActionInfoViewArgs(
            key: key,
            actionId: actionId,
          ),
        );

  static const String name = 'ActionInfoView';
}

class ActionInfoViewArgs {
  const ActionInfoViewArgs({
    this.key,
    required this.actionId,
  });

  final _i16.Key? key;

  final int actionId;

  @override
  String toString() {
    return 'ActionInfoViewArgs{key: $key, actionId: $actionId}';
  }
}

/// generated route for
/// [_i5.CampaignInfoView]
class CampaignInfoViewRoute extends _i14.PageRouteInfo<CampaignInfoViewArgs> {
  CampaignInfoViewRoute({required _i17.ListCampaign listCampaign})
      : super(
          CampaignInfoViewRoute.name,
          path: '/campaign-info-view',
          args: CampaignInfoViewArgs(listCampaign: listCampaign),
        );

  static const String name = 'CampaignInfoView';
}

class CampaignInfoViewArgs {
  const CampaignInfoViewArgs({required this.listCampaign});

  final _i17.ListCampaign listCampaign;

  @override
  String toString() {
    return 'CampaignInfoViewArgs{listCampaign: $listCampaign}';
  }
}

/// generated route for
/// [_i6.FAQView]
class FAQViewRoute extends _i14.PageRouteInfo<void> {
  const FAQViewRoute()
      : super(
          FAQViewRoute.name,
          path: '/f-aq-view',
        );

  static const String name = 'FAQView';
}

/// generated route for
/// [_i7.IntroView]
class IntroViewRoute extends _i14.PageRouteInfo<void> {
  const IntroViewRoute()
      : super(
          IntroViewRoute.name,
          path: '/intro-view',
        );

  static const String name = 'IntroView';
}

/// generated route for
/// [_i8.ProfileSetupView]
class ProfileSetupViewRoute extends _i14.PageRouteInfo<void> {
  const ProfileSetupViewRoute()
      : super(
          ProfileSetupViewRoute.name,
          path: '/profile-setup-view',
        );

  static const String name = 'ProfileSetupView';
}

/// generated route for
/// [_i9.LoginView]
class LoginViewRoute extends _i14.PageRouteInfo<void> {
  const LoginViewRoute()
      : super(
          LoginViewRoute.name,
          path: '/login-view',
        );

  static const String name = 'LoginView';
}

/// generated route for
/// [_i10.ChangeSelectCausesView]
class ChangeSelectCausesViewRoute extends _i14.PageRouteInfo<void> {
  const ChangeSelectCausesViewRoute()
      : super(
          ChangeSelectCausesViewRoute.name,
          path: '/change-select-causes-view',
        );

  static const String name = 'ChangeSelectCausesView';
}

/// generated route for
/// [_i11.OnboardingSelectCausesView]
class OnboardingSelectCausesViewRoute extends _i14.PageRouteInfo<void> {
  const OnboardingSelectCausesViewRoute()
      : super(
          OnboardingSelectCausesViewRoute.name,
          path: '/onboarding-select-causes-view',
        );

  static const String name = 'OnboardingSelectCausesView';
}

/// generated route for
/// [_i12.TabsView]
class TabsViewRoute extends _i14.PageRouteInfo<TabsViewArgs> {
  TabsViewRoute({
    _i12.TabPage? initialPage,
    _i18.ExplorePageArguments? explorePageArgs,
  }) : super(
          TabsViewRoute.name,
          path: '/tabs-view',
          args: TabsViewArgs(
            initialPage: initialPage,
            explorePageArgs: explorePageArgs,
          ),
        );

  static const String name = 'TabsView';
}

class TabsViewArgs {
  const TabsViewArgs({
    this.initialPage,
    this.explorePageArgs,
  });

  final _i12.TabPage? initialPage;

  final _i18.ExplorePageArguments? explorePageArgs;

  @override
  String toString() {
    return 'TabsViewArgs{initialPage: $initialPage, explorePageArgs: $explorePageArgs}';
  }
}

extension RouterStateExtension on _i13.RouterService {
  Future<dynamic> navigateToStartupView(
      {void Function(_i14.NavigationFailure)? onFailure}) async {
    return navigateTo(
      const StartupViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> navigateToSearchView({
    _i16.Key? key,
    void Function(_i14.NavigationFailure)? onFailure,
  }) async {
    return navigateTo(
      SearchViewRoute(
        key: key,
      ),
      onFailure: onFailure,
    );
  }

  Future<dynamic> navigateToPartnersView(
      {void Function(_i14.NavigationFailure)? onFailure}) async {
    return navigateTo(
      const PartnersViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> navigateToActionInfoView({
    _i16.Key? key,
    required int actionId,
    void Function(_i14.NavigationFailure)? onFailure,
  }) async {
    return navigateTo(
      ActionInfoViewRoute(
        key: key,
        actionId: actionId,
      ),
      onFailure: onFailure,
    );
  }

  Future<dynamic> navigateToCampaignInfoView({
    required _i17.ListCampaign listCampaign,
    void Function(_i14.NavigationFailure)? onFailure,
  }) async {
    return navigateTo(
      CampaignInfoViewRoute(
        listCampaign: listCampaign,
      ),
      onFailure: onFailure,
    );
  }

  Future<dynamic> navigateToFAQView(
      {void Function(_i14.NavigationFailure)? onFailure}) async {
    return navigateTo(
      const FAQViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> navigateToIntroView(
      {void Function(_i14.NavigationFailure)? onFailure}) async {
    return navigateTo(
      const IntroViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> navigateToProfileSetupView(
      {void Function(_i14.NavigationFailure)? onFailure}) async {
    return navigateTo(
      const ProfileSetupViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> navigateToLoginView(
      {void Function(_i14.NavigationFailure)? onFailure}) async {
    return navigateTo(
      const LoginViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> navigateToChangeSelectCausesView(
      {void Function(_i14.NavigationFailure)? onFailure}) async {
    return navigateTo(
      const ChangeSelectCausesViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> navigateToOnboardingSelectCausesView(
      {void Function(_i14.NavigationFailure)? onFailure}) async {
    return navigateTo(
      const OnboardingSelectCausesViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> navigateToTabsView({
    _i12.TabPage? initialPage,
    _i18.ExplorePageArguments? explorePageArgs,
    void Function(_i14.NavigationFailure)? onFailure,
  }) async {
    return navigateTo(
      TabsViewRoute(
        initialPage: initialPage,
        explorePageArgs: explorePageArgs,
      ),
      onFailure: onFailure,
    );
  }

  Future<dynamic> replaceWithStartupView(
      {void Function(_i14.NavigationFailure)? onFailure}) async {
    return replaceWith(
      const StartupViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> replaceWithSearchView({
    _i16.Key? key,
    void Function(_i14.NavigationFailure)? onFailure,
  }) async {
    return replaceWith(
      SearchViewRoute(
        key: key,
      ),
      onFailure: onFailure,
    );
  }

  Future<dynamic> replaceWithPartnersView(
      {void Function(_i14.NavigationFailure)? onFailure}) async {
    return replaceWith(
      const PartnersViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> replaceWithActionInfoView({
    _i16.Key? key,
    required int actionId,
    void Function(_i14.NavigationFailure)? onFailure,
  }) async {
    return replaceWith(
      ActionInfoViewRoute(
        key: key,
        actionId: actionId,
      ),
      onFailure: onFailure,
    );
  }

  Future<dynamic> replaceWithCampaignInfoView({
    required _i17.ListCampaign listCampaign,
    void Function(_i14.NavigationFailure)? onFailure,
  }) async {
    return replaceWith(
      CampaignInfoViewRoute(
        listCampaign: listCampaign,
      ),
      onFailure: onFailure,
    );
  }

  Future<dynamic> replaceWithFAQView(
      {void Function(_i14.NavigationFailure)? onFailure}) async {
    return replaceWith(
      const FAQViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> replaceWithIntroView(
      {void Function(_i14.NavigationFailure)? onFailure}) async {
    return replaceWith(
      const IntroViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> replaceWithProfileSetupView(
      {void Function(_i14.NavigationFailure)? onFailure}) async {
    return replaceWith(
      const ProfileSetupViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> replaceWithLoginView(
      {void Function(_i14.NavigationFailure)? onFailure}) async {
    return replaceWith(
      const LoginViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> replaceWithChangeSelectCausesView(
      {void Function(_i14.NavigationFailure)? onFailure}) async {
    return replaceWith(
      const ChangeSelectCausesViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> replaceWithOnboardingSelectCausesView(
      {void Function(_i14.NavigationFailure)? onFailure}) async {
    return replaceWith(
      const OnboardingSelectCausesViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> replaceWithTabsView({
    _i12.TabPage? initialPage,
    _i18.ExplorePageArguments? explorePageArgs,
    void Function(_i14.NavigationFailure)? onFailure,
  }) async {
    return replaceWith(
      TabsViewRoute(
        initialPage: initialPage,
        explorePageArgs: explorePageArgs,
      ),
      onFailure: onFailure,
    );
  }
}

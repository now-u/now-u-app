// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedRouterGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:causeApiClient/causeApiClient.dart' as _i23;
import 'package:flutter/foundation.dart' as _i20;
import 'package:flutter/material.dart' as _i19;
import 'package:stacked/stacked.dart' as _i18;
import 'package:stacked_services/stacked_services.dart' as _i17;

import '../models/Notification.dart' as _i24;
import '../services/causes_service.dart' as _i21;
import '../services/search_service.dart' as _i22;
import '../ui/views/action_info/action_info_view.dart' as _i4;
import '../ui/views/campaign_info/campaign_info_view.dart' as _i5;
import '../ui/views/causes_selection/change_view/change_select_causes_view.dart'
    as _i12;
import '../ui/views/causes_selection/onboarding_view/onboarding_select_causes_view.dart'
    as _i13;
import '../ui/views/faq/faq_view.dart' as _i6;
import '../ui/views/intro/intro_view.dart' as _i7;
import '../ui/views/login/login_view.dart' as _i9;
import '../ui/views/login_code/login_code_view.dart' as _i10;
import '../ui/views/login_email_sent/login_email_sent_view.dart' as _i11;
import '../ui/views/notification_info/notification_info_view.dart' as _i16;
import '../ui/views/partner_info/partner_info_view.dart' as _i15;
import '../ui/views/partners/partners_view.dart' as _i3;
import '../ui/views/profile_setup/profile_setup_view.dart' as _i8;
import '../ui/views/search/search_view.dart' as _i2;
import '../ui/views/startup/startup_view.dart' as _i1;
import '../ui/views/tabs/tabs_view.dart' as _i14;

final stackedRouter =
    StackedRouterWeb(navigatorKey: _i17.StackedService.navigatorKey);

class StackedRouterWeb extends _i18.RootStackRouter {
  StackedRouterWeb({_i19.GlobalKey<_i19.NavigatorState>? navigatorKey})
      : super(navigatorKey);

  @override
  final Map<String, _i18.PageFactory> pagesMap = {
    StartupViewRoute.name: (routeData) {
      return _i18.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i1.StartupView(),
        opaque: true,
        barrierDismissible: false,
      );
    },
    SearchViewRoute.name: (routeData) {
      final args = routeData.argsAs<SearchViewArgs>(
          orElse: () => const SearchViewArgs());
      return _i18.CustomPage<dynamic>(
        routeData: routeData,
        child: _i2.SearchView(key: args.key),
        opaque: true,
        barrierDismissible: false,
      );
    },
    PartnersViewRoute.name: (routeData) {
      return _i18.CustomPage<dynamic>(
        routeData: routeData,
        child: _i3.PartnersView(),
        opaque: true,
        barrierDismissible: false,
      );
    },
    ActionInfoViewRoute.name: (routeData) {
      final args = routeData.argsAs<ActionInfoViewArgs>();
      return _i18.CustomPage<dynamic>(
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
      return _i18.CustomPage<dynamic>(
        routeData: routeData,
        child: _i5.CampaignInfoView(args.listCampaign),
        opaque: true,
        barrierDismissible: false,
      );
    },
    FaqViewRoute.name: (routeData) {
      return _i18.CustomPage<dynamic>(
        routeData: routeData,
        child: _i6.FaqView(),
        opaque: true,
        barrierDismissible: false,
      );
    },
    IntroViewRoute.name: (routeData) {
      return _i18.CustomPage<dynamic>(
        routeData: routeData,
        child: _i7.IntroView(),
        opaque: true,
        barrierDismissible: false,
      );
    },
    ProfileSetupViewRoute.name: (routeData) {
      return _i18.CustomPage<dynamic>(
        routeData: routeData,
        child: _i8.ProfileSetupView(),
        opaque: true,
        barrierDismissible: false,
      );
    },
    LoginViewRoute.name: (routeData) {
      return _i18.CustomPage<dynamic>(
        routeData: routeData,
        child: _i9.LoginView(),
        opaque: true,
        barrierDismissible: false,
      );
    },
    LoginCodeViewRoute.name: (routeData) {
      final args = routeData.argsAs<LoginCodeViewArgs>();
      return _i18.CustomPage<dynamic>(
        routeData: routeData,
        child: _i10.LoginCodeView(
          key: args.key,
          email: args.email,
        ),
        opaque: true,
        barrierDismissible: false,
      );
    },
    LoginEmailSentViewRoute.name: (routeData) {
      final args = routeData.argsAs<LoginEmailSentViewArgs>();
      return _i18.CustomPage<dynamic>(
        routeData: routeData,
        child: _i11.LoginEmailSentView(
          key: args.key,
          email: args.email,
          token: args.token,
        ),
        opaque: true,
        barrierDismissible: false,
      );
    },
    ChangeSelectCausesViewRoute.name: (routeData) {
      return _i18.CustomPage<dynamic>(
        routeData: routeData,
        child: _i12.ChangeSelectCausesView(),
        opaque: true,
        barrierDismissible: false,
      );
    },
    OnboardingSelectCausesViewRoute.name: (routeData) {
      return _i18.CustomPage<dynamic>(
        routeData: routeData,
        child: _i13.OnboardingSelectCausesView(),
        opaque: true,
        barrierDismissible: false,
      );
    },
    TabsViewRoute.name: (routeData) {
      final args =
          routeData.argsAs<TabsViewArgs>(orElse: () => const TabsViewArgs());
      return _i18.CustomPage<dynamic>(
        routeData: routeData,
        child: _i14.TabsView(
          initialPage: args.initialPage,
          explorePageBaseFilter: args.explorePageBaseFilter,
        ),
        opaque: true,
        barrierDismissible: false,
      );
    },
    PartnerInfoViewRoute.name: (routeData) {
      final args = routeData.argsAs<PartnerInfoViewArgs>();
      return _i18.CustomPage<dynamic>(
        routeData: routeData,
        child: _i15.PartnerInfoView(
          key: args.key,
          organisation: args.organisation,
        ),
        opaque: true,
        barrierDismissible: false,
      );
    },
    NotificationInfoViewRoute.name: (routeData) {
      final args = routeData.argsAs<NotificationInfoViewArgs>();
      return _i18.CustomPage<dynamic>(
        routeData: routeData,
        child: _i16.NotificationInfoView(notification: args.notification),
        opaque: true,
        barrierDismissible: false,
      );
    },
  };

  @override
  List<_i18.RouteConfig> get routes => [
        _i18.RouteConfig(
          StartupViewRoute.name,
          path: '/',
        ),
        _i18.RouteConfig(
          SearchViewRoute.name,
          path: '/search-view',
        ),
        _i18.RouteConfig(
          PartnersViewRoute.name,
          path: '/partners-view',
        ),
        _i18.RouteConfig(
          ActionInfoViewRoute.name,
          path: 'action/:actionId',
        ),
        _i18.RouteConfig(
          CampaignInfoViewRoute.name,
          path: '/campaign-info-view',
        ),
        _i18.RouteConfig(
          FaqViewRoute.name,
          path: '/faq-view',
        ),
        _i18.RouteConfig(
          IntroViewRoute.name,
          path: '/intro-view',
        ),
        _i18.RouteConfig(
          ProfileSetupViewRoute.name,
          path: '/profile-setup-view',
        ),
        _i18.RouteConfig(
          LoginViewRoute.name,
          path: '/login-view',
        ),
        _i18.RouteConfig(
          LoginCodeViewRoute.name,
          path: '/login-code-view',
        ),
        _i18.RouteConfig(
          LoginEmailSentViewRoute.name,
          path: '/login-email-sent-view',
        ),
        _i18.RouteConfig(
          ChangeSelectCausesViewRoute.name,
          path: '/change-select-causes-view',
        ),
        _i18.RouteConfig(
          OnboardingSelectCausesViewRoute.name,
          path: '/onboarding-select-causes-view',
        ),
        _i18.RouteConfig(
          TabsViewRoute.name,
          path: '/tabs-view',
        ),
        _i18.RouteConfig(
          PartnerInfoViewRoute.name,
          path: '/partner-info-view',
        ),
        _i18.RouteConfig(
          NotificationInfoViewRoute.name,
          path: '/notification-info-view',
        ),
      ];
}

/// generated route for
/// [_i1.StartupView]
class StartupViewRoute extends _i18.PageRouteInfo<void> {
  const StartupViewRoute()
      : super(
          StartupViewRoute.name,
          path: '/',
        );

  static const String name = 'StartupView';
}

/// generated route for
/// [_i2.SearchView]
class SearchViewRoute extends _i18.PageRouteInfo<SearchViewArgs> {
  SearchViewRoute({_i20.Key? key})
      : super(
          SearchViewRoute.name,
          path: '/search-view',
          args: SearchViewArgs(key: key),
        );

  static const String name = 'SearchView';
}

class SearchViewArgs {
  const SearchViewArgs({this.key});

  final _i20.Key? key;

  @override
  String toString() {
    return 'SearchViewArgs{key: $key}';
  }
}

/// generated route for
/// [_i3.PartnersView]
class PartnersViewRoute extends _i18.PageRouteInfo<void> {
  const PartnersViewRoute()
      : super(
          PartnersViewRoute.name,
          path: '/partners-view',
        );

  static const String name = 'PartnersView';
}

/// generated route for
/// [_i4.ActionInfoView]
class ActionInfoViewRoute extends _i18.PageRouteInfo<ActionInfoViewArgs> {
  ActionInfoViewRoute({
    _i20.Key? key,
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

  final _i20.Key? key;

  final int actionId;

  @override
  String toString() {
    return 'ActionInfoViewArgs{key: $key, actionId: $actionId}';
  }
}

/// generated route for
/// [_i5.CampaignInfoView]
class CampaignInfoViewRoute extends _i18.PageRouteInfo<CampaignInfoViewArgs> {
  CampaignInfoViewRoute({required _i21.ListCampaign listCampaign})
      : super(
          CampaignInfoViewRoute.name,
          path: '/campaign-info-view',
          args: CampaignInfoViewArgs(listCampaign: listCampaign),
        );

  static const String name = 'CampaignInfoView';
}

class CampaignInfoViewArgs {
  const CampaignInfoViewArgs({required this.listCampaign});

  final _i21.ListCampaign listCampaign;

  @override
  String toString() {
    return 'CampaignInfoViewArgs{listCampaign: $listCampaign}';
  }
}

/// generated route for
/// [_i6.FaqView]
class FaqViewRoute extends _i18.PageRouteInfo<void> {
  const FaqViewRoute()
      : super(
          FaqViewRoute.name,
          path: '/faq-view',
        );

  static const String name = 'FaqView';
}

/// generated route for
/// [_i7.IntroView]
class IntroViewRoute extends _i18.PageRouteInfo<void> {
  const IntroViewRoute()
      : super(
          IntroViewRoute.name,
          path: '/intro-view',
        );

  static const String name = 'IntroView';
}

/// generated route for
/// [_i8.ProfileSetupView]
class ProfileSetupViewRoute extends _i18.PageRouteInfo<void> {
  const ProfileSetupViewRoute()
      : super(
          ProfileSetupViewRoute.name,
          path: '/profile-setup-view',
        );

  static const String name = 'ProfileSetupView';
}

/// generated route for
/// [_i9.LoginView]
class LoginViewRoute extends _i18.PageRouteInfo<void> {
  const LoginViewRoute()
      : super(
          LoginViewRoute.name,
          path: '/login-view',
        );

  static const String name = 'LoginView';
}

/// generated route for
/// [_i10.LoginCodeView]
class LoginCodeViewRoute extends _i18.PageRouteInfo<LoginCodeViewArgs> {
  LoginCodeViewRoute({
    _i20.Key? key,
    required String email,
  }) : super(
          LoginCodeViewRoute.name,
          path: '/login-code-view',
          args: LoginCodeViewArgs(
            key: key,
            email: email,
          ),
        );

  static const String name = 'LoginCodeView';
}

class LoginCodeViewArgs {
  const LoginCodeViewArgs({
    this.key,
    required this.email,
  });

  final _i20.Key? key;

  final String email;

  @override
  String toString() {
    return 'LoginCodeViewArgs{key: $key, email: $email}';
  }
}

/// generated route for
/// [_i11.LoginEmailSentView]
class LoginEmailSentViewRoute
    extends _i18.PageRouteInfo<LoginEmailSentViewArgs> {
  LoginEmailSentViewRoute({
    _i20.Key? key,
    required String email,
    String? token,
  }) : super(
          LoginEmailSentViewRoute.name,
          path: '/login-email-sent-view',
          args: LoginEmailSentViewArgs(
            key: key,
            email: email,
            token: token,
          ),
        );

  static const String name = 'LoginEmailSentView';
}

class LoginEmailSentViewArgs {
  const LoginEmailSentViewArgs({
    this.key,
    required this.email,
    this.token,
  });

  final _i20.Key? key;

  final String email;

  final String? token;

  @override
  String toString() {
    return 'LoginEmailSentViewArgs{key: $key, email: $email, token: $token}';
  }
}

/// generated route for
/// [_i12.ChangeSelectCausesView]
class ChangeSelectCausesViewRoute extends _i18.PageRouteInfo<void> {
  const ChangeSelectCausesViewRoute()
      : super(
          ChangeSelectCausesViewRoute.name,
          path: '/change-select-causes-view',
        );

  static const String name = 'ChangeSelectCausesView';
}

/// generated route for
/// [_i13.OnboardingSelectCausesView]
class OnboardingSelectCausesViewRoute extends _i18.PageRouteInfo<void> {
  const OnboardingSelectCausesViewRoute()
      : super(
          OnboardingSelectCausesViewRoute.name,
          path: '/onboarding-select-causes-view',
        );

  static const String name = 'OnboardingSelectCausesView';
}

/// generated route for
/// [_i14.TabsView]
class TabsViewRoute extends _i18.PageRouteInfo<TabsViewArgs> {
  TabsViewRoute({
    _i14.TabPage? initialPage,
    _i22.BaseResourceSearchFilter? explorePageBaseFilter,
  }) : super(
          TabsViewRoute.name,
          path: '/tabs-view',
          args: TabsViewArgs(
            initialPage: initialPage,
            explorePageBaseFilter: explorePageBaseFilter,
          ),
        );

  static const String name = 'TabsView';
}

class TabsViewArgs {
  const TabsViewArgs({
    this.initialPage,
    this.explorePageBaseFilter,
  });

  final _i14.TabPage? initialPage;

  final _i22.BaseResourceSearchFilter? explorePageBaseFilter;

  @override
  String toString() {
    return 'TabsViewArgs{initialPage: $initialPage, explorePageBaseFilter: $explorePageBaseFilter}';
  }
}

/// generated route for
/// [_i15.PartnerInfoView]
class PartnerInfoViewRoute extends _i18.PageRouteInfo<PartnerInfoViewArgs> {
  PartnerInfoViewRoute({
    _i20.Key? key,
    required _i23.Organisation organisation,
  }) : super(
          PartnerInfoViewRoute.name,
          path: '/partner-info-view',
          args: PartnerInfoViewArgs(
            key: key,
            organisation: organisation,
          ),
        );

  static const String name = 'PartnerInfoView';
}

class PartnerInfoViewArgs {
  const PartnerInfoViewArgs({
    this.key,
    required this.organisation,
  });

  final _i20.Key? key;

  final _i23.Organisation organisation;

  @override
  String toString() {
    return 'PartnerInfoViewArgs{key: $key, organisation: $organisation}';
  }
}

/// generated route for
/// [_i16.NotificationInfoView]
class NotificationInfoViewRoute
    extends _i18.PageRouteInfo<NotificationInfoViewArgs> {
  NotificationInfoViewRoute({required _i24.InternalNotification notification})
      : super(
          NotificationInfoViewRoute.name,
          path: '/notification-info-view',
          args: NotificationInfoViewArgs(notification: notification),
        );

  static const String name = 'NotificationInfoView';
}

class NotificationInfoViewArgs {
  const NotificationInfoViewArgs({required this.notification});

  final _i24.InternalNotification notification;

  @override
  String toString() {
    return 'NotificationInfoViewArgs{notification: $notification}';
  }
}

extension RouterStateExtension on _i17.RouterService {
  Future<dynamic> navigateToStartupView(
      {void Function(_i18.NavigationFailure)? onFailure}) async {
    return navigateTo(
      const StartupViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> navigateToSearchView({
    _i20.Key? key,
    void Function(_i18.NavigationFailure)? onFailure,
  }) async {
    return navigateTo(
      SearchViewRoute(
        key: key,
      ),
      onFailure: onFailure,
    );
  }

  Future<dynamic> navigateToPartnersView(
      {void Function(_i18.NavigationFailure)? onFailure}) async {
    return navigateTo(
      const PartnersViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> navigateToActionInfoView({
    _i20.Key? key,
    required int actionId,
    void Function(_i18.NavigationFailure)? onFailure,
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
    required _i21.ListCampaign listCampaign,
    void Function(_i18.NavigationFailure)? onFailure,
  }) async {
    return navigateTo(
      CampaignInfoViewRoute(
        listCampaign: listCampaign,
      ),
      onFailure: onFailure,
    );
  }

  Future<dynamic> navigateToFaqView(
      {void Function(_i18.NavigationFailure)? onFailure}) async {
    return navigateTo(
      const FaqViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> navigateToIntroView(
      {void Function(_i18.NavigationFailure)? onFailure}) async {
    return navigateTo(
      const IntroViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> navigateToProfileSetupView(
      {void Function(_i18.NavigationFailure)? onFailure}) async {
    return navigateTo(
      const ProfileSetupViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> navigateToLoginView(
      {void Function(_i18.NavigationFailure)? onFailure}) async {
    return navigateTo(
      const LoginViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> navigateToLoginCodeView({
    _i20.Key? key,
    required String email,
    void Function(_i18.NavigationFailure)? onFailure,
  }) async {
    return navigateTo(
      LoginCodeViewRoute(
        key: key,
        email: email,
      ),
      onFailure: onFailure,
    );
  }

  Future<dynamic> navigateToLoginEmailSentView({
    _i20.Key? key,
    required String email,
    String? token,
    void Function(_i18.NavigationFailure)? onFailure,
  }) async {
    return navigateTo(
      LoginEmailSentViewRoute(
        key: key,
        email: email,
        token: token,
      ),
      onFailure: onFailure,
    );
  }

  Future<dynamic> navigateToChangeSelectCausesView(
      {void Function(_i18.NavigationFailure)? onFailure}) async {
    return navigateTo(
      const ChangeSelectCausesViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> navigateToOnboardingSelectCausesView(
      {void Function(_i18.NavigationFailure)? onFailure}) async {
    return navigateTo(
      const OnboardingSelectCausesViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> navigateToTabsView({
    _i14.TabPage? initialPage,
    _i22.BaseResourceSearchFilter? explorePageBaseFilter,
    void Function(_i18.NavigationFailure)? onFailure,
  }) async {
    return navigateTo(
      TabsViewRoute(
        initialPage: initialPage,
        explorePageBaseFilter: explorePageBaseFilter,
      ),
      onFailure: onFailure,
    );
  }

  Future<dynamic> navigateToPartnerInfoView({
    _i20.Key? key,
    required _i23.Organisation organisation,
    void Function(_i18.NavigationFailure)? onFailure,
  }) async {
    return navigateTo(
      PartnerInfoViewRoute(
        key: key,
        organisation: organisation,
      ),
      onFailure: onFailure,
    );
  }

  Future<dynamic> navigateToNotificationInfoView({
    required _i24.InternalNotification notification,
    void Function(_i18.NavigationFailure)? onFailure,
  }) async {
    return navigateTo(
      NotificationInfoViewRoute(
        notification: notification,
      ),
      onFailure: onFailure,
    );
  }

  Future<dynamic> replaceWithStartupView(
      {void Function(_i18.NavigationFailure)? onFailure}) async {
    return replaceWith(
      const StartupViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> replaceWithSearchView({
    _i20.Key? key,
    void Function(_i18.NavigationFailure)? onFailure,
  }) async {
    return replaceWith(
      SearchViewRoute(
        key: key,
      ),
      onFailure: onFailure,
    );
  }

  Future<dynamic> replaceWithPartnersView(
      {void Function(_i18.NavigationFailure)? onFailure}) async {
    return replaceWith(
      const PartnersViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> replaceWithActionInfoView({
    _i20.Key? key,
    required int actionId,
    void Function(_i18.NavigationFailure)? onFailure,
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
    required _i21.ListCampaign listCampaign,
    void Function(_i18.NavigationFailure)? onFailure,
  }) async {
    return replaceWith(
      CampaignInfoViewRoute(
        listCampaign: listCampaign,
      ),
      onFailure: onFailure,
    );
  }

  Future<dynamic> replaceWithFaqView(
      {void Function(_i18.NavigationFailure)? onFailure}) async {
    return replaceWith(
      const FaqViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> replaceWithIntroView(
      {void Function(_i18.NavigationFailure)? onFailure}) async {
    return replaceWith(
      const IntroViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> replaceWithProfileSetupView(
      {void Function(_i18.NavigationFailure)? onFailure}) async {
    return replaceWith(
      const ProfileSetupViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> replaceWithLoginView(
      {void Function(_i18.NavigationFailure)? onFailure}) async {
    return replaceWith(
      const LoginViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> replaceWithLoginCodeView({
    _i20.Key? key,
    required String email,
    void Function(_i18.NavigationFailure)? onFailure,
  }) async {
    return replaceWith(
      LoginCodeViewRoute(
        key: key,
        email: email,
      ),
      onFailure: onFailure,
    );
  }

  Future<dynamic> replaceWithLoginEmailSentView({
    _i20.Key? key,
    required String email,
    String? token,
    void Function(_i18.NavigationFailure)? onFailure,
  }) async {
    return replaceWith(
      LoginEmailSentViewRoute(
        key: key,
        email: email,
        token: token,
      ),
      onFailure: onFailure,
    );
  }

  Future<dynamic> replaceWithChangeSelectCausesView(
      {void Function(_i18.NavigationFailure)? onFailure}) async {
    return replaceWith(
      const ChangeSelectCausesViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> replaceWithOnboardingSelectCausesView(
      {void Function(_i18.NavigationFailure)? onFailure}) async {
    return replaceWith(
      const OnboardingSelectCausesViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> replaceWithTabsView({
    _i14.TabPage? initialPage,
    _i22.BaseResourceSearchFilter? explorePageBaseFilter,
    void Function(_i18.NavigationFailure)? onFailure,
  }) async {
    return replaceWith(
      TabsViewRoute(
        initialPage: initialPage,
        explorePageBaseFilter: explorePageBaseFilter,
      ),
      onFailure: onFailure,
    );
  }

  Future<dynamic> replaceWithPartnerInfoView({
    _i20.Key? key,
    required _i23.Organisation organisation,
    void Function(_i18.NavigationFailure)? onFailure,
  }) async {
    return replaceWith(
      PartnerInfoViewRoute(
        key: key,
        organisation: organisation,
      ),
      onFailure: onFailure,
    );
  }

  Future<dynamic> replaceWithNotificationInfoView({
    required _i24.InternalNotification notification,
    void Function(_i18.NavigationFailure)? onFailure,
  }) async {
    return replaceWith(
      NotificationInfoViewRoute(
        notification: notification,
      ),
      onFailure: onFailure,
    );
  }
}

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedRouterGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter/foundation.dart' as _i17;
import 'package:flutter/material.dart' as _i16;
import 'package:stacked/stacked.dart' as _i15;
import 'package:stacked_services/stacked_services.dart' as _i14;

import '../models/Notification.dart' as _i20;
import '../services/causes_service.dart' as _i18;
import '../ui/views/action_info/action_info_view.dart' as _i2;
import '../ui/views/campaign_info/campaign_info_view.dart' as _i3;
import '../ui/views/causes_selection/change_view/change_select_causes_view.dart'
    as _i10;
import '../ui/views/causes_selection/onboarding_view/onboarding_select_causes_view.dart'
    as _i11;
import '../ui/views/explore/bloc/explore_filter_state.dart' as _i19;
import '../ui/views/faq/faq_view.dart' as _i4;
import '../ui/views/intro/intro_view.dart' as _i5;
import '../ui/views/login/login_view.dart' as _i7;
import '../ui/views/login_code/login_code_view.dart' as _i8;
import '../ui/views/login_email_sent/login_email_sent_view.dart' as _i9;
import '../ui/views/notification_info/notification_info_view.dart' as _i13;
import '../ui/views/profile_setup/profile_setup_view.dart' as _i6;
import '../ui/views/startup/startup_view.dart' as _i1;
import '../ui/views/tabs/tabs_view.dart' as _i12;

final stackedRouter =
    StackedRouterWeb(navigatorKey: _i14.StackedService.navigatorKey);

class StackedRouterWeb extends _i15.RootStackRouter {
  StackedRouterWeb({_i16.GlobalKey<_i16.NavigatorState>? navigatorKey})
      : super(navigatorKey);

  @override
  final Map<String, _i15.PageFactory> pagesMap = {
    StartupViewRoute.name: (routeData) {
      return _i15.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i1.StartupView(),
        opaque: true,
        barrierDismissible: false,
      );
    },
    ActionInfoViewRoute.name: (routeData) {
      final args = routeData.argsAs<ActionInfoViewArgs>();
      return _i15.CustomPage<dynamic>(
        routeData: routeData,
        child: _i2.ActionInfoView(
          key: args.key,
          actionId: args.actionId,
        ),
        opaque: true,
        barrierDismissible: false,
      );
    },
    CampaignInfoViewRoute.name: (routeData) {
      final args = routeData.argsAs<CampaignInfoViewArgs>();
      return _i15.CustomPage<dynamic>(
        routeData: routeData,
        child: _i3.CampaignInfoView(args.listCampaign),
        opaque: true,
        barrierDismissible: false,
      );
    },
    FaqViewRoute.name: (routeData) {
      return _i15.CustomPage<dynamic>(
        routeData: routeData,
        child: _i4.FaqView(),
        opaque: true,
        barrierDismissible: false,
      );
    },
    IntroViewRoute.name: (routeData) {
      return _i15.CustomPage<dynamic>(
        routeData: routeData,
        child: _i5.IntroView(),
        opaque: true,
        barrierDismissible: false,
      );
    },
    ProfileSetupViewRoute.name: (routeData) {
      return _i15.CustomPage<dynamic>(
        routeData: routeData,
        child: _i6.ProfileSetupView(),
        opaque: true,
        barrierDismissible: false,
      );
    },
    LoginViewRoute.name: (routeData) {
      return _i15.CustomPage<dynamic>(
        routeData: routeData,
        child: _i7.LoginView(),
        transitionsBuilder: _i15.TransitionsBuilders.fadeIn,
        opaque: true,
        barrierDismissible: false,
      );
    },
    LoginCodeViewRoute.name: (routeData) {
      final args = routeData.argsAs<LoginCodeViewArgs>();
      return _i15.CustomPage<dynamic>(
        routeData: routeData,
        child: _i8.LoginCodeView(
          key: args.key,
          email: args.email,
        ),
        opaque: true,
        barrierDismissible: false,
      );
    },
    LoginEmailSentViewRoute.name: (routeData) {
      final args = routeData.argsAs<LoginEmailSentViewArgs>();
      return _i15.CustomPage<dynamic>(
        routeData: routeData,
        child: _i9.LoginEmailSentView(
          key: args.key,
          email: args.email,
          token: args.token,
        ),
        opaque: true,
        barrierDismissible: false,
      );
    },
    ChangeSelectCausesViewRoute.name: (routeData) {
      return _i15.CustomPage<dynamic>(
        routeData: routeData,
        child: _i10.ChangeSelectCausesView(),
        opaque: true,
        barrierDismissible: false,
      );
    },
    OnboardingSelectCausesViewRoute.name: (routeData) {
      return _i15.CustomPage<dynamic>(
        routeData: routeData,
        child: _i11.OnboardingSelectCausesView(),
        opaque: true,
        barrierDismissible: false,
      );
    },
    TabsViewRoute.name: (routeData) {
      final args =
          routeData.argsAs<TabsViewArgs>(orElse: () => const TabsViewArgs());
      return _i15.CustomPage<dynamic>(
        routeData: routeData,
        child: _i12.TabsView(
          initialPage: args.initialPage,
          exploreFilterData: args.exploreFilterData,
        ),
        opaque: true,
        barrierDismissible: false,
      );
    },
    NotificationInfoViewRoute.name: (routeData) {
      final args = routeData.argsAs<NotificationInfoViewArgs>();
      return _i15.CustomPage<dynamic>(
        routeData: routeData,
        child: _i13.NotificationInfoView(notification: args.notification),
        opaque: true,
        barrierDismissible: false,
      );
    },
  };

  @override
  List<_i15.RouteConfig> get routes => [
        _i15.RouteConfig(
          StartupViewRoute.name,
          path: '/',
        ),
        _i15.RouteConfig(
          ActionInfoViewRoute.name,
          path: 'action/:actionId',
        ),
        _i15.RouteConfig(
          CampaignInfoViewRoute.name,
          path: '/campaign-info-view',
        ),
        _i15.RouteConfig(
          FaqViewRoute.name,
          path: '/faq-view',
        ),
        _i15.RouteConfig(
          IntroViewRoute.name,
          path: '/intro-view',
        ),
        _i15.RouteConfig(
          ProfileSetupViewRoute.name,
          path: '/profile-setup-view',
        ),
        _i15.RouteConfig(
          LoginViewRoute.name,
          path: '/login-view',
        ),
        _i15.RouteConfig(
          LoginCodeViewRoute.name,
          path: '/login-code-view',
        ),
        _i15.RouteConfig(
          LoginEmailSentViewRoute.name,
          path: '/login-email-sent-view',
        ),
        _i15.RouteConfig(
          ChangeSelectCausesViewRoute.name,
          path: '/change-select-causes-view',
        ),
        _i15.RouteConfig(
          OnboardingSelectCausesViewRoute.name,
          path: '/onboarding-select-causes-view',
        ),
        _i15.RouteConfig(
          TabsViewRoute.name,
          path: '/tabs-view',
        ),
        _i15.RouteConfig(
          NotificationInfoViewRoute.name,
          path: '/notification-info-view',
        ),
      ];
}

/// generated route for
/// [_i1.StartupView]
class StartupViewRoute extends _i15.PageRouteInfo<void> {
  const StartupViewRoute()
      : super(
          StartupViewRoute.name,
          path: '/',
        );

  static const String name = 'StartupView';
}

/// generated route for
/// [_i2.ActionInfoView]
class ActionInfoViewRoute extends _i15.PageRouteInfo<ActionInfoViewArgs> {
  ActionInfoViewRoute({
    _i17.Key? key,
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

  final _i17.Key? key;

  final int actionId;

  @override
  String toString() {
    return 'ActionInfoViewArgs{key: $key, actionId: $actionId}';
  }
}

/// generated route for
/// [_i3.CampaignInfoView]
class CampaignInfoViewRoute extends _i15.PageRouteInfo<CampaignInfoViewArgs> {
  CampaignInfoViewRoute({required _i18.ListCampaign listCampaign})
      : super(
          CampaignInfoViewRoute.name,
          path: '/campaign-info-view',
          args: CampaignInfoViewArgs(listCampaign: listCampaign),
        );

  static const String name = 'CampaignInfoView';
}

class CampaignInfoViewArgs {
  const CampaignInfoViewArgs({required this.listCampaign});

  final _i18.ListCampaign listCampaign;

  @override
  String toString() {
    return 'CampaignInfoViewArgs{listCampaign: $listCampaign}';
  }
}

/// generated route for
/// [_i4.FaqView]
class FaqViewRoute extends _i15.PageRouteInfo<void> {
  const FaqViewRoute()
      : super(
          FaqViewRoute.name,
          path: '/faq-view',
        );

  static const String name = 'FaqView';
}

/// generated route for
/// [_i5.IntroView]
class IntroViewRoute extends _i15.PageRouteInfo<void> {
  const IntroViewRoute()
      : super(
          IntroViewRoute.name,
          path: '/intro-view',
        );

  static const String name = 'IntroView';
}

/// generated route for
/// [_i6.ProfileSetupView]
class ProfileSetupViewRoute extends _i15.PageRouteInfo<void> {
  const ProfileSetupViewRoute()
      : super(
          ProfileSetupViewRoute.name,
          path: '/profile-setup-view',
        );

  static const String name = 'ProfileSetupView';
}

/// generated route for
/// [_i7.LoginView]
class LoginViewRoute extends _i15.PageRouteInfo<void> {
  const LoginViewRoute()
      : super(
          LoginViewRoute.name,
          path: '/login-view',
        );

  static const String name = 'LoginView';
}

/// generated route for
/// [_i8.LoginCodeView]
class LoginCodeViewRoute extends _i15.PageRouteInfo<LoginCodeViewArgs> {
  LoginCodeViewRoute({
    _i17.Key? key,
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

  final _i17.Key? key;

  final String email;

  @override
  String toString() {
    return 'LoginCodeViewArgs{key: $key, email: $email}';
  }
}

/// generated route for
/// [_i9.LoginEmailSentView]
class LoginEmailSentViewRoute
    extends _i15.PageRouteInfo<LoginEmailSentViewArgs> {
  LoginEmailSentViewRoute({
    _i17.Key? key,
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

  final _i17.Key? key;

  final String email;

  final String? token;

  @override
  String toString() {
    return 'LoginEmailSentViewArgs{key: $key, email: $email, token: $token}';
  }
}

/// generated route for
/// [_i10.ChangeSelectCausesView]
class ChangeSelectCausesViewRoute extends _i15.PageRouteInfo<void> {
  const ChangeSelectCausesViewRoute()
      : super(
          ChangeSelectCausesViewRoute.name,
          path: '/change-select-causes-view',
        );

  static const String name = 'ChangeSelectCausesView';
}

/// generated route for
/// [_i11.OnboardingSelectCausesView]
class OnboardingSelectCausesViewRoute extends _i15.PageRouteInfo<void> {
  const OnboardingSelectCausesViewRoute()
      : super(
          OnboardingSelectCausesViewRoute.name,
          path: '/onboarding-select-causes-view',
        );

  static const String name = 'OnboardingSelectCausesView';
}

/// generated route for
/// [_i12.TabsView]
class TabsViewRoute extends _i15.PageRouteInfo<TabsViewArgs> {
  TabsViewRoute({
    _i12.TabPage? initialPage,
    _i19.ExplorePageFilterData? exploreFilterData,
  }) : super(
          TabsViewRoute.name,
          path: '/tabs-view',
          args: TabsViewArgs(
            initialPage: initialPage,
            exploreFilterData: exploreFilterData,
          ),
        );

  static const String name = 'TabsView';
}

class TabsViewArgs {
  const TabsViewArgs({
    this.initialPage,
    this.exploreFilterData,
  });

  final _i12.TabPage? initialPage;

  final _i19.ExplorePageFilterData? exploreFilterData;

  @override
  String toString() {
    return 'TabsViewArgs{initialPage: $initialPage, exploreFilterData: $exploreFilterData}';
  }
}

/// generated route for
/// [_i13.NotificationInfoView]
class NotificationInfoViewRoute
    extends _i15.PageRouteInfo<NotificationInfoViewArgs> {
  NotificationInfoViewRoute({required _i20.InternalNotification notification})
      : super(
          NotificationInfoViewRoute.name,
          path: '/notification-info-view',
          args: NotificationInfoViewArgs(notification: notification),
        );

  static const String name = 'NotificationInfoView';
}

class NotificationInfoViewArgs {
  const NotificationInfoViewArgs({required this.notification});

  final _i20.InternalNotification notification;

  @override
  String toString() {
    return 'NotificationInfoViewArgs{notification: $notification}';
  }
}

extension RouterStateExtension on _i14.RouterService {
  Future<dynamic> navigateToStartupView(
      {void Function(_i15.NavigationFailure)? onFailure}) async {
    return navigateTo(
      const StartupViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> navigateToActionInfoView({
    _i17.Key? key,
    required int actionId,
    void Function(_i15.NavigationFailure)? onFailure,
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
    required _i18.ListCampaign listCampaign,
    void Function(_i15.NavigationFailure)? onFailure,
  }) async {
    return navigateTo(
      CampaignInfoViewRoute(
        listCampaign: listCampaign,
      ),
      onFailure: onFailure,
    );
  }

  Future<dynamic> navigateToFaqView(
      {void Function(_i15.NavigationFailure)? onFailure}) async {
    return navigateTo(
      const FaqViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> navigateToIntroView(
      {void Function(_i15.NavigationFailure)? onFailure}) async {
    return navigateTo(
      const IntroViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> navigateToProfileSetupView(
      {void Function(_i15.NavigationFailure)? onFailure}) async {
    return navigateTo(
      const ProfileSetupViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> navigateToLoginView(
      {void Function(_i15.NavigationFailure)? onFailure}) async {
    return navigateTo(
      const LoginViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> navigateToLoginCodeView({
    _i17.Key? key,
    required String email,
    void Function(_i15.NavigationFailure)? onFailure,
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
    _i17.Key? key,
    required String email,
    String? token,
    void Function(_i15.NavigationFailure)? onFailure,
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
      {void Function(_i15.NavigationFailure)? onFailure}) async {
    return navigateTo(
      const ChangeSelectCausesViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> navigateToOnboardingSelectCausesView(
      {void Function(_i15.NavigationFailure)? onFailure}) async {
    return navigateTo(
      const OnboardingSelectCausesViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> navigateToTabsView({
    _i12.TabPage? initialPage,
    _i19.ExplorePageFilterData? exploreFilterData,
    void Function(_i15.NavigationFailure)? onFailure,
  }) async {
    return navigateTo(
      TabsViewRoute(
        initialPage: initialPage,
        exploreFilterData: exploreFilterData,
      ),
      onFailure: onFailure,
    );
  }

  Future<dynamic> navigateToNotificationInfoView({
    required _i20.InternalNotification notification,
    void Function(_i15.NavigationFailure)? onFailure,
  }) async {
    return navigateTo(
      NotificationInfoViewRoute(
        notification: notification,
      ),
      onFailure: onFailure,
    );
  }

  Future<dynamic> replaceWithStartupView(
      {void Function(_i15.NavigationFailure)? onFailure}) async {
    return replaceWith(
      const StartupViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> replaceWithActionInfoView({
    _i17.Key? key,
    required int actionId,
    void Function(_i15.NavigationFailure)? onFailure,
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
    required _i18.ListCampaign listCampaign,
    void Function(_i15.NavigationFailure)? onFailure,
  }) async {
    return replaceWith(
      CampaignInfoViewRoute(
        listCampaign: listCampaign,
      ),
      onFailure: onFailure,
    );
  }

  Future<dynamic> replaceWithFaqView(
      {void Function(_i15.NavigationFailure)? onFailure}) async {
    return replaceWith(
      const FaqViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> replaceWithIntroView(
      {void Function(_i15.NavigationFailure)? onFailure}) async {
    return replaceWith(
      const IntroViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> replaceWithProfileSetupView(
      {void Function(_i15.NavigationFailure)? onFailure}) async {
    return replaceWith(
      const ProfileSetupViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> replaceWithLoginView(
      {void Function(_i15.NavigationFailure)? onFailure}) async {
    return replaceWith(
      const LoginViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> replaceWithLoginCodeView({
    _i17.Key? key,
    required String email,
    void Function(_i15.NavigationFailure)? onFailure,
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
    _i17.Key? key,
    required String email,
    String? token,
    void Function(_i15.NavigationFailure)? onFailure,
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
      {void Function(_i15.NavigationFailure)? onFailure}) async {
    return replaceWith(
      const ChangeSelectCausesViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> replaceWithOnboardingSelectCausesView(
      {void Function(_i15.NavigationFailure)? onFailure}) async {
    return replaceWith(
      const OnboardingSelectCausesViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> replaceWithTabsView({
    _i12.TabPage? initialPage,
    _i19.ExplorePageFilterData? exploreFilterData,
    void Function(_i15.NavigationFailure)? onFailure,
  }) async {
    return replaceWith(
      TabsViewRoute(
        initialPage: initialPage,
        exploreFilterData: exploreFilterData,
      ),
      onFailure: onFailure,
    );
  }

  Future<dynamic> replaceWithNotificationInfoView({
    required _i20.InternalNotification notification,
    void Function(_i15.NavigationFailure)? onFailure,
  }) async {
    return replaceWith(
      NotificationInfoViewRoute(
        notification: notification,
      ),
      onFailure: onFailure,
    );
  }
}

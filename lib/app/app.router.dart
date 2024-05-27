// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedRouterGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter/foundation.dart' as _i18;
import 'package:flutter/material.dart' as _i17;
import 'package:stacked/stacked.dart' as _i16;
import 'package:stacked_services/stacked_services.dart' as _i15;

import '../models/Notification.dart' as _i21;
import '../services/causes_service.dart' as _i19;
import '../ui/views/action_info/action_info_view.dart' as _i2;
import '../ui/views/campaign_info/campaign_info_view.dart' as _i3;
import '../ui/views/causes_selection/change_view/change_select_causes_view.dart'
    as _i10;
import '../ui/views/causes_selection/onboarding_view/onboarding_select_causes_view.dart'
    as _i11;
import '../ui/views/delete_account/delete_account_view.dart' as _i14;
import '../ui/views/explore/explore_page_viewmodel.dart' as _i20;
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
    StackedRouterWeb(navigatorKey: _i15.StackedService.navigatorKey);

class StackedRouterWeb extends _i16.RootStackRouter {
  StackedRouterWeb({_i17.GlobalKey<_i17.NavigatorState>? navigatorKey})
      : super(navigatorKey);

  @override
  final Map<String, _i16.PageFactory> pagesMap = {
    StartupViewRoute.name: (routeData) {
      return _i16.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i1.StartupView(),
        opaque: true,
        barrierDismissible: false,
      );
    },
    ActionInfoViewRoute.name: (routeData) {
      final args = routeData.argsAs<ActionInfoViewArgs>();
      return _i16.CustomPage<dynamic>(
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
      return _i16.CustomPage<dynamic>(
        routeData: routeData,
        child: _i3.CampaignInfoView(args.listCampaign),
        opaque: true,
        barrierDismissible: false,
      );
    },
    FaqViewRoute.name: (routeData) {
      return _i16.CustomPage<dynamic>(
        routeData: routeData,
        child: _i4.FaqView(),
        opaque: true,
        barrierDismissible: false,
      );
    },
    IntroViewRoute.name: (routeData) {
      return _i16.CustomPage<dynamic>(
        routeData: routeData,
        child: _i5.IntroView(),
        opaque: true,
        barrierDismissible: false,
      );
    },
    ProfileSetupViewRoute.name: (routeData) {
      return _i16.CustomPage<dynamic>(
        routeData: routeData,
        child: _i6.ProfileSetupView(),
        opaque: true,
        barrierDismissible: false,
      );
    },
    LoginViewRoute.name: (routeData) {
      return _i16.CustomPage<dynamic>(
        routeData: routeData,
        child: _i7.LoginView(),
        transitionsBuilder: _i16.TransitionsBuilders.fadeIn,
        opaque: true,
        barrierDismissible: false,
      );
    },
    LoginCodeViewRoute.name: (routeData) {
      final args = routeData.argsAs<LoginCodeViewArgs>();
      return _i16.CustomPage<dynamic>(
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
      return _i16.CustomPage<dynamic>(
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
      return _i16.CustomPage<dynamic>(
        routeData: routeData,
        child: _i10.ChangeSelectCausesView(),
        opaque: true,
        barrierDismissible: false,
      );
    },
    OnboardingSelectCausesViewRoute.name: (routeData) {
      return _i16.CustomPage<dynamic>(
        routeData: routeData,
        child: _i11.OnboardingSelectCausesView(),
        opaque: true,
        barrierDismissible: false,
      );
    },
    TabsViewRoute.name: (routeData) {
      final args =
          routeData.argsAs<TabsViewArgs>(orElse: () => const TabsViewArgs());
      return _i16.CustomPage<dynamic>(
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
      return _i16.CustomPage<dynamic>(
        routeData: routeData,
        child: _i13.NotificationInfoView(notification: args.notification),
        opaque: true,
        barrierDismissible: false,
      );
    },
    DeleteAccountViewRoute.name: (routeData) {
      return _i16.CustomPage<dynamic>(
        routeData: routeData,
        child: _i14.DeleteAccountView(),
        opaque: true,
        barrierDismissible: false,
      );
    },
  };

  @override
  List<_i16.RouteConfig> get routes => [
        _i16.RouteConfig(
          StartupViewRoute.name,
          path: '/',
        ),
        _i16.RouteConfig(
          ActionInfoViewRoute.name,
          path: 'action/:actionId',
        ),
        _i16.RouteConfig(
          CampaignInfoViewRoute.name,
          path: '/campaign-info-view',
        ),
        _i16.RouteConfig(
          FaqViewRoute.name,
          path: '/faq-view',
        ),
        _i16.RouteConfig(
          IntroViewRoute.name,
          path: '/intro-view',
        ),
        _i16.RouteConfig(
          ProfileSetupViewRoute.name,
          path: '/profile-setup-view',
        ),
        _i16.RouteConfig(
          LoginViewRoute.name,
          path: '/login-view',
        ),
        _i16.RouteConfig(
          LoginCodeViewRoute.name,
          path: '/login-code-view',
        ),
        _i16.RouteConfig(
          LoginEmailSentViewRoute.name,
          path: '/login-email-sent-view',
        ),
        _i16.RouteConfig(
          ChangeSelectCausesViewRoute.name,
          path: '/change-select-causes-view',
        ),
        _i16.RouteConfig(
          OnboardingSelectCausesViewRoute.name,
          path: '/onboarding-select-causes-view',
        ),
        _i16.RouteConfig(
          TabsViewRoute.name,
          path: '/tabs-view',
        ),
        _i16.RouteConfig(
          NotificationInfoViewRoute.name,
          path: '/notification-info-view',
        ),
        _i16.RouteConfig(
          DeleteAccountViewRoute.name,
          path: '/delete-account-view',
        ),
      ];
}

/// generated route for
/// [_i1.StartupView]
class StartupViewRoute extends _i16.PageRouteInfo<void> {
  const StartupViewRoute()
      : super(
          StartupViewRoute.name,
          path: '/',
        );

  static const String name = 'StartupView';
}

/// generated route for
/// [_i2.ActionInfoView]
class ActionInfoViewRoute extends _i16.PageRouteInfo<ActionInfoViewArgs> {
  ActionInfoViewRoute({
    _i18.Key? key,
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

  final _i18.Key? key;

  final int actionId;

  @override
  String toString() {
    return 'ActionInfoViewArgs{key: $key, actionId: $actionId}';
  }
}

/// generated route for
/// [_i3.CampaignInfoView]
class CampaignInfoViewRoute extends _i16.PageRouteInfo<CampaignInfoViewArgs> {
  CampaignInfoViewRoute({required _i19.ListCampaign listCampaign})
      : super(
          CampaignInfoViewRoute.name,
          path: '/campaign-info-view',
          args: CampaignInfoViewArgs(listCampaign: listCampaign),
        );

  static const String name = 'CampaignInfoView';
}

class CampaignInfoViewArgs {
  const CampaignInfoViewArgs({required this.listCampaign});

  final _i19.ListCampaign listCampaign;

  @override
  String toString() {
    return 'CampaignInfoViewArgs{listCampaign: $listCampaign}';
  }
}

/// generated route for
/// [_i4.FaqView]
class FaqViewRoute extends _i16.PageRouteInfo<void> {
  const FaqViewRoute()
      : super(
          FaqViewRoute.name,
          path: '/faq-view',
        );

  static const String name = 'FaqView';
}

/// generated route for
/// [_i5.IntroView]
class IntroViewRoute extends _i16.PageRouteInfo<void> {
  const IntroViewRoute()
      : super(
          IntroViewRoute.name,
          path: '/intro-view',
        );

  static const String name = 'IntroView';
}

/// generated route for
/// [_i6.ProfileSetupView]
class ProfileSetupViewRoute extends _i16.PageRouteInfo<void> {
  const ProfileSetupViewRoute()
      : super(
          ProfileSetupViewRoute.name,
          path: '/profile-setup-view',
        );

  static const String name = 'ProfileSetupView';
}

/// generated route for
/// [_i7.LoginView]
class LoginViewRoute extends _i16.PageRouteInfo<void> {
  const LoginViewRoute()
      : super(
          LoginViewRoute.name,
          path: '/login-view',
        );

  static const String name = 'LoginView';
}

/// generated route for
/// [_i8.LoginCodeView]
class LoginCodeViewRoute extends _i16.PageRouteInfo<LoginCodeViewArgs> {
  LoginCodeViewRoute({
    _i18.Key? key,
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

  final _i18.Key? key;

  final String email;

  @override
  String toString() {
    return 'LoginCodeViewArgs{key: $key, email: $email}';
  }
}

/// generated route for
/// [_i9.LoginEmailSentView]
class LoginEmailSentViewRoute
    extends _i16.PageRouteInfo<LoginEmailSentViewArgs> {
  LoginEmailSentViewRoute({
    _i18.Key? key,
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

  final _i18.Key? key;

  final String email;

  final String? token;

  @override
  String toString() {
    return 'LoginEmailSentViewArgs{key: $key, email: $email, token: $token}';
  }
}

/// generated route for
/// [_i10.ChangeSelectCausesView]
class ChangeSelectCausesViewRoute extends _i16.PageRouteInfo<void> {
  const ChangeSelectCausesViewRoute()
      : super(
          ChangeSelectCausesViewRoute.name,
          path: '/change-select-causes-view',
        );

  static const String name = 'ChangeSelectCausesView';
}

/// generated route for
/// [_i11.OnboardingSelectCausesView]
class OnboardingSelectCausesViewRoute extends _i16.PageRouteInfo<void> {
  const OnboardingSelectCausesViewRoute()
      : super(
          OnboardingSelectCausesViewRoute.name,
          path: '/onboarding-select-causes-view',
        );

  static const String name = 'OnboardingSelectCausesView';
}

/// generated route for
/// [_i12.TabsView]
class TabsViewRoute extends _i16.PageRouteInfo<TabsViewArgs> {
  TabsViewRoute({
    _i12.TabPage? initialPage,
    _i20.ExplorePageFilterData? exploreFilterData,
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

  final _i20.ExplorePageFilterData? exploreFilterData;

  @override
  String toString() {
    return 'TabsViewArgs{initialPage: $initialPage, exploreFilterData: $exploreFilterData}';
  }
}

/// generated route for
/// [_i13.NotificationInfoView]
class NotificationInfoViewRoute
    extends _i16.PageRouteInfo<NotificationInfoViewArgs> {
  NotificationInfoViewRoute({required _i21.InternalNotification notification})
      : super(
          NotificationInfoViewRoute.name,
          path: '/notification-info-view',
          args: NotificationInfoViewArgs(notification: notification),
        );

  static const String name = 'NotificationInfoView';
}

class NotificationInfoViewArgs {
  const NotificationInfoViewArgs({required this.notification});

  final _i21.InternalNotification notification;

  @override
  String toString() {
    return 'NotificationInfoViewArgs{notification: $notification}';
  }
}

/// generated route for
/// [_i14.DeleteAccountView]
class DeleteAccountViewRoute extends _i16.PageRouteInfo<void> {
  const DeleteAccountViewRoute()
      : super(
          DeleteAccountViewRoute.name,
          path: '/delete-account-view',
        );

  static const String name = 'DeleteAccountView';
}

extension RouterStateExtension on _i15.RouterService {
  Future<dynamic> navigateToStartupView(
      {void Function(_i16.NavigationFailure)? onFailure}) async {
    return navigateTo(
      const StartupViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> navigateToActionInfoView({
    _i18.Key? key,
    required int actionId,
    void Function(_i16.NavigationFailure)? onFailure,
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
    required _i19.ListCampaign listCampaign,
    void Function(_i16.NavigationFailure)? onFailure,
  }) async {
    return navigateTo(
      CampaignInfoViewRoute(
        listCampaign: listCampaign,
      ),
      onFailure: onFailure,
    );
  }

  Future<dynamic> navigateToFaqView(
      {void Function(_i16.NavigationFailure)? onFailure}) async {
    return navigateTo(
      const FaqViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> navigateToIntroView(
      {void Function(_i16.NavigationFailure)? onFailure}) async {
    return navigateTo(
      const IntroViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> navigateToProfileSetupView(
      {void Function(_i16.NavigationFailure)? onFailure}) async {
    return navigateTo(
      const ProfileSetupViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> navigateToLoginView(
      {void Function(_i16.NavigationFailure)? onFailure}) async {
    return navigateTo(
      const LoginViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> navigateToLoginCodeView({
    _i18.Key? key,
    required String email,
    void Function(_i16.NavigationFailure)? onFailure,
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
    _i18.Key? key,
    required String email,
    String? token,
    void Function(_i16.NavigationFailure)? onFailure,
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
      {void Function(_i16.NavigationFailure)? onFailure}) async {
    return navigateTo(
      const ChangeSelectCausesViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> navigateToOnboardingSelectCausesView(
      {void Function(_i16.NavigationFailure)? onFailure}) async {
    return navigateTo(
      const OnboardingSelectCausesViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> navigateToTabsView({
    _i12.TabPage? initialPage,
    _i20.ExplorePageFilterData? exploreFilterData,
    void Function(_i16.NavigationFailure)? onFailure,
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
    required _i21.InternalNotification notification,
    void Function(_i16.NavigationFailure)? onFailure,
  }) async {
    return navigateTo(
      NotificationInfoViewRoute(
        notification: notification,
      ),
      onFailure: onFailure,
    );
  }

  Future<dynamic> navigateToDeleteAccountView(
      {void Function(_i16.NavigationFailure)? onFailure}) async {
    return navigateTo(
      const DeleteAccountViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> replaceWithStartupView(
      {void Function(_i16.NavigationFailure)? onFailure}) async {
    return replaceWith(
      const StartupViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> replaceWithActionInfoView({
    _i18.Key? key,
    required int actionId,
    void Function(_i16.NavigationFailure)? onFailure,
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
    required _i19.ListCampaign listCampaign,
    void Function(_i16.NavigationFailure)? onFailure,
  }) async {
    return replaceWith(
      CampaignInfoViewRoute(
        listCampaign: listCampaign,
      ),
      onFailure: onFailure,
    );
  }

  Future<dynamic> replaceWithFaqView(
      {void Function(_i16.NavigationFailure)? onFailure}) async {
    return replaceWith(
      const FaqViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> replaceWithIntroView(
      {void Function(_i16.NavigationFailure)? onFailure}) async {
    return replaceWith(
      const IntroViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> replaceWithProfileSetupView(
      {void Function(_i16.NavigationFailure)? onFailure}) async {
    return replaceWith(
      const ProfileSetupViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> replaceWithLoginView(
      {void Function(_i16.NavigationFailure)? onFailure}) async {
    return replaceWith(
      const LoginViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> replaceWithLoginCodeView({
    _i18.Key? key,
    required String email,
    void Function(_i16.NavigationFailure)? onFailure,
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
    _i18.Key? key,
    required String email,
    String? token,
    void Function(_i16.NavigationFailure)? onFailure,
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
      {void Function(_i16.NavigationFailure)? onFailure}) async {
    return replaceWith(
      const ChangeSelectCausesViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> replaceWithOnboardingSelectCausesView(
      {void Function(_i16.NavigationFailure)? onFailure}) async {
    return replaceWith(
      const OnboardingSelectCausesViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> replaceWithTabsView({
    _i12.TabPage? initialPage,
    _i20.ExplorePageFilterData? exploreFilterData,
    void Function(_i16.NavigationFailure)? onFailure,
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
    required _i21.InternalNotification notification,
    void Function(_i16.NavigationFailure)? onFailure,
  }) async {
    return replaceWith(
      NotificationInfoViewRoute(
        notification: notification,
      ),
      onFailure: onFailure,
    );
  }

  Future<dynamic> replaceWithDeleteAccountView(
      {void Function(_i16.NavigationFailure)? onFailure}) async {
    return replaceWith(
      const DeleteAccountViewRoute(),
      onFailure: onFailure,
    );
  }
}

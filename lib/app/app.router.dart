// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedNavigatorGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:causeApiClient/causeApiClient.dart' as _i21;
import 'package:flutter/foundation.dart' as _i18;
import 'package:flutter/material.dart' as _i17;
import 'package:flutter/material.dart';
import 'package:nowu/models/Notification.dart' as _i22;
import 'package:nowu/services/causes_service.dart' as _i19;
import 'package:nowu/ui/views/action_info/action_info_view.dart' as _i4;
import 'package:nowu/ui/views/campaign_info/campaign_info_view.dart' as _i5;
import 'package:nowu/ui/views/causes_selection/change_view/change_select_causes_view.dart'
    as _i12;
import 'package:nowu/ui/views/causes_selection/onboarding_view/onboarding_select_causes_view.dart'
    as _i13;
import 'package:nowu/ui/views/explore/explore_page_viewmodel.dart' as _i20;
import 'package:nowu/ui/views/faq/faq_view.dart' as _i6;
import 'package:nowu/ui/views/intro/intro_view.dart' as _i7;
import 'package:nowu/ui/views/login/login_view.dart' as _i9;
import 'package:nowu/ui/views/login_code/login_code_view.dart' as _i10;
import 'package:nowu/ui/views/login_email_sent/login_email_sent_view.dart'
    as _i11;
import 'package:nowu/ui/views/notification_info/notification_info_view.dart'
    as _i16;
import 'package:nowu/ui/views/partner_info/partner_info_view.dart' as _i15;
import 'package:nowu/ui/views/partners/partners_view.dart' as _i3;
import 'package:nowu/ui/views/profile_setup/profile_setup_view.dart' as _i8;
import 'package:nowu/ui/views/startup/startup_view.dart' as _i2;
import 'package:nowu/ui/views/tabs/tabs_view.dart' as _i14;
import 'package:stacked/stacked.dart' as _i1;
import 'package:stacked_services/stacked_services.dart' as _i23;

class Routes {
  static const startupView = '/';

  static const partnersView = '/partners-view';

  static const actionInfoView = '/action-info-view';

  static const campaignInfoView = '/campaign-info-view';

  static const faqView = '/faq-view';

  static const introView = '/intro-view';

  static const profileSetupView = '/profile-setup-view';

  static const loginView = '/login-view';

  static const loginCodeView = '/login-code-view';

  static const loginEmailSentView = '/login-email-sent-view';

  static const changeSelectCausesView = '/change-select-causes-view';

  static const onboardingSelectCausesView = '/onboarding-select-causes-view';

  static const tabsView = '/tabs-view';

  static const partnerInfoView = '/partner-info-view';

  static const notificationInfoView = '/notification-info-view';

  static const all = <String>{
    startupView,
    partnersView,
    actionInfoView,
    campaignInfoView,
    faqView,
    introView,
    profileSetupView,
    loginView,
    loginCodeView,
    loginEmailSentView,
    changeSelectCausesView,
    onboardingSelectCausesView,
    tabsView,
    partnerInfoView,
    notificationInfoView,
  };
}

class StackedRouter extends _i1.RouterBase {
  final _routes = <_i1.RouteDef>[
    _i1.RouteDef(
      Routes.startupView,
      page: _i2.StartupView,
    ),
    _i1.RouteDef(
      Routes.partnersView,
      page: _i3.PartnersView,
    ),
    _i1.RouteDef(
      Routes.actionInfoView,
      page: _i4.ActionInfoView,
    ),
    _i1.RouteDef(
      Routes.campaignInfoView,
      page: _i5.CampaignInfoView,
    ),
    _i1.RouteDef(
      Routes.faqView,
      page: _i6.FaqView,
    ),
    _i1.RouteDef(
      Routes.introView,
      page: _i7.IntroView,
    ),
    _i1.RouteDef(
      Routes.profileSetupView,
      page: _i8.ProfileSetupView,
    ),
    _i1.RouteDef(
      Routes.loginView,
      page: _i9.LoginView,
    ),
    _i1.RouteDef(
      Routes.loginCodeView,
      page: _i10.LoginCodeView,
    ),
    _i1.RouteDef(
      Routes.loginEmailSentView,
      page: _i11.LoginEmailSentView,
    ),
    _i1.RouteDef(
      Routes.changeSelectCausesView,
      page: _i12.ChangeSelectCausesView,
    ),
    _i1.RouteDef(
      Routes.onboardingSelectCausesView,
      page: _i13.OnboardingSelectCausesView,
    ),
    _i1.RouteDef(
      Routes.tabsView,
      page: _i14.TabsView,
    ),
    _i1.RouteDef(
      Routes.partnerInfoView,
      page: _i15.PartnerInfoView,
    ),
    _i1.RouteDef(
      Routes.notificationInfoView,
      page: _i16.NotificationInfoView,
    ),
  ];

  final _pagesMap = <Type, _i1.StackedRouteFactory>{
    _i2.StartupView: (data) {
      return _i17.MaterialPageRoute<dynamic>(
        builder: (context) => const _i2.StartupView(),
        settings: data,
      );
    },
    _i3.PartnersView: (data) {
      return _i17.MaterialPageRoute<dynamic>(
        builder: (context) => _i3.PartnersView(),
        settings: data,
      );
    },
    _i4.ActionInfoView: (data) {
      final args = data.getArgs<ActionInfoViewArguments>(nullOk: false);
      return _i17.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i4.ActionInfoView(key: args.key, actionId: args.actionId),
        settings: data,
      );
    },
    _i5.CampaignInfoView: (data) {
      final args = data.getArgs<CampaignInfoViewArguments>(nullOk: false);
      return _i17.MaterialPageRoute<dynamic>(
        builder: (context) => _i5.CampaignInfoView(args.listCampaign),
        settings: data,
      );
    },
    _i6.FaqView: (data) {
      return _i17.MaterialPageRoute<dynamic>(
        builder: (context) => _i6.FaqView(),
        settings: data,
      );
    },
    _i7.IntroView: (data) {
      return _i17.MaterialPageRoute<dynamic>(
        builder: (context) => _i7.IntroView(),
        settings: data,
      );
    },
    _i8.ProfileSetupView: (data) {
      return _i17.MaterialPageRoute<dynamic>(
        builder: (context) => _i8.ProfileSetupView(),
        settings: data,
      );
    },
    _i9.LoginView: (data) {
      return _i17.MaterialPageRoute<dynamic>(
        builder: (context) => _i9.LoginView(),
        settings: data,
      );
    },
    _i10.LoginCodeView: (data) {
      final args = data.getArgs<LoginCodeViewArguments>(nullOk: false);
      return _i17.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i10.LoginCodeView(key: args.key, email: args.email),
        settings: data,
      );
    },
    _i11.LoginEmailSentView: (data) {
      final args = data.getArgs<LoginEmailSentViewArguments>(nullOk: false);
      return _i17.MaterialPageRoute<dynamic>(
        builder: (context) => _i11.LoginEmailSentView(
            key: args.key, email: args.email, token: args.token),
        settings: data,
      );
    },
    _i12.ChangeSelectCausesView: (data) {
      return _i17.MaterialPageRoute<dynamic>(
        builder: (context) => _i12.ChangeSelectCausesView(),
        settings: data,
      );
    },
    _i13.OnboardingSelectCausesView: (data) {
      return _i17.MaterialPageRoute<dynamic>(
        builder: (context) => _i13.OnboardingSelectCausesView(),
        settings: data,
      );
    },
    _i14.TabsView: (data) {
      final args = data.getArgs<TabsViewArguments>(
        orElse: () => const TabsViewArguments(),
      );
      return _i17.MaterialPageRoute<dynamic>(
        builder: (context) => _i14.TabsView(
            initialPage: args.initialPage,
            exploreFilterData: args.exploreFilterData),
        settings: data,
      );
    },
    _i15.PartnerInfoView: (data) {
      final args = data.getArgs<PartnerInfoViewArguments>(nullOk: false);
      return _i17.MaterialPageRoute<dynamic>(
        builder: (context) => _i15.PartnerInfoView(
            key: args.key, organisation: args.organisation),
        settings: data,
      );
    },
    _i16.NotificationInfoView: (data) {
      final args = data.getArgs<NotificationInfoViewArguments>(nullOk: false);
      return _i17.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i16.NotificationInfoView(notification: args.notification),
        settings: data,
      );
    },
  };

  @override
  List<_i1.RouteDef> get routes => _routes;

  @override
  Map<Type, _i1.StackedRouteFactory> get pagesMap => _pagesMap;
}

class ActionInfoViewArguments {
  const ActionInfoViewArguments({
    this.key,
    required this.actionId,
  });

  final _i18.Key? key;

  final int actionId;

  @override
  String toString() {
    return '{"key": "$key", "actionId": "$actionId"}';
  }

  @override
  bool operator ==(covariant ActionInfoViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.actionId == actionId;
  }

  @override
  int get hashCode {
    return key.hashCode ^ actionId.hashCode;
  }
}

class CampaignInfoViewArguments {
  const CampaignInfoViewArguments({required this.listCampaign});

  final _i19.ListCampaign listCampaign;

  @override
  String toString() {
    return '{"listCampaign": "$listCampaign"}';
  }

  @override
  bool operator ==(covariant CampaignInfoViewArguments other) {
    if (identical(this, other)) return true;
    return other.listCampaign == listCampaign;
  }

  @override
  int get hashCode {
    return listCampaign.hashCode;
  }
}

class LoginCodeViewArguments {
  const LoginCodeViewArguments({
    this.key,
    required this.email,
  });

  final _i18.Key? key;

  final String email;

  @override
  String toString() {
    return '{"key": "$key", "email": "$email"}';
  }

  @override
  bool operator ==(covariant LoginCodeViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.email == email;
  }

  @override
  int get hashCode {
    return key.hashCode ^ email.hashCode;
  }
}

class LoginEmailSentViewArguments {
  const LoginEmailSentViewArguments({
    this.key,
    required this.email,
    this.token,
  });

  final _i18.Key? key;

  final String email;

  final String? token;

  @override
  String toString() {
    return '{"key": "$key", "email": "$email", "token": "$token"}';
  }

  @override
  bool operator ==(covariant LoginEmailSentViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.email == email && other.token == token;
  }

  @override
  int get hashCode {
    return key.hashCode ^ email.hashCode ^ token.hashCode;
  }
}

class TabsViewArguments {
  const TabsViewArguments({
    this.initialPage,
    this.exploreFilterData,
  });

  final _i14.TabPage? initialPage;

  final _i20.ExplorePageFilterData? exploreFilterData;

  @override
  String toString() {
    return '{"initialPage": "$initialPage", "exploreFilterData": "$exploreFilterData"}';
  }

  @override
  bool operator ==(covariant TabsViewArguments other) {
    if (identical(this, other)) return true;
    return other.initialPage == initialPage &&
        other.exploreFilterData == exploreFilterData;
  }

  @override
  int get hashCode {
    return initialPage.hashCode ^ exploreFilterData.hashCode;
  }
}

class PartnerInfoViewArguments {
  const PartnerInfoViewArguments({
    this.key,
    required this.organisation,
  });

  final _i18.Key? key;

  final _i21.Organisation organisation;

  @override
  String toString() {
    return '{"key": "$key", "organisation": "$organisation"}';
  }

  @override
  bool operator ==(covariant PartnerInfoViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.organisation == organisation;
  }

  @override
  int get hashCode {
    return key.hashCode ^ organisation.hashCode;
  }
}

class NotificationInfoViewArguments {
  const NotificationInfoViewArguments({required this.notification});

  final _i22.InternalNotification notification;

  @override
  String toString() {
    return '{"notification": "$notification"}';
  }

  @override
  bool operator ==(covariant NotificationInfoViewArguments other) {
    if (identical(this, other)) return true;
    return other.notification == notification;
  }

  @override
  int get hashCode {
    return notification.hashCode;
  }
}

extension NavigatorStateExtension on _i23.NavigationService {
  Future<dynamic> navigateToStartupView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.startupView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToPartnersView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.partnersView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToActionInfoView({
    _i18.Key? key,
    required int actionId,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.actionInfoView,
        arguments: ActionInfoViewArguments(key: key, actionId: actionId),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToCampaignInfoView({
    required _i19.ListCampaign listCampaign,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.campaignInfoView,
        arguments: CampaignInfoViewArguments(listCampaign: listCampaign),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToFaqView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.faqView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToIntroView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.introView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToProfileSetupView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.profileSetupView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToLoginView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.loginView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToLoginCodeView({
    _i18.Key? key,
    required String email,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.loginCodeView,
        arguments: LoginCodeViewArguments(key: key, email: email),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToLoginEmailSentView({
    _i18.Key? key,
    required String email,
    String? token,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.loginEmailSentView,
        arguments:
            LoginEmailSentViewArguments(key: key, email: email, token: token),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToChangeSelectCausesView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.changeSelectCausesView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToOnboardingSelectCausesView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.onboardingSelectCausesView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToTabsView({
    _i14.TabPage? initialPage,
    _i20.ExplorePageFilterData? exploreFilterData,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.tabsView,
        arguments: TabsViewArguments(
            initialPage: initialPage, exploreFilterData: exploreFilterData),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToPartnerInfoView({
    _i18.Key? key,
    required _i21.Organisation organisation,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.partnerInfoView,
        arguments:
            PartnerInfoViewArguments(key: key, organisation: organisation),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToNotificationInfoView({
    required _i22.InternalNotification notification,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.notificationInfoView,
        arguments: NotificationInfoViewArguments(notification: notification),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithStartupView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.startupView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithPartnersView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.partnersView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithActionInfoView({
    _i18.Key? key,
    required int actionId,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.actionInfoView,
        arguments: ActionInfoViewArguments(key: key, actionId: actionId),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithCampaignInfoView({
    required _i19.ListCampaign listCampaign,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.campaignInfoView,
        arguments: CampaignInfoViewArguments(listCampaign: listCampaign),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithFaqView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.faqView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithIntroView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.introView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithProfileSetupView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.profileSetupView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithLoginView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.loginView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithLoginCodeView({
    _i18.Key? key,
    required String email,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.loginCodeView,
        arguments: LoginCodeViewArguments(key: key, email: email),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithLoginEmailSentView({
    _i18.Key? key,
    required String email,
    String? token,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.loginEmailSentView,
        arguments:
            LoginEmailSentViewArguments(key: key, email: email, token: token),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithChangeSelectCausesView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.changeSelectCausesView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithOnboardingSelectCausesView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.onboardingSelectCausesView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithTabsView({
    _i14.TabPage? initialPage,
    _i20.ExplorePageFilterData? exploreFilterData,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.tabsView,
        arguments: TabsViewArguments(
            initialPage: initialPage, exploreFilterData: exploreFilterData),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithPartnerInfoView({
    _i18.Key? key,
    required _i21.Organisation organisation,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.partnerInfoView,
        arguments:
            PartnerInfoViewArguments(key: key, organisation: organisation),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithNotificationInfoView({
    required _i22.InternalNotification notification,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.notificationInfoView,
        arguments: NotificationInfoViewArguments(notification: notification),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }
}

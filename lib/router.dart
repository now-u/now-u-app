import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:nowu/locator.dart';
import 'package:nowu/services/navigation_service.dart';
import 'package:nowu/ui/views/authentication/bloc/authentication_bloc.dart';
import 'package:nowu/ui/views/intro/intro_route_guard.dart';
import 'package:url_launcher/url_launcher.dart';

import 'router.gr.dart';

const postLoginInitialRouteFallback = HomeRoute();

extension AutoRouterXExtension on StackRouter {
  Future<void> pushNamedRouteWithFallback({
    required String? path,
    required PageRouteInfo fallback,
    bool clearHistroy = false,
  }) async {
    if (clearHistroy) {
      removeWhere((_) => true);
    }

    if (path == null) {
      await push(fallback);
    } else {
      await pushNamed(
        path,
        onFailure: (_) {
          push(fallback);
        },
      );
    }
  }
}

@AutoRouterConfig(replaceInRouteName: 'View|Tab,Route')
class AppRouter extends RootStackRouter {
  AuthenticationBloc _authBloc;

  AppRouter({
    required AuthenticationBloc authenticationBloc,
  }) : _authBloc = authenticationBloc;

  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          path: '/',
          guards: [IntroRouteGuard(authenticationBloc: _authBloc)],
          page: TabsRoute.page,
          children: [
            AutoRoute(path: 'home', page: HomeRoute.page, initial: true),
            AutoRoute(
              path: 'explore',
              page: ExploreRoute.page,
              children: [
                AutoRoute(path: 'all', page: ExploreAllRoute.page),
                AutoRoute(path: 'actions', page: ExploreActionRoute.page),
                AutoRoute(path: 'campaigns', page: ExploreCampaignRoute.page),
                AutoRoute(
                  path: 'learn',
                  page: ExploreLearningResourceRoute.page,
                ),
                AutoRoute(path: 'news', page: ExploreNewsArticleRoute.page),
              ],
            ),
            AutoRoute(path: 'more', page: MoreRoute.page),
          ],
        ),
        AutoRoute(path: '/intro', page: IntroRoute.page),
        AutoRoute(path: '/login', page: LoginRoute.page),
        AutoRoute(path: '/login/email_sent', page: LoginEmailSentRoute.page),
        AutoRoute(path: '/login/email_code', page: LoginCodeRoute.page),
        AutoRoute(path: '/login/email_code', page: LoginCodeRoute.page),
        AutoRoute(path: '/onboarding/profile', page: ProfileSetupRoute.page),
        AutoRoute(
          path: '/onboarding/causes',
          page: OnboardingSelectCausesRoute.page,
        ),
        AutoRoute(path: '/actions/:actionId', page: ActionInfoRoute.page),
        AutoRoute(path: '/campaigns/:campaignId', page: CampaignInfoRoute.page),
        AutoRoute(path: '/collaborations', page: PartnersRoute.page),
        AutoRoute(
          path: '/collaborations/:partnerId',
          page: PartnerInfoRoute.page,
        ),
        AutoRoute(path: '/faqs', page: FaqRoute.page),
        AutoRoute(path: '/delete_account', page: DeleteAccountRoute.page),
      ];

  Future<void> launchLink(Uri url, {bool isExternal = false}) async {
    await launchUrl(url, mode: LaunchMode.externalApplication);
    launchLinkExternal(this.navigatorKey.currentContext!, url);
  }
}

Future<void> launchLink(Uri url) async {
  if (kIsWeb) {
    await launchUrl(url, mode: LaunchMode.externalApplication);
  }

  final browser = locator<CustomChromeSafariBrowser>();
  browser.open(url: WebUri(url.toString()));
}

void launchLinkExternal(BuildContext context, Uri url) {
  launchUrl(url, mode: LaunchMode.externalApplication);
}

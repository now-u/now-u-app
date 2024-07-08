import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:nowu/locator.dart';
import 'package:nowu/services/navigation_service.dart';
import 'package:nowu/ui/dialogs/basic/basic_dialog.dart';
import 'package:url_launcher/url_launcher.dart';

import 'router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'View|Tab,Route')
class AppRouter extends $AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(path: '/', page: StartupRoute.page, initial: true),
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
        AutoRoute(
          path: '/',
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
                AutoRoute(path: 'learn', page: ExploreLearningResourceRoute.page),
                AutoRoute(path: 'news', page: ExploreNewsArticleRoute.page),
              ],
            ),
            AutoRoute(path: 'more', page: MoreRoute.page),
          ],
        ),
        AutoRoute(path: '/actions/:actionId', page: ActionInfoRoute.page),
        AutoRoute(path: '/campaigns/:campaignId', page: CampaignInfoRoute.page),
        AutoRoute(path: '/collaborations', page: PartnersRoute.page),
        AutoRoute(
          path: '/collaborations/:partnerId',
          page: PartnerInfoRoute.page,
        ),
        AutoRoute(path: '/faqs', page: FaqRoute.page),
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
  browser.open(url: url);
}

// TODO Move somewhere
void launchLinkExternal(BuildContext context, Uri url) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return BasicDialog(
        BasicDialogArgs(
          title: "You're about to leave",
          description:
              'This link will take you out of the app. Are you sure you want to go?',
          mainButtonArgs: BasicDialogButtonArgs(
            text: "Let's go",
            onClick: () async {
              context.router.maybePop();
              await launchUrl(url, mode: LaunchMode.externalApplication);
            },
          ),
          secondaryButtonArgs: BasicDialogButtonArgs(
            text: 'Close',
            onClick: () {
              context.router.maybePop();
            },
          ),
        ),
      );
    },
  );
}
